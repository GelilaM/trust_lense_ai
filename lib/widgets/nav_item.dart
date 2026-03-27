import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: isActive
                  ? context.theme.colorScheme.surfaceContainerLow
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              icon,
              color: isActive
                  ? context.theme.colorScheme.secondary
                  : context.theme.colorScheme.outlineVariant,
              size: 24.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              fontSize: 9.sp,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive
                  ? context.theme.colorScheme.secondary
                  : context.theme.colorScheme.outlineVariant,
            ),
          ),
        ],
      ),
    );
  }
}
