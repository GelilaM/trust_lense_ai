import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String occupation;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.occupation,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Text(
            name,
            style: context.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.theme.colorScheme.primary,
              fontSize: 32.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            occupation.toUpperCase(),
            style: context.textTheme.labelMedium?.copyWith(
              color: context.theme.colorScheme.onSurface.withValues(alpha: 0.5),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: context.theme.colorScheme.secondary.withValues(
                alpha: 0.15,
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified,
                  color: context.theme.colorScheme.secondary,
                  size: 14.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  'LEVEL 2 VERIFIED',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.theme.colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
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
