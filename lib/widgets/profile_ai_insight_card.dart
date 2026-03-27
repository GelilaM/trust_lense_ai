import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileAiInsightCard extends StatelessWidget {
  final String? insightText;
  final String fullName;
  final VoidCallback onBoostScorePressed;

  const ProfileAiInsightCard({
    super.key,
    this.insightText,
    required this.fullName,
    required this.onBoostScorePressed,
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
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: context.theme.colorScheme.secondary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_awesome,
                color: context.theme.colorScheme.secondary,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'AI INSIGHT',
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.theme.colorScheme.secondary,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            insightText ??
                'Analysis for $fullName: Your network validation metric is slightly below average. Linking a utility bill can boost your score.',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.theme.colorScheme.onSurface.withValues(alpha: 0.8),
              height: 1.5,
            ),
          ),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onBoostScorePressed,
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 12.sp,
                color: context.theme.colorScheme.primary,
              ),
              label: Text(
                'Boost Score',
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                backgroundColor: context.theme.colorScheme.secondary.withValues(
                  alpha: 0.1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
