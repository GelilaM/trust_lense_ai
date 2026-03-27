import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/welcome_controller.dart';
import '../../../widgets/base_button.dart';
import '../../../routes/app_routes.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header (Logo + TrustLens AI)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: context.theme.colorScheme.primary, // Deep Navy
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.security,
                        color: context.theme.colorScheme.tertiary,
                        size: 16.w,
                      ),
                    ),
                    SizedBox(width: 12.w),
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
              ),

              // 2. Graphic Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Container(
                  height: 250.h,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF2A2D34), Color(0xFF131417)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: context.theme.colorScheme.primary.withValues(
                          alpha: 0.1,
                        ),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Inner 'A' graphic placeholder
                      Center(
                        child: Text(
                          'A',
                          style: GoogleFonts.inter(
                            fontSize: 180.sp,
                            fontWeight: FontWeight.w900,
                            color: Colors.white.withValues(alpha: 0.05),
                          ),
                        ),
                      ),
                      // 'Sound wave' simulation or simple decoration
                      Positioned(
                        bottom: 90.h,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          height: 50.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(35, (index) {
                              // random heights for waves
                              final height = (index % 5 + 1) * 8.0;
                              return Container(
                                width: 2.w,
                                height: height,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(1.r),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      // Top right tag
                      Positioned(
                        top: 20.h,
                        right: 20.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.95),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6.w,
                                height: 6.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF006B5C),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                'SYSTEM ACTIVE',
                                style: GoogleFonts.inter(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF000F22),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Bottom analyzer bar
                      Positioned(
                        bottom: 24.h,
                        left: 20.w,
                        right: 20.w,
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(6.w),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF006B5C),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.print,
                                  color: Colors.white,
                                  size: 14.w,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 4.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.2,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          2.r,
                                        ),
                                      ),
                                      child: FractionallySizedBox(
                                        alignment: Alignment.centerLeft,
                                        widthFactor: 0.88,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF44DDC2),
                                            borderRadius: BorderRadius.circular(
                                              2.r,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      'Analyzing Liveness...',
                                      style: GoogleFonts.inter(
                                        fontSize: 10.sp,
                                        color: Colors.white.withValues(
                                          alpha: 0.8,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                '88%',
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF44DDC2),
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

              // 3. SECURE IDENTITY PROTOCOL V2.4 chip
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons
                            .verified_user, // Replaced explicit security icon with verified_user
                        color: context.theme.colorScheme.secondary,
                        size: 14.w,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'SECURE IDENTITY PROTOCOL V2.4',
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: context.theme.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // 4. Headline
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.inter(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                      color: context.theme.colorScheme.primary, // Deep Navy
                      letterSpacing: -1.5,
                    ),
                    children: [
                      const TextSpan(text: 'Verify your\nidentity in\n'),
                      TextSpan(
                        text: 'seconds',
                        style: TextStyle(
                          color: context.theme.colorScheme.secondary,
                        ), // Emerald Green
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10.h),

              // 5. Body Text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Secure, fast, and powered by AI. Our advanced neural engine provides enterprise-grade authentication with biological precision.',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    height: 1.5,
                    color: context.theme.colorScheme.onSurface.withValues(
                      alpha: 0.8,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // 6. Buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: BaseButton(
                  text: 'Get Started',
                  type: ButtonType.primary,
                  icon: Icons.arrow_forward,
                  trailingIcon: true,
                  onPressed: controller.goToSignup,
                ),
              ),

              SizedBox(height: 16.h),

              // Sign In Link
              Center(
                child: GestureDetector(
                  onTap: () => Get.toNamed(Routes.signIn),
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: context.theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign In',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w800,
                            color: context.theme.colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 9. Footer
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.blur_on,
                          color: context.theme.colorScheme.onSurface.withValues(
                            alpha: 0.8,
                          ),
                          size: 18.w,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'TrustLens AI',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: context.theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
