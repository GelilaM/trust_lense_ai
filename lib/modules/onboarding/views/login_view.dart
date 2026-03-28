import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_controller.dart';
import '../../../widgets/base_button.dart';
import '../../../widgets/base_text_field.dart';
import '../../../widgets/base_card.dart';
import '../../../widgets/kifiya_logo.dart';
import '../../../routes/app_routes.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header — Kifiya + product line
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KifiyaLogo(height: 48.h),
                    SizedBox(height: 12.h),
                    Text(
                      'TrustLens AI',
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: context.theme.colorScheme.primary,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
              ),

              // Main Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: BaseCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      // Title
                      Text(
                        'Welcome Back',
                        style: GoogleFonts.inter(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w800,
                          color: context.theme.colorScheme.primary,
                          height: 1.1,
                          letterSpacing: -1.0,
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Subtitle
                      Text(
                        'Secure access to your AI-driven trust profile and credit insights.',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: context.theme.colorScheme.onSurface.withValues(
                            alpha: 0.7,
                          ),
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 32.h),

                      // Fields
                      Obx(
                        () => BaseTextField(
                          label: 'Phone Number',
                          hintText: '0911......',
                          prefixIcon: Icons.phone,
                          controller: controller.phoneController,
                          keyboardType: TextInputType.number,
                          errorText: controller.phoneError.value,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Obx(
                        () => BaseTextField(
                          label: 'Password',
                          hintText: 'Enter your password',
                          prefixIcon: Icons.lock_outline,
                          controller: controller.passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: controller.obscurePassword.value,
                          errorText: controller.passwordError.value,
                          suffixIcon: IconButton(
                            onPressed: controller.togglePasswordVisibility,
                            icon: Icon(
                              controller.obscurePassword.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: context.theme.colorScheme.outline,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 12.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: context.theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Login Button
                      Obx(
                        () => BaseButton(
                          text: 'Sign In',
                          isLoading: controller.isLoading.value,
                          onPressed: controller.login,
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Signup Link
                      Center(
                        child: GestureDetector(
                          onTap: () => Get.toNamed(Routes.signup),
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                color: context.theme.colorScheme.onSurface
                                    .withValues(alpha: 0.7),
                              ),
                              children: [
                                TextSpan(
                                  text: 'Register',
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
                    ],
                  ),
                ),
              ),

              // Footer
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Text(
                  '© 2026 TRUSTLENS AI',
                  style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF9EA3B0),
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
