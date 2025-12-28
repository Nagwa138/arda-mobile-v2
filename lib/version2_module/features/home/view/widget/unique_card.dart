import 'package:PassPort/models/traveller/accomandating/randomAccomandtion.dart';
import 'package:PassPort/version2_module/core/const/app_colors.dart';
import 'package:PassPort/version2_module/features/home/data/models/top_rated_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../components/color/color.dart';

class UniqueCard extends StatelessWidget {
  const UniqueCard({super.key, required this.accommodation, this.onTap});
  final Data accommodation;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        width: 340.w, // زيادة العرض
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: accentColor.withOpacity(0.15),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section - أكبر
            Stack(
              children: [
                Container(
                  height: 300.h, // زيادة ارتفاع الصورة
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.r),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.r),
                    ),
                    child: (accommodation.imageUrl != null &&
                            accommodation.imageUrl!.isNotEmpty)
                        ? Image.network(
                            accommodation.imageUrl![0],
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/ard_logo.png',
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            'assets/images/ard_logo.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),

                // Favorite Button
                Positioned(
                  top: 16.h,
                  right: 16.w,
                  child: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      accommodation?.isFav ?? false
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: accommodation?.isFav ?? false
                          ? Colors.red
                          : appTextColor,
                      size: 22.sp,
                    ),
                  ),
                ),
              ],
            ),

            // Content Section
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    accommodation.accomodationName ?? 'Unique Experience',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: appTextColor,
                      height: 1.2,
                      letterSpacing: -0.5,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Duration
                  Text(
                    accommodation.address ?? 'N/M',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: appTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // // Likely to sell out badge
                  // Container(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: 14.w,
                  //     vertical: 8.h,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: Color(0xFFFFB3BA),
                  //     borderRadius: BorderRadius.circular(8.r),
                  //   ),
                  //   child: Text(
                  //     'Likely to sell out',
                  //     style: TextStyle(
                  //       fontSize: 13.sp,
                  //       fontWeight: FontWeight.w600,
                  //       color: Colors.black87,
                  //     ),
                  //   ),
                  // ),

                  // Rating
                  Row(
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          final rate = accommodation.rate ?? 0;

                          return Padding(
                            padding: EdgeInsets.only(right: 2.w),
                            child: Icon(
                              Icons.star_rounded,
                              color: index < rate
                                  ? Color(0xFFFFB300)
                                  : Colors.grey,
                              size: 20.sp,
                            ),
                          );
                        }),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '${(accommodation.rate ?? 0).toStringAsFixed(1)}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: appTextColor,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),
                  Text(
                    'From',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: appTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  // Price
                  Row(
                    children: [
                      Text(
                        '\$${(accommodation.price ?? 0.0).toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w800,
                          color: appTextColor,
                          letterSpacing: -1,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'per person',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: appTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
