import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final Alignment? alignment;
  final int? maxLine;
  final double? height;
  final double? width;
  final TextDecoration? textDecoration;
  final FontWeight fontWeight;
  final VoidCallback? function;

  const CustomText({
    Key? key,
    required this.text,
    required this.size,
    required this.color,
    this.alignment,
    this.maxLine,
    this.height,
    this.textDecoration,
    this.function,
    required this.fontWeight,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: width,
        alignment: alignment,
        child: Text(
          maxLines: maxLine,
          text,
          textDirection: TextDirection.rtl,
          style: TextStyle(decoration: textDecoration, color: color, fontSize: size, fontFamily: 'Mona Sans', fontWeight: fontWeight),
        ),
      ),
    );
  }
}
