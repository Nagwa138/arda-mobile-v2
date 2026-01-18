import 'package:PassPort/components/color/color.dart';
import 'package:flutter/material.dart';

class CustomLodaingIndicator extends StatelessWidget {
  const CustomLodaingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: accentColor),
    );
  }
}
