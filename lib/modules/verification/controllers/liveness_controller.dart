import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:gal/gal.dart';
import '../../../routes/app_routes.dart';
import '../../../core/services/verification_service.dart';


class LivenessController extends GetxController with WidgetsBindingObserver {
  final _verificationService = Get.find<VerificationService>();
  final isRecording = false.obs;

  final isInitialized = false.obs;
  final activeTip = 'Fit your face in the oval'.obs;
  final currentStepIndex = 0.obs;
  final capturedVideoPath = ''.obs;
  final isPreviewMode = false.obs;

  CameraController? cameraController;
  VideoPlayerController? videoPlayerController;

  double get portraitPreviewAspectRatio {
    final previewSize = cameraController?.value.previewSize;
    if (previewSize == null) {
      return 3 / 4;
    }

    final shortSide = previewSize.shortestSide;
    final longSide = previewSize.longestSide;
    if (longSide == 0) {
      return 3 / 4;
    }

    return shortSide / longSide;
  }

  final List<String> _livenessTips = [
    'Blink your eyes',
    'Smile widely',
    'Turn your head right',
    'Turn your head left',
  ];

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _forcePortraitOrientation();
    _initializeCamera();
  }

  Future<void> _forcePortraitOrientation() async {
    // Some Android devices can momentarily rotate when camera recording starts.
    // Re-applying this lock keeps the liveness flow in portrait.
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void didChangeMetrics() {
    _forcePortraitOrientation();
    super.didChangeMetrics();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      return;
    }

    // Use the front camera for liveness check
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    cameraController = CameraController(
      frontCamera,
      ResolutionPreset.medium,
      enableAudio: false, // Video phase without sound as requested
    );

    try {
      await cameraController!.initialize();
      await cameraController!.lockCaptureOrientation(
        DeviceOrientation.portraitUp,
      );
      isInitialized.value = true;
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  void startCheck() async {
    await _startVideoCheck();
  }

  Future<void> _startVideoCheck() async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return;
    }

    try {
      await _forcePortraitOrientation();
      isRecording.value = true;
      currentStepIndex.value = 0;
      await cameraController!.lockCaptureOrientation(
        DeviceOrientation.portraitUp,
      );
      await cameraController!.prepareForVideoRecording();
      // Record video without audio for the video phase
      await cameraController!.startVideoRecording();

      // Cycle through tips
      for (int i = 0; i < _livenessTips.length; i++) {
        activeTip.value = _livenessTips[i];
        currentStepIndex.value = i + 1;
        await Future.delayed(const Duration(seconds: 2));
      }

      final XFile video = await cameraController!.stopVideoRecording();
      debugPrint('Captured liveness video: ${video.path}');

      capturedVideoPath.value = video.path;
      await _initializeVideoPreview(video.path);

      isRecording.value = false;
      isPreviewMode.value = true;
      activeTip.value = 'Review your liveness video';
    } catch (e) {
      debugPrint('Error during video check: $e');
      isRecording.value = false;
      activeTip.value = 'Verification failed';
    }
  }

  Future<void> stopVideoRecording() async {
    try {
      final file = await cameraController!.stopVideoRecording();
      isRecording.value = false;
      capturedVideoPath.value = file.path;
      isPreviewMode.value = true;
      _initializeVideoPreview(file.path);
    } catch (e) {
      debugPrint('Error stopping video record: $e');
    }
  }

  Future<void> _initializeVideoPreview(String path) async {
    videoPlayerController = VideoPlayerController.contentUri(Uri.parse(path));
    try {
      await videoPlayerController!.initialize();
      await videoPlayerController!.setLooping(true);
      await videoPlayerController!.play();
    } catch (e) {
      debugPrint('Error initializing video preview: $e');
    }
  }

  void downloadDoc() async {
    try {
      if (capturedVideoPath.value.isNotEmpty) {
        debugPrint('Downloading video: ${capturedVideoPath.value}');
        await Gal.putVideo(capturedVideoPath.value);
        Get.snackbar(
          'Success',
          'Video saved to gallery',
          backgroundColor: Colors.green.withValues(alpha: 0.7),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint('Error downloading: $e');
      Get.snackbar(
        'Error',
        'Failed to save recording',
        backgroundColor: Colors.redAccent.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
    }
  }

  void retake() {
    isPreviewMode.value = false;
    capturedVideoPath.value = '';
    videoPlayerController?.dispose();
    videoPlayerController = null;
    activeTip.value = 'Fit your face in the oval';
  }

  void togglePlayback() {
    if (videoPlayerController != null) {
      if (videoPlayerController!.value.isPlaying) {
        videoPlayerController!.pause();
      } else {
        videoPlayerController!.play();
      }
      update(); // Trigger UI rebuild if using GetBuilder or just rely on Obx if using Rx
    }
  }

  void confirm() {
    if (isPreviewMode.value && capturedVideoPath.value.isNotEmpty) {
      _verificationService.setVideoPath(capturedVideoPath.value);
      // Transition to Voice Verification after Video Review
      Get.toNamed(Routes.voiceVerification);
    }
  }


  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    cameraController?.dispose();
    videoPlayerController?.dispose();
    // Reset orientation to allow all orientations again
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.onClose();
  }
}
