// import 'package:flutter/material.dart';
// import 'package:PassPort/version2_module/features/partener/partner_feature_exports.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// /// Example implementations showing how to use the new Partner Bookings feature

// class ExamplePartnerBookingsUsage {
//   /// Example 1: Basic navigation to bookings screen
//   static void navigateToBookings(BuildContext context, UserType partnerType) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PartnerBookingsScreen(
//           partnerType: partnerType,
//         ),
//       ),
//     );
//   }

//   /// Example 2: Create a cubit and load bookings
//   static void loadBookingsExample() {
//     final cubit = PartnerBookingsCubit();

//     // Load all bookings for accommodation partner
//     cubit.loadBookings(
//       partnerType: UserType.accommodation,
//       refresh: true,
//     );

//     // Load only pending bookings
//     cubit.loadBookings(
//       partnerType: UserType.accommodation,
//       status: BookingStatus.pending,
//       refresh: true,
//     );

//     // Load bookings in date range for product partner
//     cubit.loadBookings(
//       partnerType: UserType.product,
//       startDate: DateTime(2024, 1, 1),
//       endDate: DateTime(2024, 12, 31),
//       refresh: true,
//     );
//   }

//   /// Example 3: Handle booking status updates
//   static void handleBookingActions() {
//     final cubit = PartnerBookingsCubit();

//     // Accept a booking
//     cubit.updateBookingStatus('booking_id_123', BookingStatus.upcoming);

//     // Reject a booking
//     cubit.updateBookingStatus('booking_id_123', BookingStatus.cancelled);

//     // Mark as completed
//     cubit.updateBookingStatus('booking_id_123', BookingStatus.completed);
//   }

//   /// Example 4: Filter bookings
//   static void filterBookingsExample() {
//     final cubit = PartnerBookingsCubit();

//     // Filter by status
//     cubit.applyStatusFilter(BookingStatus.pending);

//     // Filter by date range
//     cubit.applyDateFilter(
//       DateTime(2024, 1, 1),
//       DateTime(2024, 3, 31),
//     );

//     // Clear all filters
//     cubit.clearFilters();

//     // Get booking counts
//     final counts = cubit.getBookingsCountByAllStatuses();
//     print('Pending: ${counts[BookingStatus.pending]}');
//     print('Upcoming: ${counts[BookingStatus.upcoming]}');
//     print('Completed: ${counts[BookingStatus.completed]}');
//     print('Cancelled: ${counts[BookingStatus.cancelled]}');
//   }

//   /// Example 5: Create custom booking model
//   static PartnerBookingModel createSampleBooking() {
//     return PartnerBookingModel(
//       id: 'booking_001',
//       guestName: 'John Doe',
//       guestEmail: 'john.doe@example.com',
//       guestPhone: '+1234567890',
//       serviceName: 'Luxury Beach Resort',
//       serviceId: 'service_001',
//       checkIn: DateTime(2024, 6, 15),
//       checkOut: DateTime(2024, 6, 20),
//       guests: 2,
//       totalAmount: 750.0,
//       status: BookingStatus.pending,
//       profileImage: 'assets/images/profile/img.png',
//       bookingDate: DateTime.now(),
//       partnerType: UserType.accommodation,
//       additionalDetails: {
//         'room_type': 'Ocean View Suite',
//         'special_requests': 'Late checkout requested',
//         'payment_method': 'Credit Card',
//       },
//     );
//   }

//   /// Example 6: Widget integration
//   static Widget buildCustomBookingsList(List<PartnerBookingModel> bookings) {
//     return ListView.builder(
//       itemCount: bookings.length,
//       itemBuilder: (context, index) {
//         final booking = bookings[index];
//         return BookingCard(
//           booking: booking,
//           onAccept: booking.status == BookingStatus.pending
//               ? () => _handleAccept(booking)
//               : null,
//           onReject: booking.status == BookingStatus.pending
//               ? () => _handleReject(booking)
//               : null,
//           onViewDetails: () => _showDetails(context, booking),
//         );
//       },
//     );
//   }

