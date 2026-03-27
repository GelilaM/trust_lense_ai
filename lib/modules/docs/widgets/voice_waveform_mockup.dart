import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VoiceWaveformMockup extends StatelessWidget {
  const VoiceWaveformMockup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.h,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(40, (index) {
            // Pseudo-random heights for waveform
            final heights = [
              10,
              20,
              15,
              30,
              45,
              25,
              10,
              40,
              60,
              35,
              20,
              15,
              50,
              65,
              30,
              15,
              20,
              45,
              55,
              25,
              15,
              30,
              40,
              70,
              45,
              20,
              15,
              30,
              50,
              35,
              20,
              15,
              25,
              10,
              20,
              30,
              15,
              10,
              5,
              10,
            ];
            return Container(
              width: 3.w,
              height: heights[index].h,
              decoration: BoxDecoration(
                color: context.theme.colorScheme.secondary.withValues(
                  alpha: index % 2 == 0 ? 0.8 : 0.4,
                ),
                borderRadius: BorderRadius.circular(2.r),
              ),
            );
          }),
        ),
      ),
    );
  }
}
