# Partner Integration Guide

This guide shows how to integrate the new dynamic service forms with your existing partner registration system.

## Overview

The new system **enhances** your existing registration flow instead of replacing it:

- ✅ **Keeps** your existing `PartnerRegisterScreen` with BLoC state management
- ✅ **Adds** dynamic service-specific forms after partner approval
- ✅ **Integrates** user type switching for partners and travelers
- ✅ **Provides** a unified flow through `EnhancedPartnerFlow`

## Quick Start

### 1. For New Partners (Not Registered Yet)

```dart
import 'package:PassPort/version2_module/features/partener/partner_feature_exports.dart';

// Navigate to partner registration (uses your existing PartnerRegisterScreen)
navigateToPartnerFlow(
  context,
  isExistingPartner: false,
  isPartnerApproved: false,
);
```

### 2. For Existing Partners (Approved)

```dart
// Show user type switcher for approved partners
navigateToPartnerFlow(
  context,
  isExistingPartner: true,
  isPartnerApproved: true,
  approvedPartnerTypes: [
    UserType.accommodation,
    UserType.activity
  ],
);
```

### 3. For Direct Service Registration

```dart
// Skip type selection, go directly to accommodation service form
navigateToPartnerFlow(
  context,
  isExistingPartner: true,
  isPartnerApproved: true,
  initialServiceType: UserType.accommodation,
);
```

### 4. For Pending Partners

```dart
// Show pending approval screen
navigateToPartnerFlow(
  context,
  isExistingPartner: true,
  isPartnerApproved: false,
);
```

## Integration with Existing Code

### In your existing partner flow:

```dart
// Replace this:
Navigator.push(context, MaterialPageRoute(
  builder: (context) => PartnerRegisterScreen(),
));

// With this:
navigateToPartnerFlow(context);
```

### In your main navigation:

```dart
// Add to your navigation logic
switch (userType) {
  case UserType.traveller:
    // Show traveler screens
    break;
  case UserType.partner:
    navigateToPartnerFlow(
      context,
      isExistingPartner: true,
      isPartnerApproved: checkPartnerApprovalStatus(),
      approvedPartnerTypes: getApprovedPartnerTypes(),
    );
    break;
}
```

## API Integration Points

The dynamic forms generate data that matches your API endpoints:

### Accommodation API

- **Endpoint**: `POST /api/Accomodation`
- **Generated Fields**: serviceName, address, city, government, etc.

### Activity API

- **Endpoint**: `POST /api/Companies/AddPartnerActivity`
- **Generated Fields**: name, description, durationInHours, etc.

### Product API

- **Endpoint**: `POST /api/Companies/AddPartnerProduct`
- **Generated Fields**: name, description, price, categoryId, etc.

## State Management Integration

The new system works alongside your existing BLoC:

```dart
// Your existing cubit for partner registration
context.read<PartnerRegisterCubit>().registerPartner(...);

// New service registration (you can add this to your existing cubit)
_submitServiceForm(formData) {
  switch (serviceType) {
    case UserType.accommodation:
      await apiService.postAccommodation(formData);
      break;
    case UserType.activity:
      await apiService.postActivity(formData);
      break;
    // ... etc
  }
}
```

## UserType Integration

Add the UserType enum to your user model:

```dart
class User {
  final UserType userType;
  final bool isPartnerApproved;
  final List<UserType> approvedPartnerTypes;

  // ... existing fields
}
```

## Benefits

✅ **No Breaking Changes**: Your existing registration system stays intact  
✅ **Enhanced UX**: Beautiful, consistent forms for each service type  
✅ **Type Safety**: Strong typing with UserType enum  
✅ **API Ready**: Forms match your exact API requirements  
✅ **Scalable**: Easy to add new partner types  
✅ **Maintainable**: Clean separation of concerns

## Migration Path

1. **Phase 1**: Use `navigateToPartnerFlow()` in new features
2. **Phase 2**: Gradually replace direct navigation calls
3. **Phase 3**: Add service-specific dashboard integration
4. **Phase 4**: Enhance with real-time approval status

No immediate code changes required - the new system works alongside your existing implementation! 🚀