//   static void _handleAccept(PartnerBookingModel booking) {
//     // Handle booking acceptance
//     print('Accepting booking: ${booking.id}');
//   }

//   static void _handleReject(PartnerBookingModel booking) {
//     // Handle booking rejection
//     print('Rejecting booking: ${booking.id}');
//   }

//   static void _showDetails(BuildContext context, PartnerBookingModel booking) {
//     // Show booking details
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Booking Details'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Guest: ${booking.guestName}'),
//             Text('Service: ${booking.serviceName}'),
//             Text('Check-in: ${booking.formattedCheckIn}'),
//             Text('Check-out: ${booking.formattedCheckOut}'),
//             Text('Guests: ${booking.guests}'),
//             Text('Amount: ${booking.formattedAmount}'),
//             Text('Status: ${booking.status.displayName}'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// Example widget showing complete integration
// class ExamplePartnerBookingsWidget extends StatefulWidget {
//   final UserType partnerType;

//   const ExamplePartnerBookingsWidget({
//     Key? key,
//     required this.partnerType,
//   }) : super(key: key);

//   @override
//   _ExamplePartnerBookingsWidgetState createState() =>
//       _ExamplePartnerBookingsWidgetState();
// }

// class _ExamplePartnerBookingsWidgetState
//     extends State<ExamplePartnerBookingsWidget> {
//   late PartnerBookingsCubit _cubit;

//   @override
//   void initState() {
//     super.initState();
//     _cubit = PartnerBookingsCubit();
//     _loadBookings();
//   }

//   @override
//   void dispose() {
//     _cubit.close();
//     super.dispose();
//   }

//   void _loadBookings() {
//     _cubit.loadBookings(
//       partnerType: widget.partnerType,
//       refresh: true,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${widget.partnerType.displayName} Bookings'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.filter_list),
//             onPressed: _showFilters,
//           ),
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: _loadBookings,
//           ),
//         ],
//       ),
//       body: BlocBuilder<PartnerBookingsCubit, PartnerBookingsState>(
//         bloc: _cubit,
//         builder: (context, state) {
//           if (state is PartnerBookingsLoading) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (state is PartnerBookingsError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Error: ${state.message}'),
//                   ElevatedButton(
//                     onPressed: _loadBookings,
//                     child: Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           if (state is PartnerBookingsLoaded) {
//             if (state.bookings.isEmpty) {
//               return Center(
//                 child: Text('No bookings found'),
//               );
//             }

//             return RefreshIndicator(
//               onRefresh: () async => _loadBookings(),
//               child: ListView.builder(
//                 itemCount: state.bookings.length,
//                 itemBuilder: (context, index) {
//                   final booking = state.bookings[index];
//                   return BookingCard(
//                     booking: booking,
//                     onAccept: booking.status == BookingStatus.pending
//                         ? () => _acceptBooking(booking.id)
//                         : null,
//                     onReject: booking.status == BookingStatus.pending
//                         ? () => _rejectBooking(booking.id)
//                         : null,
//                     onViewDetails: () => _showBookingDetails(booking),
//                   );
//                 },
//               ),
//             );
//           }

//           return SizedBox.shrink();
//         },
//       ),
//     );
//   }

//   void _showFilters() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => DateFilterWidget(
//         startDate: _cubit.startDateFilter,
//         endDate: _cubit.endDateFilter,
//         onDateRangeChanged: (startDate, endDate) {
//           _cubit.applyDateFilter(startDate, endDate);
//         },
//         onClearFilter: () {
//           _cubit.clearFilters();
//         },
//       ),
//     );
//   }

//   void _acceptBooking(String bookingId) {
//     _cubit.updateBookingStatus(bookingId, BookingStatus.upcoming);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Booking accepted')),
//     );
//   }

//   void _rejectBooking(String bookingId) {
//     _cubit.updateBookingStatus(bookingId, BookingStatus.cancelled);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Booking rejected')),
//     );
//   }

//   void _showBookingDetails(PartnerBookingModel booking) {
//     // Show detailed booking information
//     ExamplePartnerBookingsUsage._showDetails(context, booking);
//   }
// }
