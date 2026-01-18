import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/custom_lodaing_indicator.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/trips_cubit/trips_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/trips_cubit/trips_state.dart';
import 'package:PassPort/version2_module/core/widgets/custom_carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTrips extends StatelessWidget {
  const DetailsTrips({super.key});

  static const String _placeholderImage = 'assets/images/ard_logo.png';

  String _getDisplayText(dynamic value) {
    if (value == null || (value is String && value.trim().isEmpty)) {
      return "No Details";
    }
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return BlocProvider(
      create: (BuildContext context) =>
          TripsCubit()..getAllTripById(id: arguments['id']),
      child: BlocConsumer<TripsCubit, TripsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetTripByIdLoading) {
            return Scaffold(
              backgroundColor: appBackgroundColor,
              body: CustomLodaingIndicator(),
            );
          }

          final tripData = TripsCubit.get(context).tripsByIdModel?.data;

          if (tripData == null) {
            return Scaffold(
              backgroundColor: appBackgroundColor,
              appBar: AppBar(
                backgroundColor: appBackgroundColor,
                elevation: 0,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
              ),
              body: Center(
                child: Text(
                  "No trip data available",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            );
          }

          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: CustomScrollView(
                  slivers: [
                    // Hero Image with App Bar
                    SliverAppBar(
                      expandedHeight: 320.h,
                      pinned: true,
                      backgroundColor: appBackgroundColor,
                      leading: Container(
                        margin: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black87,
                            size: 20.r,
                          ),
                        ),
                      ),
                      actions: [
                        if (arguments['text'] != "Favourite")
                          Container(
                            margin: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.15),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: () {
                                if (tripData.fav == true) {
                                  TripsCubit.get(context)
                                      .deleteFavouriteOfTrips(
                                          tripId: tripData.id.toString());
                                  TripsCubit.get(context)
                                      .changeFav(tripData.fav);
                                } else {
                                  TripsCubit.get(context).addFavouriteOfTrips(
                                      tripId: tripData.id.toString());
                                  TripsCubit.get(context)
                                      .changeFav(tripData.fav);
                                }
                              },
                              icon: Icon(
                                tripData.fav == true
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: tripData.fav == true
                                    ? Colors.red
                                    : Colors.grey[700],
                                size: 24.r,
                              ),
                            ),
                          ),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        background: _buildHeroImage(tripData),
                      ),
                    ),

                    // Content
                    SliverToBoxAdapter(
                      child: Container(
                        decoration: BoxDecoration(
                          // color: backgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24.r),
                            topRight: Radius.circular(24.r),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Trip Name
                              Text(
                                _getDisplayText(tripData.name).toUpperCase(),
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black87,
                                  height: 1.3,
                                  letterSpacing: 0.5,
                                ),
                              ),

                              SizedBox(height: 8.h),

                              // Location and Rating Row
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _getDisplayText(
                                          tripData.pickupMeetingLocation),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 5.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: accentColor,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: const Color(0xFFFFD700),
                                          size: 14.sp,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          "4.6",
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 24.h),

                              // About This Service Section
                              _buildCleanSection(
                                "About This Service ( Full Description )",
                                _getDisplayText(tripData.description),
                              ),

                              SizedBox(height: 16.h),

                              // What's Included Section
                              _buildCleanSection(
                                "What's Included",
                                _getDisplayText(tripData.whatsIncluded),
                              ),

                              SizedBox(height: 16.h),

                              // Rules and Cancellation Policy Section
                              _buildCleanSection(
                                "Rules And Cancellation policy",
                                _getDisplayText(
                                    tripData.rulesAndCancellationPolicy),
                              ),

                              SizedBox(height: 16.h),

                              // Important Information Section
                              _buildCleanSection(
                                "Important Information",
                                _getDisplayText(tripData.importantInformation),
                              ),

                              SizedBox(height: 16.h),

                              // Customer reviews Section (Placeholder)
                              _buildCleanSection(
                                "Customer reviews",
                                "No reviews yet for this trip.",
                              ),

                              SizedBox(height: 80.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: tripData.ended != true
                    ? Container(
                        decoration: BoxDecoration(
                          color: appBackgroundColor,
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black.withValues(alpha:0.08),
                          //     blurRadius: 10,
                          //     offset: const Offset(0, -3),
                          //   ),
                          // ],
                        ),
                        child: SafeArea(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 16.h),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accentColor,
                                foregroundColor: white,
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                                elevation: 0,
                                shadowColor: Colors.transparent,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, "tripBooking",
                                    arguments: {
                                      'id': arguments['id'],
                                      'price':
                                          tripData.pricePerPerson.toString(),
                                      "num": arguments['num']
                                    });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Book Now",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: white.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      "${tripData.pricePerPerson ?? 0} EGP",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeroImage(dynamic tripData) {
    // Prepare images list - use backend images when available, otherwise use dummy
    final List<String> images = [];

    // Check if backend provides images array (future implementation)
    // For now, use single image or dummy images
    if (tripData.image != null && tripData.image.toString().isNotEmpty) {
      images.add(tripData.image.toString());
    }

    // Add dummy images to make it a carousel (3 images total)
    while (images.length < 3) {
      images.add(
          'https://zadnaeg.com/wp-content/uploads/2017/06/wood-blog-placeholder.jpg');
    }

    return CustomCarouselSlider(
      images: images,
      placeholderImage: _placeholderImage,
    );
  }

  Widget _buildCleanSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
