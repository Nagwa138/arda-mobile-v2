import 'package:PassPort/version2_module/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget buildLoadingSection({
  required String title,
  required String subtitle,
  required Widget skeletonWidget,
  required int height,
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
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 6.h),
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

      // Skeleton List
      Skeletonizer(
        enabled: true,
        child: SizedBox(
          height: height.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 4.w : 0,
                  right: 12.w,
                ),
                child: skeletonWidget,
              );
            },
          ),
        ),
      ),
    ],
  );
}
