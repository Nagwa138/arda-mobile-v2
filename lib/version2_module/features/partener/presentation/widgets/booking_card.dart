import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/custom_image.dart';
import 'package:PassPort/version2_module/core/enums/booking_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/models/partner_booking_model.dart';

class BookingCard extends StatelessWidget {
  final PartnerBookingModel booking;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback onViewDetails;

  const BookingCard({
    super.key,
    required this.booking,
    this.onAccept,
    this.onReject,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4)),
        ]),
      child: InkWell(
        onTap: onViewDetails,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with guest info and status
              Row(
                children: [
                  Container(
                    width: 48.r,
                    height: 48.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200]),
                    child: booking.profileImage != null
                        ? ClipOval(
                            child: CustomImage(
                              booking.profileImage!,
                              width: 48.r,
                              height: 48.r,
                              fit: BoxFit.cover))
                        : Icon(Icons.person, color: Colors.grey[600])),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.guestName,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: appTextColor)),
                        Text(
                          booking.serviceName,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      ])),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h),
                    decoration: BoxDecoration(
                      color: booking.bookingStatus.backgroundColor,
                      borderRadius: BorderRadius.circular(20.r)),
                    child: Text(
                      booking.statusDisplayText.toUpperCase(),
                      style: TextStyle(
                        color: booking.bookingStatus.statusColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600))),
                ]),

              SizedBox(height: 16.h),

              // Booking details
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12.r)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 16.sp, color: Colors.grey[600]),
                        SizedBox(width: 8.w),
                        Text(
                          'Check-in: ${booking.formattedCheckIn}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[700])),
                        Spacer(),
                        Text(
                          '${booking.numberOfNights} nights',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500)),
                      ]),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined,
                            size: 16.sp, color: Colors.grey[600]),
                        SizedBox(width: 8.w),
                        Text(
                          'Check-out: ${booking.formattedCheckOut}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[700])),
                      ]),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(Icons.people,
                            size: 16.sp, color: Colors.grey[600]),
                        SizedBox(width: 8.w),
                        Text(
                          '${booking.guests} ${booking.guests > 1 ? 'Guests' : 'Guest'}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[700])),
                        Spacer(),
                        Text(
                          booking.formattedAmount,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: appTextColor,
                            fontWeight: FontWeight.bold)),
                      ]),
                  ])),

              // Status-based action buttons
              _buildStatusBasedActions(),

              // Booking date info
              SizedBox(height: 12.h),
              Text(
                'Booked on ${booking.formattedBookingDate}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[500])),
            ]))));
  }

  /// Build action buttons based on booking status
  Widget _buildStatusBasedActions() {
    switch (booking.bookingStatus) {
      case BookingStatus.pending:
        return _buildPendingActions();
      case BookingStatus.upcoming:
        return _buildUpcomingActions();
      case BookingStatus.completed:
        return _buildCompletedActions();
      case BookingStatus.cancelled:
        return _buildCancelledActions();
    }
  }

  /// Actions for pending bookings
  Widget _buildPendingActions() {
    if (onAccept == null && onReject == null) return SizedBox.shrink();

    return Column(
      children: [
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: BookingStatus.pending.backgroundColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
                color:
                    BookingStatus.pending.statusColor.withValues(alpha: 0.3))),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.pending_actions,
                      color: BookingStatus.pending.statusColor, size: 16.sp),
                  SizedBox(width: 8.w),
                  Text(
                    'Action Required',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: BookingStatus.pending.statusColor)),
                ]),
              SizedBox(height: 12.h),
              Row(
                children: [
                  if (onReject != null) ...[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onReject,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: BorderSide(color: Colors.red),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.close, size: 16.sp),
                            SizedBox(width: 4.w),
                            Text('Reject'),
                          ]))),
                    SizedBox(width: 12.w),
                  ],
                  if (onAccept != null) ...[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onAccept,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check, color: Colors.white, size: 16.sp),
                            SizedBox(width: 4.w),
                            Text(
                              'Accept',
                              style: TextStyle(color: Colors.white)),
                          ]))),
                  ],
                ]),
            ])),
      ]);
  }

  /// Actions for upcoming bookings
  Widget _buildUpcomingActions() {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: BookingStatus.upcoming.backgroundColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
                color:
                    BookingStatus.upcoming.statusColor.withValues(alpha: 0.3))),
          child: Row(
            children: [
              Icon(Icons.schedule,
                  color: BookingStatus.upcoming.statusColor, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Confirmed Booking',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: BookingStatus.upcoming.statusColor)),
                    Text(
                      'Booking has been accepted and confirmed',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600])),
                  ])),
              TextButton(
                onPressed: onViewDetails,
                style: TextButton.styleFrom(
                  foregroundColor: BookingStatus.upcoming.statusColor),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Details'),
                    SizedBox(width: 4.w),
                    Icon(Icons.arrow_forward_ios, size: 12.sp),
                  ])),
            ])),
      ]);
  }

  /// Actions for completed bookings
  Widget _buildCompletedActions() {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: BookingStatus.completed.backgroundColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
                color:
                    BookingStatus.completed.statusColor.withValues(alpha: 0.3))),
          child: Row(
            children: [
              Icon(Icons.check_circle,
                  color: BookingStatus.completed.statusColor, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking Completed',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: BookingStatus.completed.statusColor)),
                    Text(
                      'Service has been successfully delivered',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600])),
                  ])),
              TextButton(
                onPressed: onViewDetails,
                style: TextButton.styleFrom(
                  foregroundColor: BookingStatus.completed.statusColor),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Details'),
                    SizedBox(width: 4.w),
                    Icon(Icons.arrow_forward_ios, size: 12.sp),
                  ])),
            ])),
      ]);
  }

  /// Actions for cancelled bookings
  Widget _buildCancelledActions() {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: BookingStatus.cancelled.backgroundColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
                color:
                    BookingStatus.cancelled.statusColor.withValues(alpha: 0.3))),
          child: Row(
            children: [
              Icon(Icons.cancel,
                  color: BookingStatus.cancelled.statusColor, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking Cancelled',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: BookingStatus.cancelled.statusColor)),
                    Text(
                      'This booking has been cancelled',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600])),
                  ])),
              TextButton(
                onPressed: onViewDetails,
                style: TextButton.styleFrom(
                  foregroundColor: BookingStatus.cancelled.statusColor),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Details'),
                    SizedBox(width: 4.w),
                    Icon(Icons.arrow_forward_ios, size: 12.sp),
                  ])),
            ])),
      ]);
  }
}
