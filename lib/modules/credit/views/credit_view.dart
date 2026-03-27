import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/product_card.dart';
import '../controllers/credit_controller.dart';

class CreditView extends GetView<CreditController> {
  const CreditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF0A1926)),
          );
        }

        return SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 120.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    Center(
                      child: Text(
                        'TrustLens AI',
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0A1926),
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 48.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'You\'re eligible for\nfinancial services',
                        style: GoogleFonts.inter(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0A1926),
                          height: 1.1,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    // Confidence Indicator
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.03),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 48.w,
                              height: 48.w,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: 48.w,
                                    height: 48.w,
                                    child: CircularProgressIndicator(
                                      value:
                                          (controller
                                                  .eligibility
                                                  .value
                                                  ?.combinedScore ??
                                              0) /
                                          100,
                                      strokeWidth: 4.w,
                                      backgroundColor: const Color(
                                        0xFF0F766E,
                                      ).withValues(alpha: 0.2),
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                            Color(0xFF0F766E),
                                          ),
                                    ),
                                  ),
                                  Text(
                                    '${controller.eligibility.value?.combinedScore ?? 0}%',
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w800,
                                      color: const Color(0xFF0A1926),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'CONFIDENCE LEVEL\nINDICATOR',
                                    style: GoogleFonts.inter(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF0F766E),
                                      letterSpacing: 0.5,
                                      height: 1.3,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    '${(controller.eligibility.value?.combinedScore ?? 0) >= 80
                                        ? "HIGH"
                                        : (controller.eligibility.value?.combinedScore ?? 0) >= 50
                                        ? "MEDIUM"
                                        : "LOW"} (${controller.eligibility.value?.combinedScore ?? 0}%)',
                                    style: GoogleFonts.inter(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w800,
                                      color: const Color(0xFF0A1926),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    // Financial Products
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        children: [
                          ProductCard(
                            icon: Icons.payments,
                            title: 'Loan',
                            description:
                                controller.eligibility.value?.loanOffer ??
                                'Immediate capital for growth initiatives.',
                            badgeWidget: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD1FAE5),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                controller.eligibility.value?.loanTier ??
                                    'Up to \$5,000',
                                style: GoogleFonts.inter(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF065F46),
                                ),
                              ),
                            ),
                            actionText: 'Apply Now',
                            onTap: () => controller.continueToDashboard(),
                          ),
                          SizedBox(height: 16.h),
                          ProductCard(
                            icon: Icons.shopping_cart,
                            title: 'Device Financing',
                            description:
                                controller
                                    .eligibility
                                    .value
                                    ?.deviceFinancingOffer ??
                                'Flexible procurement payments.',
                            badgeWidget: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6.w,
                                  height: 6.w,
                                  decoration: BoxDecoration(
                                    color:
                                        (controller
                                                .eligibility
                                                .value
                                                ?.eligibleForDeviceFinancing ??
                                            false)
                                        ? const Color(0xFF0F766E)
                                        : Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  (controller
                                              .eligibility
                                              .value
                                              ?.eligibleForDeviceFinancing ??
                                          false)
                                      ? 'Approved'
                                      : 'Not Eligible',
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        (controller
                                                .eligibility
                                                .value
                                                ?.eligibleForDeviceFinancing ??
                                            false)
                                        ? const Color(0xFF0F766E)
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            actionText: 'View Limits',
                            onTap: () => controller.continueToDashboard(),
                          ),
                          if (controller
                                  .eligibility
                                  .value
                                  ?.eligibleForCreditCard ??
                              false) ...[
                            SizedBox(height: 16.h),
                            ProductCard(
                              icon: Icons.credit_card,
                              title: 'TrustLens Credit Card',
                              description:
                                  controller
                                      .eligibility
                                      .value
                                      ?.creditCardOffer ??
                                  'Corporate credit with built-in expense management.',
                              badgeWidget: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE0F2FE),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Text(
                                  'Pre-approved',
                                  style: GoogleFonts.inter(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0369A1),
                                  ),
                                ),
                              ),
                              actionText: 'Get Card',
                              onTap: () => controller.continueToDashboard(),
                            ),
                          ],
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),
                    // AI Analysis Card
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border(
                            left: BorderSide(
                              color: const Color(0xFF0F766E),
                              width: 4.w,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(24.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.auto_awesome,
                                    color: const Color(0xFF0F766E),
                                    size: 20.w,
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    'TrustLens AI Analysis',
                                    style: GoogleFonts.inter(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF0A1926),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.inter(
                                    fontSize: 13.sp,
                                    height: 1.5,
                                    color: const Color(
                                      0xFF0A1926,
                                    ).withValues(alpha: 0.7),
                                  ),
                                  children: [
                                    TextSpan(text: _generateAnalysisText()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 64.h),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  String _generateAnalysisText() {
    final e = controller.eligibility.value;
    if (e == null)
      return 'Analyzing your trust profile to determine optimal financial pairings...';

    final strongest = e.metrics.strongestModality.capitalizeFirst;
    final weakest = e.metrics.weakestModality.capitalizeFirst;

    String text =
        'Your eligibility is strongly driven by your $strongest authentication score. ';

    if (e.eligibleForLoan) {
      text += 'We recommend starting with our Loan offering (${e.loanTier}). ';
    }

    if (e.eligibleForDeviceFinancing) {
      text += 'Your trust profile also qualifies you for device financing. ';
    }

    if (e.metrics.modalitySpread > 20) {
      text +=
          'Pro-tip: Strengthening your $weakest verification could unlock even higher credit limits.';
    }

    return text;
  }
}
