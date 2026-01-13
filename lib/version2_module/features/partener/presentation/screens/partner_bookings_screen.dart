import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/version2_module/core/enums/booking_status.dart';
import 'package:PassPort/version2_module/core/enums/snack_bar_type.dart';
import 'package:PassPort/version2_module/core/enums/user_type.dart';
import 'package:PassPort/version2_module/core/extensions/show_snack_bar_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/models/partner_booking_model.dart';
import '../cubit/partner_bookings_cubit.dart';
import '../cubit/partner_bookings_state.dart';
import '../widgets/booking_card.dart';
import '../widgets/cancellation_reason_dialog.dart';
import '../widgets/date_filter_widget.dart';

class PartnerBookingsScreen extends StatefulWidget {
  final UserType? partnerType;

  const PartnerBookingsScreen({super.key, this.partnerType});

  @override
  State<PartnerBookingsScreen> createState() => _PartnerBookingsScreenState();
}

class _PartnerBookingsScreenState extends State<PartnerBookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PartnerBookingsCubit _bookingsCubit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _bookingsCubit = PartnerBookingsCubit();
    _loadBookings();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _bookingsCubit.close();
    super.dispose();
  }

  void _loadBookings() {
    _bookingsCubit.loadBookings(
      partnerType: widget.partnerType,
      refresh: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bookingsCubit,
      child: Scaffold(
        backgroundColor: appBackgroundColor,
        appBar: AppBar(
          backgroundColor: appBackgroundColor,
          elevation: 0,
          title: Text(
            'My Bookings',
            style: TextStyle(
              color: appTextColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: appTextColor),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            // IconButton(
            //   icon: Icon(Icons.filter_list, color: appTextColor),
            //   onPressed: _showDateFilter,
            // ),
            IconButton(
              icon: Icon(Icons.refresh, color: appTextColor),
              onPressed: _loadBookings,
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            labelColor: appTextColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: appTextColor,
            onTap: _onTabChanged,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelPadding: EdgeInsets.symmetric(horizontal: 16.w),
            labelStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Pending'),
              Tab(text: 'Upcoming'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: BlocBuilder<PartnerBookingsCubit, PartnerBookingsState>(
          builder: (context, state) {
            return TabBarView(
              controller: _tabController,
              children: [
                _buildBookingsList(null),
                _buildBookingsList(BookingStatus.pending),
                _buildBookingsList(BookingStatus.upcoming),
                _buildBookingsList(BookingStatus.completed),
                _buildBookingsList(BookingStatus.cancelled),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onTabChanged(int index) {
    BookingStatus? status;
    switch (index) {
      case 0:
        status = null; // All
        break;
      case 1:
        status = BookingStatus.pending;
        break;
      case 2:
        status = BookingStatus.upcoming;
        break;
      case 3:
        status = BookingStatus.completed;
        break;
      case 4:
        status = BookingStatus.cancelled;
        break;
    }
    _bookingsCubit.applyStatusFilter(status);
  }

  void _showDateFilter() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DateFilterWidget(
        startDate: _bookingsCubit.startDateFilter,
        endDate: _bookingsCubit.endDateFilter,
        onDateRangeChanged: (startDate, endDate) {
          _bookingsCubit.applyDateFilter(startDate, endDate);
        },
        onClearFilter: () {
          _bookingsCubit.clearFilters();
        },
      ),
    );
  }

  Widget _buildBookingsList(BookingStatus? status) {
    return BlocBuilder<PartnerBookingsCubit, PartnerBookingsState>(
      builder: (context, state) {
        if (state is PartnerBookingsLoading) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(appTextColor),
            ),
          );
        }

        if (state is PartnerBookingsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 80.sp,
                  color: Colors.red[400],
                ),
                SizedBox(height: 16.h),
                Text(
                  'Error loading bookings',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  state.message,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[500],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: _loadBookings,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appTextColor,
                  ),
                  child: Text(
                    'Retry',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is PartnerBookingsLoaded) {
          // Use the already filtered bookings from the cubit instead of filtering again
          final bookings = state.bookings;

          if (bookings.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 80.sp,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No ${status?.displayName.toLowerCase() ?? ''} bookings found',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Bookings will appear here when guests make reservations',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[500],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            color: appTextColor,
            onRefresh: () async => _loadBookings(),
            child: ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return BookingCard(
                  booking: booking,
                  onAccept: booking.bookingStatus == BookingStatus.pending
                      ? () => _acceptBooking(booking)
                      : null,
                  onReject: booking.bookingStatus == BookingStatus.pending
                      ? () => _rejectBooking(booking)
                      : null,
                  onViewDetails: () => _viewBookingDetails(booking),
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  List<PartnerBookingModel> _getFilteredBookings(
      List<PartnerBookingModel> allBookings, BookingStatus? status) {
    if (status == null) return allBookings;
    return allBookings
        .where((booking) => booking.bookingStatus == status)
        .toList();
  }

  void _handleBookingAction(
      BookingStatus newStatus, PartnerBookingModel booking) {
    if (newStatus == BookingStatus.upcoming) {
      _acceptBooking(booking);
    } else if (newStatus == BookingStatus.cancelled) {
      _rejectBooking(booking);
    }
  }

  void _acceptBooking(PartnerBookingModel booking) {
    _bookingsCubit.acceptBooking(booking.id);

    context.showCustomSnackBar(
      'Booking accepted successfully',
      type: SnackBarType.success,
    );
  }

  void _rejectBooking(PartnerBookingModel booking) {
    // Show cancellation reason dialog
    showDialog(
      context: context,
      builder: (context) => CancellationReasonDialog(
        booking: booking,
        onReasonSelected: (reason) {
          _bookingsCubit.cancelBooking(booking.id, reason.id);

          context.showCustomSnackBar(
            'Booking rejected - Reason: ${reason.title}',
            type: SnackBarType.error,
          );
        },
      ),
    );
  }

  void _viewBookingDetails(PartnerBookingModel booking) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildBookingDetailsModal(booking),
    );
  }

  Widget _buildBookingDetailsModal(PartnerBookingModel booking) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // Header with status
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Booking Details',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: appTextColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: booking.bookingStatus.backgroundColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    booking.statusDisplayText.toUpperCase(),
                    style: TextStyle(
                      color: booking.bookingStatus.statusColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Guest Info
            Row(
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: booking.profileImage != null
                      ? AssetImage(booking.profileImage!)
                      : null,
                  child: booking.profileImage == null
                      ? Icon(Icons.person, color: Colors.grey[600])
                      : null,
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.guestName,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: appTextColor,
                        ),
                      ),
                      Text(
                        booking.guestEmail,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      if (booking.guestPhone.isNotEmpty)
                        Text(
                          booking.guestPhone,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Booking details
                    _buildDetailRow('Service', booking.serviceName),
                    _buildDetailRow('Check-in', booking.formattedCheckIn),
                    _buildDetailRow('Check-out', booking.formattedCheckOut),
                    _buildDetailRow(
                        'Duration', '${booking.numberOfNights} nights'),
                    _buildDetailRow('Guests',
                        '${booking.guests} ${booking.guests > 1 ? 'guests' : 'guest'}'),
                    _buildDetailRow('Total Amount', booking.formattedAmount),
                    _buildDetailRow(
                        'Booking Date', booking.formattedBookingDate),
                    _buildDetailRow(
                        'Partner Type', booking.partnerType?.displayName ?? ''),

                    // Additional details if available
                    if (booking.additionalDetails != null) ...[
                      SizedBox(height: 16.h),
                      Text(
                        'Additional Details',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: appTextColor,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      ...booking.additionalDetails!.entries.map(
                        (entry) => _buildDetailRow(
                          entry.key,
                          entry.value?.toString() ?? '',
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Action buttons
            if (booking.bookingStatus == BookingStatus.pending) ...[
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _rejectBooking(booking);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: BorderSide(color: Colors.red),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                      ),
                      child: Text('Reject'),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _acceptBooking(booking);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appTextColor,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                      ),
                      child: Text(
                        'Accept',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                color: appTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
