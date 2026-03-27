import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/permissions_controller.dart';
import '../../../widgets/base_button.dart';
import '../../../widgets/base_card.dart';
import '../../../widgets/feature_card.dart';

class PermissionsView extends GetView<PermissionsController> {
  const PermissionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isConsentGiven = false.obs;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor, // F7F9FC
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.security,
                          color: context.theme.colorScheme.secondary,
                          size: 24.w,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'TrustLens AI',
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: context.theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 16.r,
                      backgroundColor:
                          context.theme.colorScheme.primaryContainer,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 20.w,
                      ),
                    ),
                  ],
                ),
              ),

              // Main Graphic Banner
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                padding: EdgeInsets.symmetric(vertical: 32.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0).withValues(alpha: 0.5), // Light grey
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 80.w,
                            height: 80.w,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: context.theme.colorScheme.secondary,
                              size: 32.w,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Container(
                            width: 80.w,
                            height: 80.w,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.mic,
                              color: context.theme.colorScheme.secondary,
                              size: 32.w,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: -16.h,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
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
                                  color: Color(0xFF006B5C), // Emerald
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                'SYSTEM READY',
                                style: GoogleFonts.inter(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                  color: context.theme.colorScheme.primary,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
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
                child: Text(
                  'Enable AI Verification',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w800,
                    color: context.theme.colorScheme.primary,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Subtitle
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Text(
                  'To provide institutional-grade security, TrustLens AI requires brief access to verify your identity and environment via secure biometric checks.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    height: 1.5,
                    color: context.theme.colorScheme.onSurface.withValues(
                      alpha: 0.7,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 32.h),

              // Permission Cards List
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    FeatureCard(
                      icon: Icons.lock,
                      title: 'Security',
                      description:
                          'Prevents unauthorized access through facial liveness checks.',
                    ),
                    SizedBox(height: 12.h),
                    FeatureCard(
                      icon: Icons.badge,
                      title: 'Identity',
                      description:
                          'Syncs your biometric profile with encrypted digital credentials.',
                    ),
                    SizedBox(height: 12.h),
                    FeatureCard(
                      icon: Icons.record_voice_over,
                      title: 'Voice Check',
                      description:
                          'Enables secure acoustic signatures for high-value transactions.',
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              // Consent Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: BaseCard(
                  padding: EdgeInsets.all(20.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Checkbox(
                          value: isConsentGiven.value,
                          onChanged: (value) =>
                              isConsentGiven.value = value ?? false,
                          activeColor: context.theme.colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 12.h),
                              child: Text(
                                'I consent to biometric verification',
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: context.theme.colorScheme.primary,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Your data is encrypted end-to-end and is never shared with third parties without your explicit request.',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                height: 1.5,
                                color: context.theme.colorScheme.onSurface
                                    .withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 32.h),

              // Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Obx(
                  () => BaseButton(
                    text: 'Agree & Continue',
                    type: ButtonType.secondary,
                    icon: Icons.arrow_forward,
                    trailingIcon: true,
                    isLoading: controller.isRequesting.value,
                    onPressed: (!isConsentGiven.value || controller.isRequesting.value)
                        ? null
                        : controller.requestPermissions,
                  ),
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
