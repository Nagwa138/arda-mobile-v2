import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/transeletarabic/transalet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildModernTextField(
  BuildContext context, {
  required String title,
  required String hint,
  required TextEditingController controller,
  required IconData prefixIcon,
  required Function validation,
  bool obstructText = false,
  Widget? suffixIcon,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 13.sp,
          color: accentColor,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
      SizedBox(height: 8.h),
      Container(
        decoration: BoxDecoration(
          color: Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: Color(0xFFE8EAED),
            width: 1.5,
          ),
        ),
        child: TextFormField(
          controller: controller,
          obscureText: obstructText,
          style: TextStyle(
            color: accentColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
          validator: (input) => validation(input),
          inputFormatters: [
            ArabicToEnglishNumeralsFormatter(),
          ],
          decoration: InputDecoration(
            hintText: hint.tr(),
            contentPadding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 16.w,
            ),
            hintStyle: TextStyle(
              color: accentColor.withValues(alpha: 0.4),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: accentColor.withValues(alpha: 0.5),
              size: 22.sp,
            ),
            suffixIcon: suffixIcon,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
        ),
      ),
    ],
  );
}
