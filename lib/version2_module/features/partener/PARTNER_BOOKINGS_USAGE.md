# Partner Bookings Feature Usage Guide

This guide explains how to use the new Partner Bookings feature with filtering, status management, and API integration.

## Overview

The Partner Bookings feature provides:

- **Status-based filtering** (Pending, Upcoming, Completed, Cancelled)
- **Date range filtering**
- **Partner type-specific endpoints** (Accommodation, Activity, Trip)
- **Real-time booking management** with accept/reject actions
- **Responsive UI** with detailed booking views

## BookingStatus Enum

```dart
enum BookingStatus {
  pending(0, 'Pending'),      // Orange - awaiting confirmation
  upcoming(1, 'Upcoming'),    // Blue - confirmed, future bookings
  completed(2, 'Completed'),  // Green - past completed bookings
  cancelled(3, 'Cancelled');  // Red - cancelled/rejected bookings
}
```

## API Integration

The feature automatically selects the appropriate endpoint based on partner type:

- **Accommodation**: `/api/Booking/GetMyRequests`
- **Product**: `/api/Booking/GetMyOrderRequests`
- **Activity**: `/api/Booking/GetMyActivityRequests`
- **Trip**: `/api/Booking/GetMyTripRequests`
- **Default**: `/api/Booking/GetMyRequests`

### Query Parameters

All endpoints support these filters:

- `status`: 0-3 (BookingStatus enum values)
- `startDate`: ISO string date
- `endDate`: ISO string date
- `skip`: pagination offset (default 0)
- `take`: page size (default 10)

## Usage Examples

### Basic Screen Integration

```dart
import 'package:PassPort/version2_module/features/partener/partner_feature_exports.dart';

// Navigate to bookings for accommodation partner
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => PartnerBookingsScreen(
      partnerType: UserType.accommodation,
    ),
  ),
);

// Navigate to bookings for product partner
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => PartnerBookingsScreen(
      partnerType: UserType.product,
    ),
  ),
);

// Navigate to bookings for activity partner
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => PartnerBookingsScreen(
      partnerType: UserType.activity,
    ),
  ),
);
```

### Using the Cubit Directly

```dart
class MyCustomBookingsWidget extends StatefulWidget {
  @override
  _MyCustomBookingsWidgetState createState() => _MyCustomBookingsWidgetState();
}

class _MyCustomBookingsWidgetState extends State<MyCustomBookingsWidget> {
  late PartnerBookingsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = PartnerBookingsCubit();

    // Load all bookings for accommodation partner
    _cubit.loadBookings(
      partnerType: UserType.accommodation,
      refresh: true,
    );
  }

  void _loadPendingBookings() {
    _cubit.loadBookings(
      partnerType: UserType.accommodation,
      status: BookingStatus.pending,
      refresh: true,
    );
  }

  void _loadBookingsInDateRange() {
    _cubit.loadBookings(
      partnerType: UserType.activity,
      startDate: DateTime(2024, 1, 1),
      endDate: DateTime(2024, 12, 31),
      refresh: true,
    );
  }

  void _acceptBooking(String bookingId) {
    _cubit.updateBookingStatus(bookingId, BookingStatus.upcoming);
  }

  void _rejectBooking(String bookingId) {
    _cubit.updateBookingStatus(bookingId, BookingStatus.cancelled);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartnerBookingsCubit, PartnerBookingsState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state is PartnerBookingsLoaded) {
          return ListView.builder(
            itemCount: state.bookings.length,
            itemBuilder: (context, index) {
              final booking = state.bookings[index];
              return BookingCard(
                booking: booking,
                onAccept: booking.status == BookingStatus.pending
                    ? () => _acceptBooking(booking.id)
                    : null,
                onReject: booking.status == BookingStatus.pending
                    ? () => _rejectBooking(booking.id)
                    : null,
                onViewDetails: () => _showBookingDetails(booking),
              );
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
```

### Date Filtering Widget Usage

```dart
void _showDateFilter() {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DateFilterWidget(
      startDate: DateTime(2024, 1, 1),
      endDate: DateTime(2024, 12, 31),
      onDateRangeChanged: (startDate, endDate) {
        // Apply date filter
        cubit.applyDateFilter(startDate, endDate);
      },
      onClearFilter: () {
        // Clear all filters
        cubit.clearFilters();
      },
    ),
  );
}
```

### Filtering Operations

```dart
// Filter by status only
cubit.applyStatusFilter(BookingStatus.pending);

// Filter by date range only
cubit.applyDateFilter(
  DateTime(2024, 1, 1),
  DateTime(2024, 3, 31)
);

// Clear all filters
cubit.clearFilters();

// Get bookings count by status
final counts = cubit.getBookingsCountByAllStatuses();
print('Pending: ${counts[BookingStatus.pending]}');
print('Upcoming: ${counts[BookingStatus.upcoming]}');
```

## Custom Booking Cards

```dart
// Create custom booking card
BookingCard(
  booking: myBooking,
  onAccept: () {
    // Custom accept logic
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Booking'),
        content: Text('Accept booking from ${myBooking.guestName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              cubit.updateBookingStatus(myBooking.id, BookingStatus.upcoming);
            },
            child: Text('Accept'),
          ),
        ],
      ),
    );
  },
  onReject: () {
    // Custom reject logic
    cubit.updateBookingStatus(myBooking.id, BookingStatus.cancelled);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Booking rejected')),
    );
  },
  onViewDetails: () => _showCustomBookingDetails(myBooking),
);
```

## Partner Type Detection

```dart
// Get current partner type and load appropriate bookings
UserType getCurrentPartnerType() {
  // Your logic to determine partner type
  return UserType.accommodation;
}

void loadBookingsForCurrentPartner() {
  final partnerType = getCurrentPartnerType();
  cubit.loadBookings(partnerType: partnerType, refresh: true);
}
```

## Error Handling

```dart
BlocListener<PartnerBookingsCubit, PartnerBookingsState>(
  listener: (context, state) {
    if (state is PartnerBookingsError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: 'Retry',
            textColor: Colors.white,
            onPressed: () => cubit.loadBookings(refresh: true),
          ),
        ),
      );
    }
  },
  child: YourBookingsWidget(),
);
```

## Features

### Status Colors & UI

- Each booking status has distinctive colors for easy recognition
- Status badges with colored backgrounds and text
- Consistent theming across all booking components

### Pagination Support

- Built-in pagination with `skip` and `take` parameters
- Load more functionality for large datasets
- Refresh indicator for pull-to-refresh

### Real-time Updates

- Optimistic UI updates when changing booking status
- Automatic list refresh after status changes
- Loading states during API calls

### Partner Type Flexibility

- Supports all partner types (Accommodation, Product, Activity, Trip)
- Automatic endpoint selection based on partner type
- Type-safe partner type handling with enums

This implementation provides a complete, production-ready booking management system for partners with comprehensive filtering, real-time updates, and excellent user experience.
