import 'package:PassPort/version2_module/core/const/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/trips_cubit/trips_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/trips_cubit/trips_state.dart';

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
              body: Center(
                child: CircularProgressIndicator(color: accentColor),
              ),
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

          return Scaffold(
            backgroundColor: appBackgroundColor,
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
                          color: Colors.black.withOpacity(0.15),
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
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            if (tripData.fav == true) {
                              TripsCubit.get(context).deleteFavouriteOfTrips(
                                  tripId: tripData.id.toString());
                              TripsCubit.get(context).changeFav(tripData.fav);
                            } else {
                              TripsCubit.get(context).addFavouriteOfTrips(
                                  tripId: tripData.id.toString());
                              TripsCubit.get(context).changeFav(tripData.fav);
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
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Trip Name
                        Text(
                          _getDisplayText(tripData.name),
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                            height: 1.3,
                          ),
                        ),

                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            // Provider Badge
                            if (tripData.providerName != null &&
                                tripData.providerName!.isNotEmpty)
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.business,
                                        color: AppColors.primaryColor,
                                        size: 16.sp),
                                    SizedBox(width: 8.w),
                                    Text(
                                      _getDisplayText(tripData.providerName),
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            SizedBox(width: 16.w),

                            // Duration Badge
                            if (tripData.durationInHours != null)
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.access_time,
                                        color: accentColor, size: 16.sp),
                                    SizedBox(width: 8.w),
                                    Text(
                                      "${tripData.durationInHours} Hours",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: accentColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),

                        SizedBox(height: 24.h),

                        // From/To Section (Original Design)
                        Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // From (Pickup Location)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "From",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      _getDisplayText(
                                          tripData.pickupMeetingLocation),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: accentColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      _getDisplayText(
                                          tripData.startDateAndMovementTime),
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Arrow Icon
                              Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: accentColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: accentColor,
                                  size: 24.sp,
                                ),
                              ),

                              // To (Destination)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "To",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      _getDisplayText(tripData.endPoint),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: accentColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      _getDisplayText(
                                          tripData.endDateAdnArrivalTime),
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // Price Display
                        Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                accentColor,
                                accentColor.withOpacity(0.8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: accentColor.withOpacity(0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Price Per Person",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: white.withOpacity(0.9),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "${tripData.pricePerPerson ?? 0} EGP",
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Icon(
                                  Icons.payments,
                                  color: white,
                                  size: 32.sp,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // About Section
                        _buildSectionTitle("About Trip"),
                        SizedBox(height: 12.h),
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            _getDisplayText(tripData.description),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[700],
                              height: 1.6,
                            ),
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // What's Included Section
                        _buildSectionTitle("What's Included"),
                        SizedBox(height: 12.h),
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: Colors.green.withOpacity(0.3),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.check_circle,
                                  color: Colors.green, size: 24.sp),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  _getDisplayText(tripData.whatsIncluded),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[700],
                                    height: 1.6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Rules and Cancellation Policy Section
                        _buildSectionTitle("Rules & Cancellation"),
                        SizedBox(height: 12.h),
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: Colors.orange.withOpacity(0.3),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.rule,
                                  color: Colors.orange, size: 24.sp),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  _getDisplayText(
                                      tripData.rulesAndCancellationPolicy),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[700],
                                    height: 1.6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Important Information Section
                        _buildSectionTitle("Important Information"),
                        SizedBox(height: 12.h),
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: Colors.red.withOpacity(0.3),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.info, color: Colors.red, size: 24.sp),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  _getDisplayText(
                                      tripData.importantInformation),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[700],
                                    height: 1.6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 80.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: tripData.ended != true
                ? Container(
                    decoration: BoxDecoration(
                      color: white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, -3),
                        ),
                      ],
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
                                  'price': tripData.pricePerPerson.toString(),
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
                                  color: white.withOpacity(0.2),
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
          );
        },
      ),
    );
  }

  Widget _buildHeroImage(dynamic tripData) {
    final imageUrl = tripData.image?.toString();

    return Stack(
      fit: StackFit.expand,
      children: [
        imageUrl != null && imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        color: accentColor,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[100],
                  child: Center(
                    child: Image.asset(
                      _placeholderImage,
                      fit: BoxFit.contain,
                      width: 150.w,
                    ),
                  ),
                ),
              )
            : Container(
                color: Colors.grey[100],
                child: Center(
                  child: Image.asset(
                    _placeholderImage,
                    fit: BoxFit.contain,
                    width: 150.w,
                  ),
                ),
              ),
        // Gradient overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.4),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 24.h,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: accentColor,
          ),
        ),
      ],
    );
  }
}
