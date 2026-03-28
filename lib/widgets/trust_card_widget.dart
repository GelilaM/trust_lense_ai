import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/models/trust_card_model.dart';

class TrustCardWidget extends StatelessWidget {
  final TrustCardModel? card;
  final bool isLocked;
  final VoidCallback? onIssuePressed;
  final VoidCallback? onSelectProductPressed;

  const TrustCardWidget({
    super.key,
    this.card,
    this.isLocked = false,
    this.onIssuePressed,
    this.onSelectProductPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 212.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isLocked
              ? [const Color(0xFF2D3748), const Color(0xFF1A202C)]
              : [const Color(0xFF0F172A), const Color(0xFF1E293B)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned(
            right: -20.w,
            bottom: -20.h,
            child: Icon(
              Icons.security,
              size: 150.w,
              color: Colors.white.withValues(alpha: 0.03),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TRUST CARD',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF44DDC2),
                            letterSpacing: 2.0,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          isLocked ? 'STATUS: LOCKED' : 'STATUS: ACTIVE',
                          style: GoogleFonts.inter(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.blur_on,
                      color: Colors.white.withValues(alpha: 0.8),
                      size: 28.w,
                    ),
                  ],
                ),

                if (isLocked)
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.lock_outline,
                          color: Colors.white38,
                          size: 32.w,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Score > 45 required to unlock',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: Colors.white38,
                          ),
                        ),
                      ],
                    ),
                  )
                else if (card == null)
                  Center(
                    child: TextButton(
                      onPressed: onIssuePressed,
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(
                          0xFF44DDC2,
                        ).withValues(alpha: 0.12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'ADD TRUST CARD',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF44DDC2),
                        ),
                      ),
                    ),
                  )
                else ...[
                  Text(
                    card!.maskedNumber,
                    style: GoogleFonts.sourceCodePro(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SELECTED PRODUCT',
                              style: GoogleFonts.inter(
                                fontSize: 9.sp,
                                color: Colors.white54,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              card!.selectedProduct
                                      ?.replaceAll('_', ' ')
                                      .toUpperCase() ??
                                  'NONE YET',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // if (onSelectProductPressed != null)
                      //   TextButton.icon(
                      //     onPressed: onSelectProductPressed,
                      //     style: TextButton.styleFrom(
                      //       foregroundColor: const Color(0xFF44DDC2),
                      //       padding: EdgeInsets.symmetric(
                      //         horizontal: 10.w,
                      //         vertical: 4.h,
                      //       ),
                      //       minimumSize: Size.zero,
                      //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      //     ),
                      //     icon: Icon(Icons.add_circle_outline, size: 16.w),
                      //     label: Text(
                      //       'Products',
                      //       style: GoogleFonts.inter(
                      //         fontSize: 12.sp,
                      //         fontWeight: FontWeight.w700,
                      //       ),
                      //     ),
                      //   ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
