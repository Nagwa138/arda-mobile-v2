import 'package:flutter/material.dart';

class CartBackgroundContainer extends StatelessWidget {
  final Widget child;

  const CartBackgroundContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
