// import 'dart:ui';

// import 'package:PassPort/components/color/color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ExploreSearch extends StatelessWidget {
//   const ExploreSearch({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 52.h,
//       margin: EdgeInsets.symmetric(horizontal: 0.w),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16.r),
//         gradient: LinearGradient(
//           colors: [
//             accentColor,
//             accentColor.withValues(alpha:0.95),
//           ],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xff1E2A5C).withValues(alpha:0.3),
//             blurRadius: 16,
//             offset: const Offset(0, 4),
//             spreadRadius: 0,
//           ),
//           BoxShadow(
//             color: const Color(0xff636C7E).withValues(alpha:0.15),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//             spreadRadius: -2,
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(16.r),
//           onTap: () {
//             Navigator.pushNamed(context, 'travellerSearch');
//             print('Search tapped - navigating...');
//           },
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
//             child: Row(
//               children: [
//                 // Search Icon with Background
//                 Container(
//                   padding: EdgeInsets.all(8.w),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withValues(alpha:0.15),
//                     borderRadius: BorderRadius.circular(10.r),
//                   ),
//                   child: Image.asset(
//                     'assets/images/search.png',
//                     width: 18.w,
//                     height: 18.h,
//                     color: Colors.white,
//                   ),
//                 ),

//                 SizedBox(width: 14.w),

//                 // Search Text
//                 Expanded(
//                   child: Text(
//                     'Search destinations, activities...',
//                     style: TextStyle(
//                       color: Colors.white.withValues(alpha:0.85),
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.w400,
//                       letterSpacing: 0.2,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),

//                 SizedBox(width: 8.w),

//                 // Filter Icon (Optional)
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:PassPort/components/color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreSearch extends StatelessWidget {
  const ExploreSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      margin: EdgeInsets.symmetric(horizontal: 0.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: LinearGradient(
          colors: [
            lightBrown,
            lightBrown.withValues(alpha: 0.95),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: lightBrown.withValues(alpha: .3),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: lightBrown.withValues(alpha: .15),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            Navigator.pushNamed(context, 'travellerSearch');
            print('Search tapped - navigating...');
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Image.asset(
              'assets/images/search.png',
              width: 16.w,
              height: 14.h,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
