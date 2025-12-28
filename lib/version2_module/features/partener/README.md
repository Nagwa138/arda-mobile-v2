# Partner Feature Module

This module provides a comprehensive partner registration and service management system for different types of partners in the ARDA mobile application.

## Features

### 1. User Type Management

- **UserType Enum**: Defines different user types (Traveller, Partner, Admin, Accommodation, Activity, Trip, Product)
- **Dynamic User Switching**: Allows users to switch between traveller and partner modes

### 2. Partner Registration Flow

1. **Initial Partner Registration**: Uses existing `PartnerRegisterScreen` with BLoC state management
2. **Approval Process**: Admin approval for partner status (pending screen shows status)
3. **Service-Specific Registration**: After approval, partners can register specific services using dynamic forms

### 3. Dynamic Service Forms

Each partner type has a customized form based on API requirements:

#### Accommodation Partners

- Service Name, Address, City, Government
- Accommodation Type, Service Details
- Contact Information (Phone, Website)
- Photo Upload (Cover + Additional Photos)

#### Activity Partners

- Activity Name, Provider Name, Description
- Duration, Price Per Person, Location
- Work Times, What's Included
- Rules & Cancellation Policy
- Photo Upload

#### Trip Partners

- Trip Name, Provider Name, Description
- Duration, Price Per Person
- Meet Point, End Point
- What's Included, Rules & Cancellation Policy
- Photo Upload

#### Product Partners

- Product Name, Description, Price
- Category ID, Delivery Availability
- Shipping Cost, Location
- Rules & Cancellation Policy

## Usage Examples

### 1. User Type Switcher

```dart
import 'package:your_app/version2_module/features/partener/partner_feature_exports.dart';

// Navigate to user type switcher
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => UserTypeSwitcher(
      currentUserType: UserType.traveller,
      isPartnerApproved: true,
      approvedPartnerTypes: [UserType.accommodation, UserType.activity],
    ),
  ),
);
```

### 2. Enhanced Partner Flow

```dart
// Use the enhanced flow that integrates with existing registration
navigateToPartnerFlow(
  context,
  isExistingPartner: false, // New partner - uses existing PartnerRegisterScreen
  isPartnerApproved: false,
);

// For existing approved partners
navigateToPartnerFlow(
  context,
  isExistingPartner: true,
  isPartnerApproved: true,
  approvedPartnerTypes: [UserType.accommodation, UserType.activity],
);

// Direct to specific service registration
navigateToPartnerFlow(
  context,
  isExistingPartner: true,
  isPartnerApproved: true,
  initialServiceType: UserType.accommodation,
);
```

### 3. Service Registration

```dart
// For approved partners to register specific services
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => PartnerServiceRegistration(
      initialPartnerType: UserType.accommodation,
    ),
  ),
);
```

### 4. Direct Partner Type Selection

```dart
// For choosing which type of service to register
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => PartnerTypeSelector(
      onPartnerTypeSelected: (partnerType) {
        // Handle partner type selection
        print('Selected: ${partnerType.displayName}');
      },
    ),
  ),
);
```

### 5. Custom Dynamic Form

```dart
// Use the dynamic form directly with specific partner type
DynamicServiceForm(
  partnerType: 'accommodation',
  onFormSubmit: (formData) {
    // Handle form submission
    print('Form data: $formData');
  },
  initialData: {
    'serviceName': 'My Hotel',
    'city': 'Cairo',
  },
)
```

## API Integration

The forms are designed to match the following API endpoints:

- **Accommodation**: `POST /api/Accomodation`
- **Activity**: `POST /api/Companies/AddPartnerActivity`
- **Product**: `POST /api/Companies/AddPartnerProduct`
- **Trip**: Custom endpoint (to be implemented)

## Form Field Types

The dynamic forms support various field types:

- `text`: Single line text input
- `textarea`: Multi-line text input
- `number`: Numeric input
- `currency`: Price/money input with currency symbol
- `dropdown`: Selection from predefined options
- `checkbox`: Boolean/toggle input
- `imageUpload`: Image selection and upload
- `timePicker`: Time selection

## State Management

The module includes:

- Form validation and error handling
- Image upload management
- Loading states
- Success/error dialogs
- Data persistence between navigation

## Customization

### Adding New Partner Types

1. Add the new type to `UserType` enum
2. Create form configuration in `ServiceFormConfig`
3. Update the factory method in `ServiceFormConfig.forPartnerType()`
4. Add appropriate icons and colors in UI components

### Custom Form Fields

1. Add new field type to `ServiceFieldType` enum
2. Implement rendering logic in `CustomFormField`
3. Add validation logic as needed

## File Structure

```
lib/version2_module/features/partener/
├── core/
│   └── enums/
│       └── user_type.dart
├── domain/
│   └── entities/
│       ├── partner_register_entity.dart
│       └── service_form_field.dart
├── presentation/
│   ├── screens/
│   │   ├── partner_registration.dart
│   │   ├── partner_service_registration.dart
│   │   └── user_type_switcher.dart
│   └── widgets/
│       ├── dynamic_service_form.dart
│       ├── partner_type_selector.dart
│       ├── custom_form_field.dart
│       └── image_upload_widget.dart
└── partner_feature_exports.dart
```
