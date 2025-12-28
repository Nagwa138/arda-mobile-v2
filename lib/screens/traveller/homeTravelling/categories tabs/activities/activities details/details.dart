import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/activity_cubit/activity_cubit.dart';
import 'package:PassPort/services/traveller/homeTravellerNavBarCubit/activity_cubit/activity_stata.dart';
import 'package:PassPort/version2_module/core/widgets/custom_button.dart';

import '../../../../../../models/traveller/activity/activity_id_model.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  static const String _placeholderImage = 'assets/images/ard_logo.png';

  String _getDisplayText(dynamic value) {
    if (value == null || (value is String && value.trim().isEmpty)) {
      return "No Details";
    }
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String;
    return BlocProvider(
      create: (BuildContext context) =>
          ActivityCubit()..getActivityById(activityId: id),
      child: BlocConsumer<ActivityCubit, ActivityState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetActivityByIdLoading) {
            return Scaffold(
              backgroundColor: appBackgroundColor,
              body: Center(
                child: CircularProgressIndicator(color: orange),
              ),
            );
          }

          final activity = ActivityCubit.get(context).getActivityByIdModel;
          final activityData = activity?.data;

          if (activityData == null) {
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
                  "No activity data available",
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
                    if (activityData.isFav != false)
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
                            if (activityData.isFav == true) {
                              ActivityCubit.get(context)
                                  .deleteFavouriteOfActivity(
                                      activityId: activityData.id.toString());
                              ActivityCubit.get(context)
                                  .changeFavourite(activityData.isFav);
                            } else {
                              ActivityCubit.get(context).addFavouriteOfActivity(
                                  activityId: activityData.id.toString());
                              ActivityCubit.get(context)
                                  .changeFavourite(activityData.isFav);
                            }
                          },
                          icon: Icon(
                            activityData.isFav == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: activityData.isFav == true
                                ? Colors.red
                                : Colors.grey[700],
                            size: 24.r,
                          ),
                        ),
                      ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: _buildHeroImage(activityData),
                  ),
                ),

                // Content
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Activity Name
                        Text(
                          _getDisplayText(activityData.name),
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                            height: 1.3,
                          ),
                        ),

                        SizedBox(height: 12.h),

                        // Provider Badge
                        if (activityData.providerName != null &&
                            activityData.providerName!.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: accentColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.business,
                                    color: accentColor, size: 16.sp),
                                SizedBox(width: 8.w),
                                Text(
                                  _getDisplayText(activityData.providerName),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: accentColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        SizedBox(height: 16.h),

                        // Price, Duration, and Work Times Row
                        Row(
                          children: [
                            Expanded(
                              child: Container(
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
                                child: Column(
                                  children: [
                                    Icon(Icons.attach_money,
                                        color: accentColor, size: 28.sp),
                                    SizedBox(height: 8.h),
                                    Text(
                                      "${activityData.pricePerPerson ?? 0}",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: accentColor,
                                      ),
                                    ),
                                    Text(
                                      "EGP/person",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Container(
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
                                child: Column(
                                  children: [
                                    Icon(Icons.access_time,
                                        color: accentColor, size: 28.sp),
                                    SizedBox(height: 8.h),
                                    Text(
                                      "${activityData.durationInHours ?? 0}",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: accentColor,
                                      ),
                                    ),
                                    Text(
                                      "Hours",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16.h),

                        // Location and Work Times Cards
                        Row(
                          children: [
                            // Location Card
                            Expanded(
                              child: Container(
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
                                child: Column(
                                  children: [
                                    Icon(Icons.location_on,
                                        color: Colors.red, size: 28.sp),
                                    SizedBox(height: 8.h),
                                    Text(
                                      "Location",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      _getDisplayText(
                                          activityData.activityLocation),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            // Work Times Card
                            Expanded(
                              child: Container(
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
                                child: Column(
                                  children: [
                                    Icon(Icons.schedule,
                                        color: Colors.blue, size: 28.sp),
                                    SizedBox(height: 8.h),
                                    Text(
                                      "Work Times",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      _getDisplayText(activityData.workTimes),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16.h),

                        // Rating Section
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
                          child: Row(
                            children: [
                              // Stars
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => Icon(
                                    index < (activityData.rate?.toInt() ?? 0)
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: accentColor,
                                    size: 24.r,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                "${activityData.rate?.toStringAsFixed(1) ?? '0.0'}",
                                style: TextStyle(
                                  color: accentColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "commentsAndRating", arguments: {
                                    "id": activityData.id,
                                    'state': '1'
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 6.h),
                                  decoration: BoxDecoration(
                                    color: accentColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${activityData.reviewersCount ?? 0} Reviews",
                                        style: TextStyle(
                                          color: accentColor,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      Icon(Icons.arrow_forward_ios,
                                          color: accentColor, size: 12.sp),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Description Section
                        _buildSectionTitle('Description'),
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
                            _getDisplayText(activityData.description),
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
                                  _getDisplayText(activityData.whatsIncluded),
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
                                      activityData.rulesAndCancellationPolicy),
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
                                      activityData.importantInformation),
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
            bottomNavigationBar: Container(
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: CustomButton(
                    text: "Book Now",
                    onPressed: () {
                      Navigator.pushNamed(context, 'activityBooking',
                          arguments: {
                            'id': activityData.id,
                            'price': activityData.pricePerPerson.toString()
                          });
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroImage(ActivityData activityData) {
    final imageUrl = activityData.image;

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
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: accentColor,
          ),
        ),
      ],
    );
  }
}
