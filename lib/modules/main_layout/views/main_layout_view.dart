import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widgets/nav_item.dart';
import '../controllers/main_layout_controller.dart';
import '../../profile/views/dashboard_view.dart';
import '../../profile/views/profile_dashboard_view.dart';
import '../../settings/views/settings_view.dart';
import '../../docs/views/docs_view.dart';

class MainLayoutView extends GetView<MainLayoutController> {
  const MainLayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            DashboardView(),
            ProfileDashboardView(),
            DocsView(),
            SettingsView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: context.theme.colorScheme.surfaceContainerLowest,
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A0A2540),
                blurRadius: 20,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavItem(
                    icon: Icons.dashboard_outlined,
                    label: 'Dashboard',
                    isActive: controller.currentIndex.value == 0,
                    onTap: () => controller.changeTab(0),
                  ),
                  NavItem(
                    icon: Icons.verified_user_outlined,
                    label: 'Trust',
                    isActive: controller.currentIndex.value == 1,
                    onTap: () => controller.changeTab(1),
                  ),
                  NavItem(
                    icon: Icons.description_outlined,
                    label: 'Docs',
                    isActive: controller.currentIndex.value == 2,
                    onTap: () => controller.changeTab(2),
                  ),
                  NavItem(
                    icon: Icons.person_outline,
                    label: 'Profile',
                    isActive: controller.currentIndex.value == 3,
                    onTap: () => controller.changeTab(3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
