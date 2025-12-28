import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;

  const CustomTextField({
    required this.label,
    this.hint,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.focusNode,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(label,
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //     )),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          decoration: InputDecoration(
            // label: Text(
            //   label,
            //   style: TextStyle(fontSize: 12.sp, color: Colors.black),
            // ),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.black, fontSize: 10),
            suffixIcon: suffixIcon,
          ),
          validator: validator,
          
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
