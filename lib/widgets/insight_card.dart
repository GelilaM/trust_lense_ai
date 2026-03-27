import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InsightCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSuccess;

  const InsightCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSuccess,
  });

  @override
  Widget build(BuildContext context) {
    final Color iconBoxColor = isSuccess
        ? Colors.white
        : const Color(0xFFFFFBEB);
    final Color iconColor = isSuccess
        ? const Color(0xFF0F766E)
        : const Color(0xFFD97706);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: isSuccess
            ? null
            : Border(
                left: BorderSide(color: const Color(0xFFF59E0B), width: 4.w),
              ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Box
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: iconBoxColor,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.05),
                      width: 1,
                    ),
                  ),
                  child: Icon(icon, color: iconColor, size: 20.w),
                ),
                SizedBox(height: 16.h),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0A1926),
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      height: 1.5,
                      color: const Color(0xFF0A1926).withValues(alpha: 0.6),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Top right status icon
          Positioned(
            top: 24.w,
            right: 24.w,
            child: Icon(
              isSuccess ? Icons.check_circle : Icons.warning_rounded,
              color: isSuccess
                  ? const Color(0xFF16A34A)
                  : const Color(0xFFF59E0B),
              size: 24.w,
            ),
          ),
        ],
      ),
    );
  }
}
