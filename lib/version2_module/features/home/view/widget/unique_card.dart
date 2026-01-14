import 'package:PassPort/components/widgets/custom_image.dart';
import 'package:PassPort/models/traveller/accomandating/randomAccomandtion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UniqueCard extends StatelessWidget {
  const UniqueCard({super.key, required this.accommodation, this.onTap});
  final Data accommodation;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
        width: 270.w,
        height: 300.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 15,
              offset: Offset(0, 8)),
          ]),
        child: Stack(
          children: [
            // Background Image
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: CustomImage(
                (accommodation.imageUrl != null &&
                        accommodation.imageUrl!.isNotEmpty)
                    ? accommodation.imageUrl![0]
                    : null,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity)),

            // Bottom Gradient Overlay
            // Positioned(
            //   bottom: 0,
            //   left: 0,
            //   right: 0,
            //   child: Container(
            //     height: 250.h,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.only(
            //         bottomLeft: Radius.circular(20.r),
            //         bottomRight: Radius.circular(20.r),
            //       ),
            //       color: Colors.black.withValues(alpha:0.3),
            //     ),
            //   ),
            // ),

            // Bottom Content
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r)),
                  color: Colors.black.withValues(alpha: 0.3)),
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Location with Rating Badge
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            accommodation.address ?? 'Location',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white.withValues(alpha: 0.95),
                              fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis)),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(20.r)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: Color(0xFFFFD700),
                                size: 12.sp),
                              SizedBox(width: 3.w),
                              Text(
                                '${(accommodation.rate ?? 0).toStringAsFixed(1)}',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                            ])),
                      ]),

                    SizedBox(height: 6.h),

                    // Title
                    Text(
                      accommodation.accomodationName?.toUpperCase() ??
                          'UNIQUE EXPERIENCE',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.15,
                        letterSpacing: 1.2)),

                    SizedBox(height: 12.h),

                    // Price and Reserve Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Starting From',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.white.withValues(alpha: 0.9),
                                fontWeight: FontWeight.w500)),
                            SizedBox(height: 4.h),
                            Text(
                              '\$${(accommodation.price ?? 0.0).toStringAsFixed(0)}',
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: -0.5)),
                          ]),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 10.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r)),
                          child: Text(
                            'Reserve',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87))),
                      ]),
                  ]))),
          ])));
  }
}
