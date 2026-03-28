import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import '../../../core/services/verification_service.dart';
import '../../../routes/app_routes.dart';
import '../widgets/id_image_crop_page.dart';


enum IdCaptureStep { front, back, review }


class IdCaptureController extends GetxController {
  final _verificationService = Get.find<VerificationService>();
  final isCapturing = false.obs;

  final isInitialized = false.obs;

  // Image paths
  final frontImagePath = RxnString();
  final backImagePath = RxnString();

  // Current capture step
  final currentStep = IdCaptureStep.front.obs;

  CameraController? cameraController;


  @override
  void onInit() {
    super.onInit();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      return;
    }

    // Use the back camera for ID capture
    final backCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );

    cameraController = CameraController(
      backCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await cameraController!.initialize();
      isInitialized.value = true;
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  void captureDocument() async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return;
    }

    isCapturing.value = true;

    try {
      final XFile image = await cameraController!.takePicture();
      debugPrint('Captured image: ${image.path}');

      if (currentStep.value == IdCaptureStep.front) {
        frontImagePath.value = image.path;
      } else if (currentStep.value == IdCaptureStep.back) {
        backImagePath.value = image.path;
      }
    } catch (e) {
      debugPrint('Error capturing image: $e');
    } finally {
      isCapturing.value = false;
    }
  }

  void downloadDoc(String? imagePath, String side) async {
    if (imagePath != null) {
      debugPrint('Downloading $side document to gallery: $imagePath');
      try {
        await Gal.putImage(imagePath);
        Get.snackbar(
          'Success',
          '$side ID photo saved to your gallery',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF44DDC2).withValues(alpha: 0.2),
          colorText: Colors.white,
        );
      } catch (e) {
        debugPrint('Error saving to gallery: $e');
        Get.snackbar(
          'Error',
          'Failed to save $side to gallery: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withValues(alpha: 0.2),
          colorText: Colors.white,
        );
      }
    }
  }

  void retake() {
    if (currentStep.value == IdCaptureStep.front) {
      frontImagePath.value = null;
    } else if (currentStep.value == IdCaptureStep.back) {
      backImagePath.value = null;
    }
  }

  /// Opens crop UI for the image captured on the current front/back step.
  Future<void> openCropEditorForCurrentStep() async {
    final path = switch (currentStep.value) {
      IdCaptureStep.front => frontImagePath.value,
      IdCaptureStep.back => backImagePath.value,
      IdCaptureStep.review => null,
    };
    if (path == null) return;
    final newPath = await Get.to<String>(() => IdImageCropPage(imagePath: path));
    if (newPath == null || newPath.isEmpty) return;
    switch (currentStep.value) {
      case IdCaptureStep.front:
        frontImagePath.value = newPath;
      case IdCaptureStep.back:
        backImagePath.value = newPath;
      case IdCaptureStep.review:
        break;
    }
  }

  /// Opens crop UI for front or back during final review.
  Future<void> openCropEditorForSide({required bool isFront}) async {
    final path = isFront ? frontImagePath.value : backImagePath.value;
    if (path == null) return;
    final newPath = await Get.to<String>(() => IdImageCropPage(imagePath: path));
    if (newPath == null || newPath.isEmpty) return;
    if (isFront) {
      frontImagePath.value = newPath;
    } else {
      backImagePath.value = newPath;
    }
  }

  void nextStep() {
    if (currentStep.value == IdCaptureStep.front) {
      if (frontImagePath.value != null) {
        currentStep.value = IdCaptureStep.back;
      }
    } else if (currentStep.value == IdCaptureStep.back) {
      if (backImagePath.value != null) {
        currentStep.value = IdCaptureStep.review;
      }
    }
  }

  void previousStep() {
    if (currentStep.value == IdCaptureStep.back) {
      currentStep.value = IdCaptureStep.front;
    } else if (currentStep.value == IdCaptureStep.review) {
      currentStep.value = IdCaptureStep.back;
    }
  }


  void confirm() {
    if (frontImagePath.value != null && backImagePath.value != null) {
      _verificationService.setIdentityPaths(
        frontImagePath.value!,
        backImagePath.value!,
      );
      Get.toNamed(Routes.liveness);
    } else {
      Get.snackbar(
        'Missing Info',
        'Please capture both front and back of your ID',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }


  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}
