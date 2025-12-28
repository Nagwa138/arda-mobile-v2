import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';

Widget emptyCart({
  required BuildContext context,
}) {
  return Scaffold(
    body: Padding(
      padding: EdgeInsets.only(top: 70.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/emptycart.png',
            width: 200.sp,
            height: 200.sp,
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'لايوجد عمليات  بحث ',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: black,
              fontSize: 32.sp,
              fontFamily: 'Hanimation Arabic',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),

        ],
      ),
    ),
  );
}