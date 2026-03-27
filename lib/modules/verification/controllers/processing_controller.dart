import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../core/services/verification_service.dart';
import '../../../data/providers/identity_provider.dart';
import '../../../data/models/identity_model.dart';
import 'package:flutter/material.dart';


class ProcessingController extends GetxController {
  final _verificationService = Get.find<VerificationService>();
  final _identityProvider = Get.find<IdentityProvider>();
  
  final statusMessage = 'Uploading Encrypted Data...'.obs;
  final currentStep = 0.obs; // Tracks the current verification phase
  final uploadResult = Rxn<IdentitySubmissionModel>();


  @override
  void onInit() {
    super.onInit();
    super.onInit();
    _startIdentityTransition();
  }

  void _startIdentityTransition() async {
    if (!_verificationService.isComplete) {
      Get.snackbar(
        'Incomplete Verification',
        'Missing verification data. Please start again.',
        backgroundColor: Colors.redAccent.withValues(alpha: 0.2),
        colorText: Colors.white,
      );
      Get.offAllNamed(Routes.welcome);
      return;
    }

    _performRealUpload();
  }

  Future<void> _performRealUpload() async {
    try {
      // Step 0: Uploading
      currentStep.value = 0;
      statusMessage.value = 'Uploading Encrypted Biometric Data...';
      
      final result = await _identityProvider.uploadIdentity(
        frontPath: _verificationService.frontPath.value!,
        backPath: _verificationService.backPath.value!,
        videoPath: _verificationService.videoPath.value!,
        audioPath: _verificationService.audioPath.value!,
      );

      uploadResult.value = result;

      // Step 1: Backend Analysis (UI only)
      currentStep.value = 1;
      statusMessage.value = 'Engine Analyzing Biometric Markers...';
      await Future.delayed(const Duration(seconds: 2));

      // Step 2: Policy Check
      currentStep.value = 2;
      statusMessage.value = 'Calculating Identity Trust Score...';
      await Future.delayed(const Duration(seconds: 2));

      // Step 3: Finalizing
      currentStep.value = 3;
      statusMessage.value = 'Verification Complete';
      await Future.delayed(const Duration(seconds: 1));

      // Navigate to results
      Get.offAllNamed(Routes.trustScore, arguments: result);
    } catch (e) {
      debugPrint('Upload failed: $e');
      Get.snackbar(
        'Upload Failed',
        'We encountered an error uploading your data. Please check your connection.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.2),
        colorText: Colors.white,
      );
      Get.offAllNamed(Routes.welcome);
    }
  }

}
