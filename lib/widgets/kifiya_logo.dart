import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Kifiya company mark for auth and marketing surfaces.
class KifiyaLogo extends StatelessWidget {
  const KifiyaLogo({
    super.key,
    this.height,
    this.width,
    this.alignment = Alignment.centerLeft,
  });

  final double? height;
  final double? width;
  final AlignmentGeometry alignment;

  static const String _assetPath = 'assets/Kifiya_Full_Color.svg';

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: SvgPicture.asset(
        _assetPath,
        height: height ?? 44.h,
        width: width,
        fit: BoxFit.contain,
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
