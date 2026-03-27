import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AiInsightCard extends StatelessWidget {
  final String textPart1;
  final String textPart2;

  const AiInsightCard({
    super.key,
    required this.textPart1,
    required this.textPart2,
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
            color: Color(0x0A0A2540),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left accent glow bar (Design System standard)
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
              Icons.thumb_up_outlined,
              color: context.theme.colorScheme.secondary,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.theme.colorScheme.onSurface.withValues(
                    alpha: 0.8,
                  ),
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                    text: textPart1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: context.theme.colorScheme.primary,
                    ),
                  ),
                  TextSpan(text: textPart2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
