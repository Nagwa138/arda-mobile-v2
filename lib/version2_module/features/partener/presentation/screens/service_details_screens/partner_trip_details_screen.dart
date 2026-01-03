import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/version2_module/features/partener/presentation/models/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PartnerTripDetailsScreen extends StatelessWidget {
  const PartnerTripDetailsScreen({super.key});

  static const String _placeholderImage = 'assets/images/ard_logo.png';

  @override
  Widget build(BuildContext context) {
    final TripModel tripData =
        ModalRoute.of(context)!.settings.arguments as TripModel;

    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with Image
          SliverAppBar(
            expandedHeight: 320.h,
            pinned: true,
            backgroundColor: appTextColor,
            leading: Container(
              margin: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white,
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
                icon: Icon(Icons.arrow_back_ios_new,
                    color: appTextColor, size: 20.r),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeroImage(tripData),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: appBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Badge
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: _getStatusColor(tripData.status),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        tripData.status ?? 'Active',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Trip Name
                    Text(
                      tripData.title ?? 'Trip Name',
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                        color: appTextColor,
                        height: 1.3,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Price Container
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: appTextColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.attach_money,
                              color: appTextColor, size: 20.sp),
                          SizedBox(width: 4.w),
                          Text(
                            '${tripData.priceText ?? '0'} EGP',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: appTextColor,
                            ),
                          ),
                          Text(
                            ' / person',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Trip Duration
                    _buildInfoSection(
                      'Duration',
                      "${tripData.durationInHours ?? 'N/A'} hours",
                      Icons.access_time,
                    ),

                    SizedBox(height: 12.h),

                    // Pickup Location
                    _buildInfoSection(
                      'Pickup/Meeting Location',
                      "${tripData.location ?? 'N/A'}",
                      Icons.location_on,
                    ),

                    SizedBox(height: 12.h),

                    // End Point
                    _buildInfoSection(
                      'End Point',
                      "${tripData.endPoint ?? 'N/A'}",
                      Icons.flag,
                    ),

                    SizedBox(height: 12.h),

                    // Provider Name
                    _buildInfoSection(
                      'Provider',
                      "${tripData.providerName ?? 'N/A'}",
                      Icons.business,
                    ),

                    SizedBox(height: 24.h),

                    // Description
                    _buildSectionTitle('Description'),
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.08),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        "${tripData.description ?? 'No description available'}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[700],
                          height: 1.6,
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // What's Included
                    if (tripData.whatsIncluded.isNotEmpty)
                      _buildExpandableSection(
                        'What\'s Included',
                        tripData.whatsIncluded,
                        Icons.check_circle_outline,
                      ),

                    // Rules and Cancellation Policy
                    if (tripData.rulesAndCancellationPolicy.isNotEmpty)
                      _buildExpandableSection(
                        'Rules & Cancellation Policy',
                        tripData.rulesAndCancellationPolicy,
                        Icons.policy_outlined,
                      ),

                    // Important Information
                    if (tripData.importantInformation.isNotEmpty)
                      _buildExpandableSection(
                        'Important Information',
                        tripData.importantInformation,
                        Icons.info_outline,
                      ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImage(TripModel tripData) {
    final imageUrl = tripData.imageUrl;

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
                        color: appTextColor,
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
                Colors.black.withValues(alpha: 0.3),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: appTextColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: appTextColor, size: 22.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: appTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 24.h,
          decoration: BoxDecoration(
            color: appTextColor,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: appTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildExpandableSection(String title, String content, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            childrenPadding: EdgeInsets.zero,
            leading: Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: appTextColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: appTextColor, size: 22.sp),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: appTextColor,
              ),
            ),
            iconColor: appTextColor,
            collapsedIconColor: appTextColor,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.r),
                    bottomRight: Radius.circular(16.r),
                  ),
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
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      case 'completed':
        return Colors.blue;
      default:
        return appTextColor;
    }
  }
}
