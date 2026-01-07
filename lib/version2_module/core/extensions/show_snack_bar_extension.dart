import 'package:flutter/material.dart';

import '../enums/snack_bar_type.dart';
import '../widgets/snack_bar_widget.dart';

extension ShowSnackBarExtension on BuildContext {
  void showCustomSnackBar(
    String message, {
    double? height,
    double fontSize = 14,
    SnackBarType type = SnackBarType.info,
    String? title,
    bool isForEver = false,
  }) {
    final messenger = ScaffoldMessenger.of(this);

    // Clear any existing snackbar first
    messenger.clearSnackBars();

    // Add a small delay to ensure the previous snackbar is fully dismissed
    Future.delayed(const Duration(milliseconds: 50), () {
      messenger.showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 3000, days: isForEver ? 1 : 0),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          clipBehavior: Clip.none,
          dismissDirection: DismissDirection.endToStart,
          content: SizedBox(
            height: 50,
            child: SnackBarWidget(message: message, type: type),
          ),
        ),
      );
    });
  }
}
