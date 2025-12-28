# Partner Section v2

This is the new partner section UI built using clean architecture principles and modern Flutter UI patterns.

## Features

### Dashboard

- Modern statistics cards showing key metrics (earnings, bookings, etc.)
- Responsive sidebar navigation menu
- Real-time data updates using BLoC pattern
- Professional design matching the provided mockups

### Services Management

- List view of all partner services/accommodations
- Search and filter functionality
- Service status indicators (Active, Pending, Rejected)
- Edit and delete capabilities
- Service card components with ratings and pricing

### Bookings Management

- Tabbed interface for different booking statuses
- Accept/reject pending bookings
- Detailed booking information modal
- Guest management features
- Status tracking and updates

## Architecture

```
presentation/
├── screens/
│   ├── partner_dashboard_screen.dart     # Main dashboard with statistics
│   ├── partner_services_screen.dart      # Services management
│   └── partner_bookings_screen.dart      # Bookings management
├── widgets/
│   ├── statistics_card.dart              # Dashboard metric cards
│   ├── menu_drawer.dart                  # Navigation sidebar
│   ├── menu_item.dart                    # Individual menu items
│   ├── service_card.dart                 # Service listing cards
│   └── booking_card.dart                 # Booking entry cards
├── cubit/
│   ├── partner_dashboard_cubit.dart      # State management
│   └── partner_dashboard_state.dart      # State definitions
└── partner_exports.dart                  # Export file
```

## Usage

Import the main dashboard screen:

```dart
import 'package:PassPort/version2_module/features/partener/presentation/screens/partner_dashboard_screen.dart';

// Navigate to dashboard
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const PartnerDashboardScreen(),
  ),
);
```

Or use the exports file for multiple imports:

```dart
import 'package:PassPort/version2_module/features/partener/presentation/partner_exports.dart';
```

## Design Features

- **Modern UI**: Clean, card-based design with proper shadows and rounded corners
- **Responsive Layout**: Adapts to different screen sizes using flutter_screenutil
- **Consistent Theming**: Uses app color constants for brand consistency
- **Smooth Interactions**: Proper tap feedback and navigation transitions
- **Loading States**: Shows loading indicators during data fetching
- **Error Handling**: Graceful error states and user feedback

## Dependencies

- flutter_bloc: State management
- flutter_screenutil: Responsive sizing
- easy_localization: Internationalization
- Standard Flutter Material Design components

## Integration

This new partner section can be integrated into the existing app by:

1. Adding routes to the main router
2. Updating navigation from existing partner screens
3. Connecting to real API endpoints in the cubit
4. Adding proper authentication checks
