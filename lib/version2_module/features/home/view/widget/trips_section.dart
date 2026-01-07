import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/models/traveller/trips_model/trips_model.dart'
    as trips_model;
import 'package:PassPort/version2_module/features/home/view/widget/trip_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../view_model/trips_cubit.dart';
import '../../view_model/trips_state.dart';

class TripsSection extends StatefulWidget {
  const TripsSection({super.key});

  @override
  State<TripsSection> createState() => _TripsSectionState();
}

class _TripsSectionState extends State<TripsSection> {
  int currentIndex = 0;
  final CarouselSliderController carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripsCubit, TripsState>(
      builder: (context, state) {
        if (state is TripsSuccess) {
          if (state.trips.isEmpty) {
            return const SizedBox.shrink();
          }
          return _buildTripsSection(state.trips);
        }

        if (state is TripsError) {
          return _buildErrorState(state.message);
        }

        return _buildLoadingState();
      },
    );
  }

  Widget _buildTripsSection(List trips) {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Journey Planner',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: lightBrown,
                    letterSpacing: 1,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Explore Egypt With Experts, Book Full-day Or Multi-day trips guided by locals',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: lightText,
                    height: 1.4,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10.h),

          // Carousel Slider
          CarouselSlider.builder(
            carouselController: carouselController,
            itemCount: trips.length,
            options: CarouselOptions(
              height: 380.h,
              viewportFraction: 0.87,        
              enlargeCenterPage: true,
              enlargeFactor: 0.10,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              padEnds: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            itemBuilder: (context, index, realIndex) {
              return AnimatedScale(
                scale: currentIndex == index ? 1.0 : 0.92,
                duration: const Duration(milliseconds: 300),
                child: TripCard(
                  trip: trips[index],
                  onTap: () {
                    Navigator.pushNamed(context, 'detailsTrips', arguments: {
                      'id': trips[index].id,
                      'text': 'trips',
                      'num': trips[index].availableSeats,
                    });
                  },
                ),
              );
            },
          ),

          SizedBox(height: 20.h),

          // Dot Indicator
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: trips.asMap().entries.map((entry) {
          //     return GestureDetector(
          //       onTap: () {
          //         carouselController.animateToPage(
          //           entry.key,
          //           duration: const Duration(milliseconds: 400),
          //           curve: Curves.easeInOutCubic,
          //         );
          //       },
          //       child: AnimatedContainer(
          //         duration: const Duration(milliseconds: 300),
          //         curve: Curves.easeInOut,
          //         width: currentIndex == entry.key ? 28.w : 8.w,
          //         height: 8.h,
          //         margin: EdgeInsets.symmetric(horizontal: 4.w),
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(4.r),
          //           color: currentIndex == entry.key
          //               ? AppColors.primaryColor
          //               : Colors.grey.withValues(alpha:0.3),
          //           boxShadow: currentIndex == entry.key
          //               ? [
          //                   BoxShadow(
          //                     color: AppColors.primaryColor.withValues(alpha:0.3),
          //                     blurRadius: 8,
          //                     offset: const Offset(0, 2),
          //                   ),
          //                 ]
          //               : [],
          //         ),
          //       ),
          //     );
          //   }).toList(),
          // ),
        ],
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF233A6A)
              : const Color(0xFF233A6A).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: const Color(0xFF233A6A).withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Icon(
          icon,
          size: 16.sp,
          color: isActive ? Colors.white : const Color(0xFF233A6A),
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      height: 220.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.red.shade200, width: 1.5),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 48.sp,
                color: Colors.red.shade600,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Failed to load trips',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.red.shade900,
              ),
            ),
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.red.shade700,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Skeleton
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeletonizer(
                  enabled: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 180.w,
                        height: 22.h,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        width: double.infinity,
                        height: 14.h,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          // Carousel Skeleton
          Skeletonizer(
            enabled: true,
            child: CarouselSlider.builder(
              itemCount: 3,
              options: CarouselOptions(
                height: 380.h,
                viewportFraction: 0.87,
                enlargeCenterPage: true,
                autoPlay: false,
                padEnds: true,
              ),
              itemBuilder: (context, index, realIndex) {
                return TripCard(
                  trip: trips_model.Data(),
                );
              },
            ),
          ),

          SizedBox(height: 20.h),

          // Dots Skeleton
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return Container(
                width: 8.w,
                height: 8.h,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: Colors.grey.withValues(alpha: 0.3),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
