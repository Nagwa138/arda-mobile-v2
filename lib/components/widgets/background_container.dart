import 'package:flutter/material.dart';

/// A reusable widget that displays a background image
/// Typically used as the first child in a Stack to provide a background for the entire screen
class BackgroundContainer extends StatelessWidget {
  final String imagePath;
  final BoxFit fit;

  const BackgroundContainer({
    super.key,
    this.imagePath = "assets/images/background.jpeg",
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: fit,
        ),
      ),
    );
  }
}
