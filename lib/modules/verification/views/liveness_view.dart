import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:video_player/video_player.dart';
import '../controllers/liveness_controller.dart';
import '../../../widgets/base_button.dart';

class LivenessView extends GetView<LivenessController> {
  const LivenessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark mode for camera
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                  const Spacer(),
                  Text(
                    'Step 2 of 3',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF44DDC2),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Obx(
              () => Text(
                controller.isRecording.value
                    ? 'Action Required'
                    : 'Liveness Check',
                style: context.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16.h),
            // The prompt "shift from security -> opportunity"
            Obx(
              () => Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: controller.isRecording.value
                      ? context.theme.colorScheme.tertiary.withValues(
                          alpha: 0.1,
                        )
                      : context.theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                  border: controller.isRecording.value
                      ? Border.all(
                          color: context.theme.colorScheme.tertiary,
                          width: 1,
                        )
                      : null,
                ),
                child: Text(
                  controller.activeTip.value,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: controller.isRecording.value
                        ? context.theme.colorScheme.tertiary
                        : context.theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 48.h),
            // Liveness Oval
            Container(
              height: 380.h,
              width: 260.w,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.elliptical(130.w, 190.h)),
                border: Border.all(
                  color: controller.isRecording.value
                      ? Colors.redAccent
                      : context.theme.colorScheme.tertiary,
                  width: 3,
                  style: BorderStyle.solid,
                ),
                color: Colors.white.withValues(alpha: 0.05),
              ),
              child: Obx(() {
                if (controller.isPreviewMode.value &&
                    controller.videoPlayerController != null &&
                    controller.videoPlayerController!.value.isInitialized) {
                  return ClipPath(
                    clipper: OvalClipper(),
                    child: Center(
                      child: AspectRatio(
                        aspectRatio:
                            controller.videoPlayerController!.value.aspectRatio,
                        child: VideoPlayer(controller.videoPlayerController!),
                      ),
                    ),
                  );
                }

                return controller.isInitialized.value
                    ? ClipPath(
                        clipper: OvalClipper(),
                        child: Center(
                          child: AspectRatio(
                            // Keep the preview in portrait even if camera plugin
                            // updates internal aspect values while recording.
                            aspectRatio: controller.portraitPreviewAspectRatio,
                            child: CameraPreview(controller.cameraController!),
                          ),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: context.theme.colorScheme.tertiary,
                        ),
                      );
              }),
            ),
            SizedBox(height: 32.h),
            Obx(
              () => controller.isRecording.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          width: 12.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.currentStepIndex.value > index
                                ? context.theme.colorScheme.tertiary
                                : Colors.white24,
                          ),
                        );
                      }),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Text(
                        'This process confirms your identity for secure lending',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: Colors.white54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
            const Spacer(),
            Obx(
              () => controller.isPreviewMode.value
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: BaseButton(
                              text: 'Retake',
                              type: ButtonType.secondary,
                              onPressed: controller.retake,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: BaseButton(
                              text: 'Confirm',
                              type: ButtonType.primary,
                              onPressed: controller.confirm,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      width: 200.w,
                      child: BaseButton(
                        text: 'Start Verification',
                        type: ButtonType.primary,
                        isLoading: controller.isRecording.value,
                        onPressed: controller.isRecording.value
                            ? null
                            : controller.startCheck,
                      ),
                    ),
            ),
            SizedBox(height: 48.h),
          ],
        ),
      ),
    );
  }
}

class OvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
