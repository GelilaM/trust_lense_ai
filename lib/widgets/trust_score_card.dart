import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TrustScoreCard extends StatelessWidget {
  final int score;
  final String lastUpdatedText;

  const TrustScoreCard({
    super.key,
    required this.score,
    required this.lastUpdatedText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primary, // Deep Navy
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A0A2540),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Subtle radial gradient backdrop
          Positioned(
            top: -50.h,
            right: -50.w,
            child: Container(
              width: 200.w,
              height: 200.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    context.theme.colorScheme.secondary.withValues(
                      alpha: 0.15,
                    ), // Emerald
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'IDENTITY INTEGRITY',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.theme.colorScheme.tertiary,
                    letterSpacing: 2,
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Your Trust Score',
                  style: context.textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: context.theme.colorScheme.secondary.withValues(
                          alpha: 0.2,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.verified,
                            color: context.theme.colorScheme.tertiary,
                            size: 14.w,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Verified',
                            style: context.textTheme.labelMedium?.copyWith(
                              color: context.theme.colorScheme.tertiary,
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      lastUpdatedText,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                // Inner Score Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            score.toString(),
                            style: context.textTheme.displayLarge?.copyWith(
                              color: Colors.white,
                              fontSize: 56.sp,
                              height: 1,
                            ),
                          ),
                          Text(
                            '/100',
                            style: context.textTheme.titleLarge?.copyWith(
                              color: context.theme.colorScheme.tertiary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: LinearProgressIndicator(
                            value: score / 100.0,
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.1,
                            ),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              context.theme.colorScheme.tertiary,
                            ),
                            minHeight: 6.h,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        score >= 70
                            ? 'EXCELLENT STATUS'
                            : (score > 40
                                  ? 'GOOD STATUS'
                                  : 'ATTENTION REQUIRED'),
                        style: context.textTheme.labelMedium?.copyWith(
                          color: context.theme.colorScheme.tertiary,
                          letterSpacing: 2,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
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
