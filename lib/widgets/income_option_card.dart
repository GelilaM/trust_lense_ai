import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IncomeOptionCard extends StatelessWidget {
  final String value;
  final bool isSelected;
  final VoidCallback onTap;

  const IncomeOptionCard({
    super.key,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? context.theme.colorScheme.secondary.withValues(alpha: 0.1)
              : context.theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? context.theme.colorScheme.secondary
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected
                  ? context.theme.colorScheme.secondary
                  : const Color(0xFF9EA3B0),
            ),
            SizedBox(width: 12.w),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: context.theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
