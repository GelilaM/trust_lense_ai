import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SecurityStatusCard extends StatelessWidget {
  final String phone;

  const SecurityStatusCard({
    super.key,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x050A2540),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 3.w,
            height: 60.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.theme.colorScheme.secondary,
                  context.theme.colorScheme.primary.withValues(alpha: 0.5),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(width: 16.w),
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: context.theme.colorScheme.secondary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.auto_awesome,
              color: context.theme.colorScheme.secondary,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Account Security: Optimal',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.theme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'ID: $phone',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.theme.colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Your biometric data and document encryption are currently synchronized with TrustLens military-grade protocols.',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.theme.colorScheme.onSurface.withValues(
                      alpha: 0.7,
                    ),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
