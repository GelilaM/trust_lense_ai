import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/insight_card.dart';
import '../controllers/trust_controller.dart';
import '../../../data/models/trust_result_model.dart';

class TrustView extends GetView<TrustController> {
  const TrustView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF44DDC2)),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Text(
                'TrustLens AI',
                style: GoogleFonts.inter(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0A1926),
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 20.h),
              // Score Ring Section
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 220.w,
                    height: 220.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFF44DDC2).withValues(alpha: 0.1),
                          Colors.transparent,
                        ],
                        stops: const [0.5, 1.0],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 180.w,
                    height: 180.w,
                    child: CustomPaint(
                      painter: ScoreRingPainter(
                        score: controller.trustScore.value,
                        activeColor: const Color(0xFF44DDC2),
                        inactiveColor: const Color(
                          0xFF44DDC2,
                        ).withValues(alpha: 0.15),
                        strokeWidth: 20.w,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${controller.trustScore.value}',
                              style: GoogleFonts.inter(
                                fontSize: 64.sp,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF0A1926),
                                height: 1.0,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'OUT OF 100',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(
                                  0xFF0A1926,
                                ).withValues(alpha: 0.6),
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -10.h,
                    right: 40.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6.w,
                            height: 6.w,
                            decoration: const BoxDecoration(
                              color: Color(0xFF44DDC2),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'LIVE ANALYSIS',
                            style: GoogleFonts.inter(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0A1926),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Badges
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF44DDC2).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.verified,
                          color: const Color(0xFF16A34A),
                          size: 16.w,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          '${controller.readiness.value} CONFIDENCE',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF16A34A),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Text(
                  'Identity authentication successful. Your trust profile is highly reliable.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0A1926),
                    height: 1.2,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              // Detailed Breakdown Section
              if (controller.trustResult.value != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      _buildModalitySection(
                        'Identity Document',
                        controller.trustResult.value!.document,
                      ),
                      SizedBox(height: 24.h),
                      _buildModalitySection(
                        'Liveness Video',
                        controller.trustResult.value!.video,
                      ),
                      SizedBox(height: 24.h),
                      _buildModalitySection(
                        'Voice Verification',
                        controller.trustResult.value!.audio,
                      ),
                    ],
                  ),
                )
              else
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      InsightCard(
                        icon: Icons.devices,
                        title: 'Stable device usage',
                        subtitle: 'Consistent interaction patterns detected.',
                        isSuccess: true,
                      ),
                      SizedBox(height: 16.h),
                      InsightCard(
                        icon: Icons.face,
                        title: 'Natural facial behavior',
                        subtitle:
                            'Liveness detection confirmed authentic markers.',
                        isSuccess: true,
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 48.h),
              // Bottom Action Buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: controller.continueToCredit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A1926),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Continue',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildModalitySection(String title, ModalityTrustBreakdown modality) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0A1926).withValues(alpha: 0.6),
                letterSpacing: 1.0,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: const Color(0xFF0A1926).withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                '${modality.sectionScore}%',
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0A1926),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        ...modality.criteria
            .map((check) => _buildCriterionCard(check))
            .toList(),
      ],
    );
  }

  Widget _buildCriterionCard(RequirementCheck check) {
    Color statusColor;
    IconData statusIcon;

    switch (check.status) {
      case 'pass':
        statusColor = const Color(0xFF16A34A);
        statusIcon = Icons.check_circle;
        break;
      case 'fail':
        statusColor = const Color(0xFFDC2626);
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = const Color(0xFFD97706);
        statusIcon = Icons.info_outline;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF0A1926).withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(statusIcon, color: statusColor, size: 20.w),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            check.label,
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0A1926),
                            ),
                          ),
                        ),
                        Text(
                          check.score.toStringAsFixed(2),
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(
                              0xFF0A1926,
                            ).withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      check.detail,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: const Color(0xFF0A1926).withValues(alpha: 0.6),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ScoreRingPainter extends CustomPainter {
  final int score;
  final Color activeColor;
  final Color inactiveColor;
  final double strokeWidth;

  ScoreRingPainter({
    required this.score,
    required this.activeColor,
    required this.inactiveColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;

    final bgPaint = Paint()
      ..color = inactiveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final fgPaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    final double sweepAngle = 2 * math.pi * (score / 100.0);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ScoreRingPainter oldDelegate) {
    return oldDelegate.score != score ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.inactiveColor != inactiveColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
