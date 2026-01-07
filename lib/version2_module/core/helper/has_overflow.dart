import 'package:flutter/material.dart';

bool hasOverflow(Text text, double maxWidth, BuildContext context) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text.data, style: text.style),
    maxLines: text.maxLines,
    textDirection: TextDirection.rtl,
  )..layout(maxWidth: maxWidth);

  return textPainter.didExceedMaxLines;
}
