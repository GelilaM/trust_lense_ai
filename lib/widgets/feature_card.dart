import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surfaceContainerLow, // light grey card
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.theme.colorScheme.secondary.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: context.theme.colorScheme.secondary, size: 24.w),
          SizedBox(height: 12.h),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: context.theme.colorScheme.primary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              height: 1.5,
              color: context.theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
