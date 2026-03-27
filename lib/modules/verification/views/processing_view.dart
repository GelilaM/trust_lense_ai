import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/progress_item.dart';
import '../controllers/processing_controller.dart';

class ProcessingView extends GetView<ProcessingController> {
  const ProcessingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1926), // Deep blue/navy background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 8.h),

              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TrustLens AI',
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF44DDC2), // Emerald Cyan
                        letterSpacing: -0.5,
                      ),
                    ),
                    CircleAvatar(
                      radius: 18.r,
                      backgroundColor: Colors.white.withValues(alpha: 0.1),
                      child: Icon(
                        Icons.person,
                        color: Colors.white.withValues(alpha: 0.5),
                        size: 24.w,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 14.h),

              // Center Graphic
              Center(
                child: SizedBox(
                  width: 150.w,
                  height: 150.w,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Dashed circle border
                      SizedBox(
                        width: 130.w,
                        height: 130.w,
                        child: CustomPaint(
                          painter: DashedCirclePainter(
                            color: const Color(
                              0xFF44DDC2,
                            ).withValues(alpha: 0.3),
                            strokeWidth: 1.5,
                            dashes: 40,
                          ),
                        ),
                      ),

                      // Solid emerald circle
                      Container(
                        width: 100.w,
                        height: 100.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF32C6A9), // Solid Emerald core
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF32C6A9),
                              blurRadius: 40,
                              spreadRadius: -10,
                            ),
                          ],
                        ),
                        child: Center(
                          // Simple grid of dots
                          child: SizedBox(
                            width: 36.w,
                            height: 36.w,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 4,
                                  ),
                              itemCount: 9,
                              itemBuilder: (context, index) {
                                // Skip corners for a rounded cross pattern
                                if (index == 0 ||
                                    index == 2 ||
                                    index == 6 ||
                                    index == 8) {
                                  return SizedBox(
                                    width: 8.w,
                                    height: 8.w,
                                    child: Center(
                                      child: Container(
                                        width: 4.w,
                                        height: 4.w,
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFF0A1926,
                                          ).withValues(alpha: 0.5),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: Color(
                                      0xFF0A1926,
                                    ), // Dark primary color
                                    shape: BoxShape.circle,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10.h),

              // Title text
              Text(
                'Analyzing your\nidentity...',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 16.h),

              // Subtitle
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Text(
                  'Our neural engine is cross-referencing biometric markers for secure authentication.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    height: 1.5,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
              ),

              SizedBox(height: 48.h),

              // Progress Cards
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFF0F2435,
                    ), // Slightly lighter than background
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.05),
                      width: 1,
                    ),
                  ),
                  child: Obx(
                    () => Column(
                      children: [
                        // Item 1: Face
                        ProgressItem(
                          icon: Icons.face,
                          title: 'Face authenticity',
                          subtitle: controller.currentStep.value > 0
                              ? 'MATCH CONFIRMED'
                              : 'SCANNING MESH...',
                          status: controller.currentStep.value > 0
                              ? 'VERIFIED'
                              : 'CHECKING',
                          isActive: controller.currentStep.value >= 0,
                        ),
                        
                        SizedBox(height: 32.h),
                        
                        // Item 2: Voice
                        ProgressItem(
                          icon: Icons.mic,
                          title: 'Voice consistency',
                          subtitle: controller.currentStep.value > 1
                              ? 'MATCH CONFIRMED'
                              : (controller.currentStep.value == 1
                                  ? 'ANALYZING AUDIO...'
                                  : 'WAITING FOR DATA'),
                          status: controller.currentStep.value > 1
                              ? 'VERIFIED'
                              : (controller.currentStep.value == 1
                                  ? 'CHECKING'
                                  : 'PENDING'),
                          isActive: controller.currentStep.value >= 1,
                        ),
                        
                        SizedBox(height: 32.h),
                        
                        // Item 3: Behavior
                        ProgressItem(
                          icon: Icons.gesture,
                          title: 'Behavioral signals',
                          subtitle: controller.currentStep.value > 2
                              ? 'MATCH CONFIRMED'
                              : (controller.currentStep.value == 2
                                  ? 'PROCESSING SIGNALS...'
                                  : 'WAITING FOR DATA'),
                          status: controller.currentStep.value > 2
                              ? 'VERIFIED'
                              : (controller.currentStep.value == 2
                                  ? 'CHECKING'
                                  : 'PENDING'),
                          isActive: controller.currentStep.value >= 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 64.h),

              // Footer Badge
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF0C1D2A), // Dark pill
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.03),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.verified_user,
                      color: const Color(0xFF44DDC2),
                      size: 14.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'END-TO-END ENCRYPTED VERIFICATION',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.6),
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final int dashes;

  DashedCirclePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashes,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);

    final double sweepAngle = (2 * math.pi) / (dashes * 2);

    for (int i = 0; i < dashes * 2; i++) {
      if (i % 2 == 0) {
        final double startAngle = i * sweepAngle;
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          sweepAngle,
          false,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
