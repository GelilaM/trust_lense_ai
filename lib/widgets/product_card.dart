import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Widget badgeWidget;
  final String actionText;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.badgeWidget,
    required this.actionText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Box
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9), // Light slate
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF0F766E), // Teal/Emerald
              size: 20.w,
            ),
          ),
          SizedBox(height: 20.h),

          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0A1926),
            ),
          ),
          SizedBox(height: 8.h),

          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              height: 1.5,
              color: const Color(0xFF0A1926).withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: 20.h),

          badgeWidget,

          SizedBox(height: 24.h),

          // Action row
          InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  actionText,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0A1926),
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.arrow_forward,
                  color: const Color(0xFF0A1926),
                  size: 16.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
