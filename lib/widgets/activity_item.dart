import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String status;
  final String time;

  const ActivityItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x050A2540),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: context.theme.colorScheme.surfaceContainerLow,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: context.theme.colorScheme.primary,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.theme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.theme.colorScheme.onSurface.withValues(
                      alpha: 0.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                status,
                style: context.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.theme.colorScheme.primary,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                time,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 10.sp,
                  color: context.theme.colorScheme.onSurface.withValues(
                    alpha: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
