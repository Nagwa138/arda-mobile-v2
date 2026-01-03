import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/version2_module/core/enums/booking_status.dart';
import 'package:PassPort/version2_module/core/enums/user_type.dart';
import '../widgets/booking_card.dart';
import '../widgets/date_filter_widget.dart';
import '../widgets/cancellation_reason_dialog.dart';
import '../cubit/partner_bookings_cubit.dart';
import '../cubit/partner_bookings_state.dart';
import '../../domain/models/partner_booking_model.dart';

/// Enhanced Partner Bookings Screen with status-based tap handling
class EnhancedPartnerBookingsScreen extends StatefulWidget {
  final UserType? partnerType;

  const EnhancedPartnerBookingsScreen({super.key, this.partnerType});

  @override
  State<EnhancedPartnerBookingsScreen> createState() =>
      _EnhancedPartnerBookingsScreenState();
}

class _EnhancedPartnerBookingsScreenState
    extends State<EnhancedPartnerBookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PartnerBookingsCubit _bookingsCubit;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 5, vsync: this); // Added "Cancelled" tab
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
            IconButton(
              icon: Icon(Icons.filter_list, color: appTextColor),
              onPressed: _showDateFilter,
            ),
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
            tabs: [
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
        floatingActionButton: _buildFloatingActionButton(),
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
          return _buildErrorState(state.message);
        }

        if (state is PartnerBookingsLoaded) {
          // Use the already filtered bookings from the cubit instead of filtering again
          final bookings = state.bookings;

          if (bookings.isEmpty) {
            return _buildEmptyState(status);
          }

          return RefreshIndicator(
            color: appTextColor,
            onRefresh: () async => _loadBookings(),
            child: ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return _buildEnhancedBookingCard(booking);
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildEnhancedBookingCard(PartnerBookingModel booking) {
    return BookingCard(
      booking: booking,
      onAccept: () => _handleStatusAction(booking, BookingStatus.upcoming),
      onReject: () => _handleStatusAction(booking, BookingStatus.cancelled),
      onViewDetails: () => _viewBookingDetails(booking),
    );
  }

  /// Handle status-based actions based on current booking status
  void _handleStatusAction(
      PartnerBookingModel booking, BookingStatus newStatus) {
    switch (booking.bookingStatus) {
      case BookingStatus.pending:
        if (newStatus == BookingStatus.upcoming) {
          _acceptBooking(booking);
        } else if (newStatus == BookingStatus.cancelled) {
          _rejectBooking(booking);
        }
        break;
      case BookingStatus.upcoming:
        if (newStatus == BookingStatus.completed) {
          _completeBooking(booking);
        }
        break;
      case BookingStatus.completed:
        _viewBookingDetails(booking);
        break;
      case BookingStatus.cancelled:
        _viewBookingDetails(booking);
        break;
    }
  }

  void _acceptBooking(PartnerBookingModel booking) {
    _bookingsCubit.acceptBooking(booking.id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8.w),
            Text('Booking accepted successfully'),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'View',
          textColor: Colors.white,
          onPressed: () => _viewBookingDetails(booking),
        ),
      ),
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

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.cancel, color: Colors.white),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Booking rejected'),
                        Text(
                          'Reason: ${reason.title}',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 4),
            ),
          );
        },
      ),
    );
  }

  void _completeBooking(PartnerBookingModel booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Mark as Completed'),
        content: Text(
            'Mark this booking as completed? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _bookingsCubit.updateBookingStatus(
                  booking.id, BookingStatus.completed);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 8.w),
                      Text('Booking marked as completed'),
                    ],
                  ),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text('Complete', style: TextStyle(color: Colors.white)),
          ),
        ],
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
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
                  child: Text(
                    booking.genderIcon,
                    style: TextStyle(fontSize: 24.sp),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.name,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: appTextColor,
                        ),
                      ),
                      Text(
                        booking.email,
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
                    _buildDetailRow('Service', booking.serviceName),
                    _buildDetailRow('Booking Date', booking.formattedDateTime),
                    _buildDetailRow('Guests',
                        '${booking.numOfPersons ?? 1} ${(booking.numOfPersons ?? 1) > 1 ? 'guests' : 'guest'}'),
                    _buildDetailRow('Total Amount', booking.formattedAmount),
                    _buildDetailRow(
                        'Partner Type', booking.partnerType?.displayName ?? ''),
                    _buildDetailRow(
                        'Gender', '${booking.gender} ${booking.genderIcon}'),
                    _buildDetailRow('Booking ID', booking.bookingId),
                  ],
                ),
              ),
            ),

            // Status-based action buttons in modal
            _buildModalActions(booking),
          ],
        ),
      ),
    );
  }

  Widget _buildModalActions(PartnerBookingModel booking) {
    switch (booking.bookingStatus) {
      case BookingStatus.pending:
        return Column(
          children: [
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
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                    ),
                    child:
                        Text('Accept', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        );
      case BookingStatus.upcoming:
        return Column(
          children: [
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _completeBooking(booking);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
                child: Text('Mark as Completed',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        );
      default:
        return SizedBox.shrink();
    }
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

  List<PartnerBookingModel> _getFilteredBookings(
      List<PartnerBookingModel> allBookings, BookingStatus? status) {
    if (status == null) return allBookings;
    return allBookings
        .where((booking) => booking.bookingStatus == status)
        .toList();
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80.sp, color: Colors.red[400]),
          SizedBox(height: 16.h),
          Text('Error loading bookings',
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500)),
          SizedBox(height: 8.h),
          Text(message,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[500]),
              textAlign: TextAlign.center),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: _loadBookings,
            style: ElevatedButton.styleFrom(backgroundColor: appTextColor),
            child: Text('Retry', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BookingStatus? status) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_month_outlined,
              size: 80.sp, color: Colors.grey[400]),
          SizedBox(height: 16.h),
          Text(
            'No ${status?.displayName.toLowerCase() ?? ''} bookings found',
            style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8.h),
          Text(
            'Bookings will appear here when guests make reservations',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget? _buildFloatingActionButton() {
    return BlocBuilder<PartnerBookingsCubit, PartnerBookingsState>(
      builder: (context, state) {
        if (state is PartnerBookingsLoaded) {
          final pendingCount = state.bookings
              .where((b) => b.bookingStatus == BookingStatus.pending)
              .length;

          if (pendingCount > 0) {
            return FloatingActionButton.extended(
              onPressed: () {
                _tabController.animateTo(1); // Navigate to Pending tab
                _bookingsCubit.applyStatusFilter(BookingStatus.pending);
              },
              backgroundColor: BookingStatus.pending.statusColor,
              icon: Icon(Icons.pending_actions, color: Colors.white),
              label: Text(
                '$pendingCount Pending',
                style: TextStyle(
                    color: const Color.fromARGB(255, 57, 33, 33),
                    fontWeight: FontWeight.bold),
              ),
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
