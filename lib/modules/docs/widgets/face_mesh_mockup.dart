import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FaceMeshMockup extends StatelessWidget {
  const FaceMeshMockup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140.h,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Simulated face grid
          Icon(
            Icons.face_retouching_natural,
            color: context.theme.colorScheme.secondary.withValues(alpha: 0.3),
            size: 100.sp,
          ),
          // Scanning line effect
          Positioned(
            top: 60.h,
            left: 0,
            right: 0,
            child: Container(
              height: 2.h,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: context.theme.colorScheme.secondary,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
                color: context.theme.colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
