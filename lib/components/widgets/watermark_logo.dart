import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A reusable widget that displays a watermark logo
/// Typically used as the last child in a Stack to overlay a semi-transparent logo
class WatermarkLogo extends StatelessWidget {
  final String logoPath;
  final double opacity;
  final double width;
  final double height;
  final Color? color;

  const WatermarkLogo({
    super.key,
    this.logoPath = 'assets/images/logo.png',
    this.opacity = 0.3,
    this.width = 200,
    this.height = 200,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: opacity,
        child: Image.asset(
          logoPath,
          width: width.w,
          height: height.h,
          color: color,
        ),
      ),
    );
  }
}
