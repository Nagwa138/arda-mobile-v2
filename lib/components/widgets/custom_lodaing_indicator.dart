import 'package:PassPort/components/color/color.dart';
import 'package:flutter/material.dart';

class CustomLodaingIndicator extends StatelessWidget {
  final EdgeInsetsGeometry padding;

  const CustomLodaingIndicator({
    super.key,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Center(
        child: CircularProgressIndicator(color: accentColor),
      ),
    );
  }
}
