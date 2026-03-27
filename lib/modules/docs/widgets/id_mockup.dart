import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class IdMockup extends StatelessWidget {
  const IdMockup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140.h,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: context.theme.colorScheme.outlineVariant.withValues(
            alpha: 0.3,
          ),
        ),
      ),
      padding: EdgeInsets.all(16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80.w,
            height: double.infinity,
            decoration: BoxDecoration(
              color: context.theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.person,
              color: context.theme.colorScheme.outline,
              size: 40.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  width: 120.w,
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  width: 140.w,
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.workspace_premium,
                      color: context.theme.colorScheme.secondary.withValues(
                        alpha: 0.5,
                      ),
                      size: 24.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
