import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';
import '../controllers/id_capture_controller.dart';

class IdCaptureView extends GetView<IdCaptureController> {
  const IdCaptureView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D141F), // Dark navy background
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),

            // Top Badge
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.badge,
                      color: const Color(0xFF44DDC2), // Emerald/Cyan
                      size: 14.w,
                    ),
                    SizedBox(width: 8.w),
                    Obx(
                      () => Text(
                        controller.currentStep.value == IdCaptureStep.front
                            ? 'Step 1 of 3: Front ID'
                            : controller.currentStep.value == IdCaptureStep.back
                            ? 'Step 1 of 3: Back ID'
                            : 'Step 1 of 3: ID Review',
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 32.h),

            // Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Obx(() {
                String title = 'Align your ID within the frame';
                if (controller.currentStep.value == IdCaptureStep.front) {
                  title = controller.frontImagePath.value == null
                      ? 'Align Front of ID'
                      : 'Review Front Side';
                } else if (controller.currentStep.value == IdCaptureStep.back) {
                  title = controller.backImagePath.value == null
                      ? 'Align Back of ID'
                      : 'Review Back Side';
                } else {
                  title = 'Final ID Review';
                }
                return Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                  textAlign: TextAlign.center,
                );
              }),
            ),

            SizedBox(height: 8.h),

            // Subtitle
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Obx(() {
                String subtitle = 'Ensure the details are clear and glare-free';
                if (controller.currentStep.value == IdCaptureStep.front) {
                  subtitle = controller.frontImagePath.value == null
                      ? 'Align the front side of your ID card'
                      : 'Make sure the front side details are readable';
                } else if (controller.currentStep.value == IdCaptureStep.back) {
                  subtitle = controller.backImagePath.value == null
                      ? 'Align the back side of your ID card'
                      : 'Make sure the back side details are readable';
                } else {
                  subtitle =
                      'Preview your captured ID documents before proceeding';
                }
                return Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                );
              }),
            ),

            SizedBox(height: 80.h),

            // Camera Frame & Overlay
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // The camera preview or placeholder
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 18.w),
                    height: 480.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Obx(() {
                      if (controller.currentStep.value ==
                          IdCaptureStep.review) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: Column(
                            children: [
                              _buildReviewCard(
                                'Front Side',
                                controller.frontImagePath.value,
                                () => controller.downloadDoc(
                                  controller.frontImagePath.value,
                                  'Front',
                                ),
                              ),
                              SizedBox(height: 16.h),
                              _buildReviewCard(
                                'Back Side',
                                controller.backImagePath.value,
                                () => controller.downloadDoc(
                                  controller.backImagePath.value,
                                  'Back',
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      String? currentPath =
                          controller.currentStep.value == IdCaptureStep.front
                          ? controller.frontImagePath.value
                          : controller.backImagePath.value;

                      if (currentPath != null) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: Image.file(
                            File(currentPath),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 480.h,
                          ),
                        );
                      }

                      return controller.isInitialized.value
                          ? CustomPaint(
                              painter: ScannerFramePainter(
                                color: const Color(0xFF44DDC2),
                                strokeWidth: 4.0,
                                cornerLength: 40.w,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.r),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 480.h,
                                  child: CameraPreview(
                                    controller.cameraController!,
                                  ),
                                ),
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF44DDC2),
                              ),
                            );
                    }),
                  ),

                  // Top overlay badge on the frame (only show during capture)
                  Obx(
                    () =>
                        (controller.currentStep.value != IdCaptureStep.review &&
                            ((controller.currentStep.value ==
                                        IdCaptureStep.front &&
                                    controller.frontImagePath.value == null) ||
                                (controller.currentStep.value ==
                                        IdCaptureStep.back &&
                                    controller.backImagePath.value == null)))
                        ? Positioned(
                            top: -38.h,

                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 3.w,
                                    height: 12.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF44DDC2),
                                      borderRadius: BorderRadius.circular(2.r),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'TrustLens AI: Optimizing capture parameters',
                                    style: GoogleFonts.inter(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white.withValues(
                                        alpha: 0.9,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),

            SizedBox(height: 48.h),

            // Bottom Controls
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 32.h),
              child: Obx(() {
                if (controller.currentStep.value == IdCaptureStep.review) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Back Button
                      _buildControlItem(
                        icon: Icons.arrow_back,
                        label: 'Back',
                        onPressed: controller.previousStep,
                      ),

                      // Confirm Final
                      _buildControlItem(
                        icon: Icons.check,
                        label: 'Submit',
                        color: const Color(0xFF44DDC2),
                        iconColor: const Color(0xFF0D141F),
                        onPressed: controller.confirm,
                      ),
                    ],
                  );
                }

                String? currentPath =
                    controller.currentStep.value == IdCaptureStep.front
                    ? controller.frontImagePath.value
                    : controller.backImagePath.value;

                if (currentPath != null) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Retake Button
                      _buildControlItem(
                        icon: Icons.refresh,
                        label: 'Retake',
                        onPressed: controller.retake,
                      ),

                      // Next Button
                      _buildControlItem(
                        icon: Icons.check,
                        label: 'Next',
                        color: const Color(0xFF44DDC2),
                        iconColor: const Color(0xFF0D141F),
                        onPressed: controller.nextStep,
                      ),
                    ],
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Back/Flash toggle
                    controller.currentStep.value == IdCaptureStep.back
                        ? _buildControlItem(
                            icon: Icons.arrow_back,
                            label: 'Back',
                            onPressed: controller.previousStep,
                          )
                        : Container(
                            width: 48.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.05),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.1),
                                width: 1,
                              ),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.flash_off,
                                color: Colors.white,
                                size: 20.w,
                              ),
                              onPressed: () {},
                            ),
                          ),

                    // Shutter Button
                    GestureDetector(
                      onTap: controller.isCapturing.value
                          ? null
                          : controller.captureDocument,
                      child: Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(color: Colors.white, width: 4.w),
                        ),
                        child: Center(
                          child: controller.isCapturing.value
                              ? SizedBox(
                                  width: 24.w,
                                  height: 24.w,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: Colors.white,
                                  ),
                                )
                              : Container(
                                  width: 64.w,
                                  height: 64.w,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: const Color(0xFF0D141F),
                                    size: 32.w,
                                  ),
                                ),
                        ),
                      ),
                    ),

                    // Help Button
                    _buildControlItem(
                      icon: Icons.help_outline,
                      label: 'Help',
                      onPressed: () {},
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard(
    String title,
    String? imagePath,
    VoidCallback onDownload,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: imagePath != null
                ? Image.file(
                    File(imagePath),
                    width: 100.w,
                    height: 60.h,
                    fit: BoxFit.cover,
                  )
                : Container(width: 100.w, height: 60.h, color: Colors.black26),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Captured successfully',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.download,
              color: const Color(0xFF44DDC2),
              size: 24.w,
            ),
            onPressed: onDownload,
          ),
        ],
      ),
    );
  }

  Widget _buildControlItem({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    Color? color,
    Color? iconColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56.w,
          height: 56.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color ?? Colors.white.withValues(alpha: 0.05),
            border: color == null
                ? Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 1,
                  )
                : null,
          ),
          child: IconButton(
            icon: Icon(icon, color: iconColor ?? Colors.white, size: 24.w),
            onPressed: onPressed,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: color ?? Colors.white70,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class ScannerFramePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double cornerLength;

  ScannerFramePainter({
    required this.color,
    required this.strokeWidth,
    required this.cornerLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final double radius = 16.r; // Matching the container border radius

    // Top Left
    path.moveTo(0, cornerLength);
    path.lineTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.lineTo(cornerLength, 0);

    // Top Right
    path.moveTo(size.width - cornerLength, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, cornerLength);

    // Bottom Right
    path.moveTo(size.width, size.height - cornerLength);
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - radius,
      size.height,
    );
    path.lineTo(size.width - cornerLength, size.height);

    // Bottom Left
    path.moveTo(cornerLength, size.height);
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);
    path.lineTo(0, size.height - cornerLength);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
