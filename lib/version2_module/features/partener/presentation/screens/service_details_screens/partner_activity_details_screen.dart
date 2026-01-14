import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/custom_image.dart';
import 'package:PassPort/version2_module/core/enums/snack_bar_type.dart';
import 'package:PassPort/version2_module/core/extensions/show_snack_bar_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PartnerActivityDetailsScreen extends StatelessWidget {
  const PartnerActivityDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> activityData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
        backgroundColor: appBackgroundColor,
        body: CustomScrollView(slivers: [
          // Custom App Bar with Image
          SliverAppBar(
              expandedHeight: 300.h,
              pinned: true,
              backgroundColor: appTextColor,
              leading: Container(
                  margin: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: IconButton(
                      icon: Icon(Icons.arrow_back, color: appTextColor),
                      onPressed: () => Navigator.pop(context))),
              actions: [
                Container(
                    margin: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: IconButton(
                        icon: Icon(Icons.edit, color: appTextColor),
                        onPressed: () {
                          // Edit activity functionality
                        })),
              ],
              flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                      tag: 'activity_${activityData['id']}',
                      child: CustomImage(activityData['image'] ?? '',
                          fit: BoxFit.cover)))),

          // Content
          SliverToBoxAdapter(
              child: Container(
                  decoration: BoxDecoration(
                      color: appBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r))),
                  child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Status Badge
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                    color:
                                        _getStatusColor(activityData['status']),
                                    borderRadius: BorderRadius.circular(20.r)),
                                child: Text(activityData['status'] ?? 'Active',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600))),

                            SizedBox(height: 16.h),

                            // Activity Name and Price
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Text(
                                          activityData['name'] ??
                                              'Activity Name',
                                          style: TextStyle(
                                              fontSize: 24.sp,
                                              fontWeight: FontWeight.bold,
                                              color: appTextColor))),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 8.h),
                                      decoration: BoxDecoration(
                                          color: appTextColor.withValues(
                                              alpha: 0.1),
                                          borderRadius:
                                              BorderRadius.circular(15.r)),
                                      child: Text(
                                          '${activityData['pricePerPerson'] ?? '0'} EGP/person',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: appTextColor))),
                                ]),

                            SizedBox(height: 12.h),

                            // Rating and Reviews
                            Row(children: [
                              RatingBarIndicator(
                                  rating:
                                      (activityData['rate'] ?? 0).toDouble(),
                                  itemBuilder: (context, index) =>
                                      Icon(Icons.star, color: Colors.amber),
                                  itemCount: 5,
                                  itemSize: 20.sp),
                              SizedBox(width: 8.w),
                              Text('${activityData['rate'] ?? 0.0}',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: appTextColor)),
                              SizedBox(width: 4.w),
                              Text(
                                  '(${activityData['reviewCount'] ?? 0} reviews)',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey[600])),
                            ]),

                            SizedBox(height: 20.h),

                            // Activity Duration
                            _buildInfoSection(
                                'Duration',
                                '${activityData['durationInHours'] ?? 0} hours',
                                Icons.access_time),

                            SizedBox(height: 16.h),

                            // Location
                            _buildInfoSection(
                                'Location',
                                activityData['activityLocation'] ??
                                    'Not specified',
                                Icons.location_on),

                            SizedBox(height: 16.h),

                            // Provider Name
                            _buildInfoSection(
                                'Provider',
                                activityData['providerName'] ?? 'Not specified',
                                Icons.business),

                            SizedBox(height: 16.h),

                            // Work Times
                            _buildInfoSection(
                                'Work Times',
                                activityData['workTimes'] ?? 'Not specified',
                                Icons.schedule),

                            SizedBox(height: 20.h),

                            // Description
                            _buildSectionTitle('Description'),
                            SizedBox(height: 8.h),
                            Text(
                                activityData['description'] ??
                                    'No description available',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[700],
                                    height: 1.5)),

                            SizedBox(height: 20.h),

                            // What's Included
                            if (activityData['whatsIncluded'] != null)
                              _buildExpandableSection(
                                  'What\'s Included',
                                  activityData['whatsIncluded'],
                                  Icons.check_circle),

                            SizedBox(height: 16.h),

                            // Rules and Cancellation Policy
                            if (activityData['rulesAndCancellationPolicy'] !=
                                null)
                              _buildExpandableSection(
                                  'Rules & Cancellation Policy',
                                  activityData['rulesAndCancellationPolicy'],
                                  Icons.rule),

                            SizedBox(height: 16.h),

                            // Important Information
                            if (activityData['importantInformation'] != null)
                              _buildExpandableSection(
                                  'Important Information',
                                  activityData['importantInformation'],
                                  Icons.info),

                            SizedBox(height: 30.h),

                            // Action Buttons
                            Row(children: [
                              Expanded(
                                  child: ElevatedButton.icon(
                                      onPressed: () {
                                        // Edit activity
                                      },
                                      icon:
                                          Icon(Icons.edit, color: Colors.white),
                                      label: Text('Edit Activity',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600)),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: appTextColor,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16.h),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      15.r))))),
                              SizedBox(width: 12.w),
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.red, width: 2),
                                      borderRadius:
                                          BorderRadius.circular(15.r)),
                                  child: IconButton(
                                      onPressed: () {
                                        _showDeleteDialog(context);
                                      },
                                      icon: Icon(Icons.delete,
                                          color: Colors.red, size: 24.sp),
                                      padding: EdgeInsets.all(16.w))),
                            ]),

                            SizedBox(height: 20.h),
                          ])))),
        ]));
  }

  Widget _buildInfoSection(String title, String value, IconData icon) {
    return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2)),
            ]),
        child: Row(children: [
          Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                  color: appTextColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r)),
              child: Icon(icon, color: appTextColor, size: 20.sp)),
          SizedBox(width: 12.w),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500)),
                SizedBox(height: 2.h),
                Text(value,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: appTextColor,
                        fontWeight: FontWeight.w600)),
              ])),
        ]));
  }

  Widget _buildSectionTitle(String title) {
    return Text(title,
        style: TextStyle(
            fontSize: 18.sp, fontWeight: FontWeight.bold, color: appTextColor));
  }

  Widget _buildExpandableSection(String title, String content, IconData icon) {
    return Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2)),
            ]),
        child: ExpansionTile(
            leading: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                    color: appTextColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Icon(icon, color: appTextColor, size: 20.sp)),
            title: Text(title,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: appTextColor)),
            children: [
              Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Text(content,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[700],
                          height: 1.5))),
            ]));
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return appTextColor;
    }
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r)),
                title: Text('Delete Activity',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: appTextColor)),
                content: Text(
                    'Are you sure you want to delete this activity? This action cannot be undone.',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[700])),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel',
                          style: TextStyle(color: Colors.grey[600]))),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Delete activity logic
                        context.showCustomSnackBar(
                            'Activity deleted successfully',
                            type: SnackBarType.error);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r))),
                      child: Text('Delete',
                          style: TextStyle(color: Colors.white))),
                ]));
  }
}
