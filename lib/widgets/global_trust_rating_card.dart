import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GlobalTrustRatingCard extends StatelessWidget {
  final int score;
  final String level;

  const GlobalTrustRatingCard({
    super.key,
    required this.score,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A0A2540),
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: -24.w,
            top: -24.h,
            bottom: -24.h,
            child: Container(
              width: 4.w,
              decoration: BoxDecoration(
                color: context.theme.colorScheme.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  bottomLeft: Radius.circular(24.r),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GLOBAL TRUST\nRATING',
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.theme.colorScheme.secondary,
                      letterSpacing: 1.5,
                      height: 1.4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
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
                          Icons.verified_user,
                          color: context.theme.colorScheme.secondary,
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Verified\n$level',
                          textAlign: TextAlign.center,
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                            fontSize: 9.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '$score',
                    style: context.textTheme.displayLarge?.copyWith(
                      color: context.theme.colorScheme.primary,
                      fontSize: 64.sp,
                      height: 1,
                      letterSpacing: -2,
                    ),
                  ),
                  Text(
                    '/100',
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.theme.colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              // Radar Chart alternative (Bar chart representation)
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBar(context, 'FIN', 0.8),
                  _buildBar(context, 'ID', 0.95),
                  _buildBar(context, 'SOC', 0.6),
                  _buildBar(context, 'BEH', 0.85),
                  _buildBar(context, 'NET', 0.7),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                'Top 5% in your demographic',
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.theme.colorScheme.secondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBar(BuildContext context, String label, double fill) {
    return Column(
      children: [
        Container(
          height: 60.h,
          width: 8.w,
          decoration: BoxDecoration(
            color: context.theme.colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(4.r),
          ),
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            heightFactor: fill,
            widthFactor: 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: context.theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            fontSize: 9.sp,
            color: context.theme.colorScheme.onSurface.withValues(alpha: 0.5),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
