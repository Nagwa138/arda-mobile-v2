import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildSection({
  required String title,
  required String subtitle,
  required int itemCount,
  required Widget Function(int) itemBuilder,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Section Header
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
                height: 1.4,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),

      SizedBox(height: 16.h),

      // Horizontal List
      SizedBox(
        height: 235.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          physics: const BouncingScrollPhysics(),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                left: index == 0 ? 4.w : 0,
                right: 12.w,
              ),
              child: itemBuilder(index),
            );
          },
        ),
      ),
    ],
  );
}
