import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/voice_verification_controller.dart';
import '../../../widgets/base_button.dart';

class VoiceVerificationView extends GetView<VoiceVerificationController> {
  const VoiceVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D141F),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Voice Verification',
                        style: context.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Step 3 of 3',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF44DDC2),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Recognition Content (No more card look)
                    SizedBox(
                      width: double.infinity,
                      height: 380.h,
                      child: Obx(
                        () => controller.isPreviewMode.value
                            ? _buildReviewUI(context)
                            : _buildCaptureUI(context),
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // Tip/Hint
                    Obx(
                      () => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: Text(
                          controller.activeTip.value,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.white54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Actions
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Obx(() {
                if (controller.isPreviewMode.value) {
                  return Row(
                    children: [
                      Expanded(
                        child: BaseButton(
                          text: 'Retake',
                          type: ButtonType.secondary,
                          onPressed: controller.retake,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: BaseButton(
                          text: 'Confirm',
                          type: ButtonType.primary,
                          onPressed: controller.confirm,
                        ),
                      ),
                    ],
                  );
                } else {
                  return SizedBox(
                    width: double.infinity,
                    child: BaseButton(
                      text: controller.isRecording.value
                          ? 'Stop Recording'
                          : 'Start Voice Record',
                      type: controller.isRecording.value
                          ? ButtonType.primary
                          : ButtonType.secondary,
                      onPressed: () {
                        if (controller.isRecording.value) {
                          controller.stopRecording();
                        } else {
                          controller.startRecording();
                        }
                      },
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaptureUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Pulse animation for recording
        Obx(
          () => Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: controller.isRecording.value
                  ? Colors.redAccent.withValues(alpha: 0.1)
                  : const Color(0xFF44DDC2).withValues(alpha: 0.1),
            ),
            child: Icon(
              controller.isRecording.value ? Icons.mic_none : Icons.mic,
              size: 80.w,
              color: controller.isRecording.value
                  ? Colors.redAccent
                  : const Color(0xFF44DDC2),
            ),
          ),
        ),
        SizedBox(height: 32.h),
        if (controller.isRecording.value) ...[
          Text(
            'RECORDING IN PROGRESS',
            style: context.textTheme.labelMedium?.copyWith(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ] else
          Text(
            'Ready to record',
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.white70,
            ),
          ),
      ],
    );
  }

  Widget _buildReviewUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Interactive Play/Pause with Glow
        GestureDetector(
          onTap: controller.togglePlayback,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Glowing Aura
              Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF44DDC2).withValues(alpha: 0.1),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF44DDC2).withValues(alpha: 0.2),
                      blurRadius: 40,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
              // Outer Ring
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF44DDC2).withValues(alpha: 0.5),
                    width: 2,
                  ),
                ),
              ),
              // Icon
              GetBuilder<VoiceVerificationController>(
                builder: (controller) => Icon(
                  controller.audioPlayerController?.value.isPlaying == true
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  size: 48.w,
                  color: const Color(0xFF44DDC2),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 48.h),
        // Improved Waveform visualization
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(24, (index) {
            return _WaveformBar(index: index);
          }),
        ),
        SizedBox(height: 32.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '"${controller.voicePhrase}"',
            style: context.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF44DDC2),
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _WaveformBar extends StatelessWidget {
  final int index;
  const _WaveformBar({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1.5.w),
      width: 3.w,
      height: (12 + (index % 7) * 8).h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF44DDC2).withValues(alpha: 0.3),
            const Color(0xFF44DDC2),
            const Color(0xFF44DDC2).withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
