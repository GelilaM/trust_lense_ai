import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../controllers/settings_controller.dart';
import '../widgets/profile_header.dart';
import '../widgets/security_status_card.dart';
import '../widgets/menu_section.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surface,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF0F766E)),
          );
        }

        final profile = controller.userProfile.value;

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 45.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeader(
                  name: profile?.fullName ?? 'User',
                  occupation: profile?.occupation ?? 'Member',
                ),
                SizedBox(height: 15.h),
                SecurityStatusCard(phone: profile?.phone ?? ''),
                SizedBox(height: 15.h),
                Text(
                  'ACCOUNT PREFERENCES',
                  style: context.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: context.theme.colorScheme.onSurface.withValues(
                      alpha: 0.5,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                MenuSection(
                  items: [
                    MenuItemData(
                      icon: Icons.person_outline,
                      title: 'Personal Information',
                    ),
                    MenuItemData(
                      icon: Icons.fingerprint,
                      title: 'Security & Biometrics',
                    ),
                    MenuItemData(
                      icon: Icons.description_outlined,
                      title: 'Document Center',
                      onTap: () => Get.toNamed(Routes.docs),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                Text(
                  'SUPPORT & SYSTEM',
                  style: context.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: context.theme.colorScheme.onSurface.withValues(
                      alpha: 0.5,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                MenuSection(
                  items: [
                    MenuItemData(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: controller.logout,
                    icon: Icon(
                      Icons.logout,
                      color: context.theme.colorScheme.error,
                    ),
                    label: Text(
                      'Log Out',
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.theme.colorScheme.error,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      side: BorderSide(
                        color: context.theme.colorScheme.error.withValues(
                          alpha: 0.5,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Center(
                  child: Text(
                    'VERSION 1.0.0 (BETA)',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.theme.colorScheme.onSurface.withValues(
                        alpha: 0.4,
                      ),
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
