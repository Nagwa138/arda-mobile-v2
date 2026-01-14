import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    this.height,
    this.width,
    this.shape = BoxShape.rectangle,
    this.baseColor = Colors.grey,
  });

  final double? height;
  final double? width;
  final MaterialColor baseColor;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor.shade200,
      highlightColor: baseColor.shade100,
      period: const Duration(milliseconds: 900),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: baseColor.shade50,
          shape: shape,
          borderRadius: shape != BoxShape.circle
              ? BorderRadius.circular(6)
              : null,
        ),
      ),
    );
  }
}
