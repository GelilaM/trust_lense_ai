import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/income_option_card.dart';
import '../controllers/signup_controller.dart';
import '../../../widgets/base_button.dart';
import '../../../widgets/base_text_field.dart';
import '../../../widgets/base_card.dart';
import '../../../widgets/base_dropdown.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
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

              // Main Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: BaseCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Progress & Step
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Progress Bar
                          Expanded(
                            child: Obx(() {
                              double progress =
                                  controller.currentStep.value / 3.0;
                              return Container(
                                height: 6.h,
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFE2E8F0,
                                  ), // light gray line
                                  borderRadius: BorderRadius.circular(3.r),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: progress,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: context
                                          .theme
                                          .colorScheme
                                          .secondary, // Emerald
                                      borderRadius: BorderRadius.circular(3.r),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(width: 16.w),
                          Obx(
                            () => Text(
                              'STEP ${controller.currentStep.value} OF 3',
                              style: GoogleFonts.inter(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                                color: context.theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),

                      // Title
                      Text(
                        'Create your account',
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
                        'Start your journey with secure AI identity verification.',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: context.theme.colorScheme.onSurface.withValues(
                            alpha: 0.7,
                          ),
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 15.h),

                      // Fields
                      Obx(() {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: _buildStepContent(
                            context,
                            controller.currentStep.value,
                          ),
                        );
                      }),

                      SizedBox(height: 26.h),

                      // Continue Button
                      Obx(
                        () => BaseButton(
                          text: controller.currentStep.value == 3
                              ? 'Complete Profile'
                              : 'Continue',
                          icon: Icons.arrow_forward,
                          trailingIcon: true,
                          onPressed: controller.nextStep,
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // OR Divider
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(color: Color(0xFFE2E8F0)),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              'OR',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF9EA3B0),
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Divider(color: Color(0xFFE2E8F0)),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      Center(
                        child: GestureDetector(
                          onTap: () => Get.toNamed(Routes.signIn),
                          child: RichText(
                            text: TextSpan(
                              text: 'Already have an account? ',
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                color: context.theme.colorScheme.onSurface
                                    .withValues(alpha: 0.7),
                              ),
                              children: [
                                TextSpan(
                                  text: 'Log in',
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
              Container(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: Column(
                  children: [
                    // Mock logos
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildFooterLogo(Icons.square_rounded),
                        SizedBox(width: 24.w),
                        _buildFooterLogo(Icons.circle),
                        SizedBox(width: 24.w),
                        _buildFooterLogo(Icons.change_history),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      '© 2026 TRUSTLENS AI',
                      style: GoogleFonts.inter(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF9EA3B0),
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent(BuildContext context, int step) {
    switch (step) {
      case 1:
        return Column(
          key: const ValueKey(1),
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => BaseTextField(
                label: 'Full Name',
                hintText: 'John Doe',
                prefixIcon: Icons.person,
                controller: controller.nameController,
                errorText: controller.nameError.value,
              ),
            ),
            SizedBox(height: 24.h),
            Obx(
              () => BaseTextField(
                label: 'Phone Number',
                hintText: '09275451321',
                prefixIcon: Icons.phone,
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                errorText: controller.phoneError.value,
              ),
            ),
            SizedBox(height: 24.h),
            Obx(
              () => BaseTextField(
                label: 'Password',
                hintText: 'Password',
                prefixIcon: Icons.lock,
                controller: controller.passwordController,
                keyboardType: TextInputType.text,
                errorText: controller.passwordError.value,
              ),
            ),
          ],
        );
      case 2:
        return Column(
          key: const ValueKey(2),
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => BaseDropdown<String>(
                label: 'Occupation',
                hint: 'Select your role',
                value: controller.selectedOccupation.value,
                errorText: controller.occupationError.value,
                items: controller.occupations
                    .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                    .toList(),
                onChanged: (val) => controller.selectedOccupation.value = val,
              ),
            ),
            SizedBox(height: 24.h),
            Obx(
              () => BaseDropdown<String>(
                label: 'Gender',
                hint: 'Select your Gender',
                value: controller.sex.value.isEmpty
                    ? null
                    : controller.sex.value,
                errorText: controller.sexError.value,
                items: ['Male', 'Female']
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (val) => controller.sex.value = val ?? '',
              ),
            ),
            SizedBox(height: 24.h),
            Obx(
              () => BaseTextField(
                label: 'Nationality',
                hintText: 'e.g. Ethiopian',
                prefixIcon: Icons.flag_outlined,
                controller: controller.nationalityController,
                errorText: controller.nationalityError.value,
              ),
            ),
            SizedBox(height: 24.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DATE OF BIRTH',
                  style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: context.theme.colorScheme.primary.withValues(
                      alpha: 0.8,
                    ),
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(height: 8.h),
                Obx(
                  () => InkWell(
                    onTap: () => controller.selectDate(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: context.theme.colorScheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: controller.dobError.value != null
                              ? Colors.redAccent
                              : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 20.w,
                            color: context.theme.colorScheme.primary,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            controller.dateOfBirth.value == null
                                ? 'Select Date'
                                : '${controller.dateOfBirth.value!.day}/${controller.dateOfBirth.value!.month}/${controller.dateOfBirth.value!.year}',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: controller.dateOfBirth.value == null
                                  ? context.theme.colorScheme.onSurface
                                        .withValues(alpha: 0.5)
                                  : context.theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => controller.dobError.value != null
                      ? Padding(
                          padding: EdgeInsets.only(top: 8.h, left: 4.w),
                          child: Text(
                            controller.dobError.value!,
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 12.sp,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            BaseTextField(
              label: 'Business Type (Optional)',
              hintText: 'e.g. Grocery Store',
              prefixIcon: Icons.store,
              controller: controller.businessTypeController,
            ),
          ],
        );
      case 3:
        return Column(
          key: const ValueKey(3),
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Text(
                'ESTIMATED MONTHLY INCOME',
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: context.theme.colorScheme.primary.withValues(
                    alpha: 0.8,
                  ),
                  letterSpacing: 1.0,
                ),
              ),
            ),
            Obx(
              () => Column(
                children: [
                  IncomeOptionCard(
                    value: 'Under 10,000',
                    isSelected: controller.incomeRange.value == 'Under 10,000',
                    onTap: () => controller.incomeRange.value = 'Under 10,000',
                  ),
                  IncomeOptionCard(
                    value: '10,000 - 50,000',
                    isSelected:
                        controller.incomeRange.value == '10,000 - 50,000',
                    onTap: () =>
                        controller.incomeRange.value = '10,000 - 50,000',
                  ),
                  IncomeOptionCard(
                    value: '50,000 - 100,000',
                    isSelected:
                        controller.incomeRange.value == '50,000 - 100,000',
                    onTap: () =>
                        controller.incomeRange.value = '50,000 - 100,000',
                  ),
                  IncomeOptionCard(
                    value: 'Over 100,000',
                    isSelected: controller.incomeRange.value == 'Over 100,000',
                    onTap: () => controller.incomeRange.value = 'Over 100,000',
                  ),
                  if (controller.incomeError.value != null)
                    Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: Text(
                        controller.incomeError.value!,
                        style: TextStyle(
                          color: context.theme.colorScheme.error,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildFooterLogo(IconData icon) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(icon, color: const Color(0xFF9EA3B0), size: 20.w),
    );
  }
}
