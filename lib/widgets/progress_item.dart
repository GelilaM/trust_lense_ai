import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String status;
  final bool isActive;

  const ProgressItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final Color emeraldColor = const Color(0xFF44DDC2);
    final Color greyColor = Colors.white.withValues(alpha: 0.3);

    return Row(
      children: [
        // Icon Box
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: isActive
                ? emeraldColor.withValues(alpha: 0.1)
                : Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(
            icon,
            color: isActive ? emeraldColor : greyColor,
            size: 20.w,
          ),
        ),
        SizedBox(width: 16.w),

        // Text details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: isActive
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.5),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: isActive ? emeraldColor : greyColor,
                ),
              ),
            ],
          ),
        ),

        // Status indicator right side
        if (isActive)
          Row(
            children: [
              Container(
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  color: emeraldColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                status,
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  color: emeraldColor,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          )
        else
          Text(
            status,
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: greyColor,
              letterSpacing: 0.5,
            ),
          ),
      ],
    );
  }
}
