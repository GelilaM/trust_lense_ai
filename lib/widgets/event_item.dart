import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EventItem extends StatelessWidget {
  final String dateStr;
  final String title;
  final String subtitle;
  final String points;
  final bool isNeutral;

  const EventItem({
    super.key,
    required this.dateStr,
    required this.title,
    required this.subtitle,
    required this.points,
    this.isNeutral = false,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: context.theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              dateStr,
              textAlign: TextAlign.center,
              style: context.textTheme.labelMedium?.copyWith(
                color: context.theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
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
                SizedBox(height: 4.h),
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
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: isNeutral
                  ? context.theme.colorScheme.surfaceContainerLow
                  : context.theme.colorScheme.secondary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              points,
              style: context.textTheme.labelMedium?.copyWith(
                color: isNeutral
                    ? context.theme.colorScheme.onSurface.withValues(alpha: 0.5)
                    : context.theme.colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
