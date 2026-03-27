import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isActive;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            context.theme.colorScheme.surfaceContainerLowest, // white fallback
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A0A2540),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: isActive
                  ? context.theme.colorScheme.primary
                  : context.theme.colorScheme.surfaceContainerLow,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive
                  ? context.theme.colorScheme.tertiary
                  : context.theme.colorScheme.onSurface,
              size: 24.sp,
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.theme.colorScheme.primary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
