enum ServiceFieldType {
  text,
  textarea,
  number,
  currency,
  duration,
  location,
  checkbox,
  dropdown,
  categoryDropdown,
  imageUpload,
  timePicker,
  roomSection,
  amenitiesSection,
  featuresSection,
  phone, // إضافة نوع جديد للهاتف
  url, // إضافة نوع جديد للروابط
}

class ServiceFormField {
  final String key;
  final String label;
  final ServiceFieldType type;
  final bool isRequired;
  final String? placeholder;
  final List<String>? options; // For dropdown
  final String? validationMessage;
  final int? maxLength;
  final bool isOptional;
  final double? minValue; // للأرقام - أقل قيمة
  final double? maxValue; // للأرقام - أكبر قيمة

  const ServiceFormField({
    required this.key,
    required this.label,
    required this.type,
    this.isRequired = true,
    this.placeholder,
    this.options,
    this.validationMessage,
    this.maxLength,
    this.isOptional = false,
    this.minValue,
    this.maxValue,
  });
}

class ServiceFormConfig {
  final List<ServiceFormField> fields;

  const ServiceFormConfig({
    required this.fields,
  });

  // Factory method to get configuration based on partner type
  static ServiceFormConfig forPartnerType(String partnerType) {
    switch (partnerType.toLowerCase()) {
      case 'accommodation':
      case 'إقامة':
        return _accommodationConfig;
      case 'activity':
      case 'نشاط':
        return _activityConfig;
      case 'trip':
      case 'رحلة':
        return _tripConfig;
      case 'product':
      case 'منتج':
        return _productConfig;
      default:
        return _accommodationConfig;
    }
  }

  static final ServiceFormConfig _accommodationConfig = ServiceFormConfig(
    fields: [
      ServiceFormField(
        key: 'serviceName',
        label: 'Service Name',
        placeholder: 'Enter service name',
        type: ServiceFieldType.text,
        isRequired: true,
        validationMessage: 'Please enter service name',
      ),
      ServiceFormField(
        key: 'address',
        label: 'Address',
        placeholder: 'Enter address',
        type: ServiceFieldType.text,
        isRequired: true,
        validationMessage: 'Please enter address',
      ),
      ServiceFormField(
        key: 'city',
        label: 'City',
        placeholder: 'Enter city',
        type: ServiceFieldType.text,
        isRequired: true,
        validationMessage: 'Please enter city',
      ),
      ServiceFormField(
        key: 'government',
        label: 'Government',
        placeholder: 'Enter government',
        type: ServiceFieldType.text,
        isRequired: true,
        validationMessage: 'Please enter government',
      ),
      ServiceFormField(
        key: 'addressLink',
        label: 'Address Link',
        placeholder: 'Enter address link (optional)',
        type: ServiceFieldType.url,
        isRequired: false,
      ),
      ServiceFormField(
        key: 'website',
        label: 'Website',
        placeholder: 'Enter website (optional)',
        type: ServiceFieldType.url,
        isRequired: false,
      ),
      ServiceFormField(
        key: 'officialPhone',
        label: 'Official Phone',
        placeholder: 'Enter official phone',
        type: ServiceFieldType.phone,
        isRequired: true,
        validationMessage: 'Please enter valid phone number',
      ),
      ServiceFormField(
        key: 'language',
        label: 'Language',
        placeholder: 'Select language',
        type: ServiceFieldType.dropdown,
        options: ['Arabic', 'English', 'French'],
        isRequired: true,
        validationMessage: 'Please select language',
      ),
      ServiceFormField(
        key: 'accomodationTypeId',
        label: 'Accommodation Type',
        placeholder: 'Select accommodation type',
        type: ServiceFieldType.dropdown,
        options: [
          'Hotel',
          'Resort',
          'Apartment',
          'Villa',
          'Hostel',
          'Guesthouse'
        ],
        isRequired: true,
        validationMessage: 'Please select accommodation type',
      ),
      ServiceFormField(
        key: 'serviceDesc',
        label: 'Service Description',
        placeholder: 'Enter service description',
        type: ServiceFieldType.textarea,
        isRequired: true,
        validationMessage: 'Please enter service description',
      ),
      ServiceFormField(
        key: 'serviceImages',
        label: 'Service Images',
        placeholder: 'Upload service images',
        type: ServiceFieldType.imageUpload,
        isRequired: true,
        validationMessage: 'Please upload at least one image',
      ),
      ServiceFormField(
        key: 'roomsSection',
        label: 'Rooms',
        placeholder: 'Configure rooms',
        type: ServiceFieldType.roomSection,
        isRequired: true,
        validationMessage: 'Please add at least one room',
      ),
      ServiceFormField(
        key: 'amenitiesSection',
        label: 'Amenities',
        placeholder: 'Select amenities',
        type: ServiceFieldType.amenitiesSection,
        isRequired: false,
      ),
      ServiceFormField(
        key: 'featuresSection',
        label: 'Features',
        placeholder: 'Select features',
        type: ServiceFieldType.featuresSection,
        isRequired: false,
      ),
    ],
  );

  static final ServiceFormConfig _activityConfig = ServiceFormConfig(
    fields: [
      ServiceFormField(
        key: 'name',
        label: 'Activity Name',
        placeholder: 'Enter activity name',
        type: ServiceFieldType.text,
        isRequired: true,
        validationMessage: 'Please enter activity name',
      ),
      ServiceFormField(
        key: 'description',
        label: 'Description',
        placeholder: 'Enter activity description',
        type: ServiceFieldType.textarea,
        isRequired: true,
        validationMessage: 'Please enter description',
      ),
      ServiceFormField(
        key: 'durationInHours',
        label: 'Duration (Hours)',
        placeholder: 'Enter duration in hours',
        type: ServiceFieldType.number,
        isRequired: true,
        validationMessage: 'Please enter valid duration',
        minValue: 0.5,
        maxValue: 24,
      ),
      ServiceFormField(
        key: 'pricePerPerson',
        label: 'Price Per Person',
        placeholder: 'Enter price per person',
        type: ServiceFieldType.number,
        isRequired: true,
        validationMessage: 'Please enter valid price',
        minValue: 0,
      ),
      ServiceFormField(
        key: 'image',
        label: 'Activity Image',
        placeholder: 'Upload activity image',
        type: ServiceFieldType.imageUpload,
        isRequired: true,
        validationMessage: 'Please upload activity image',
      ),
      ServiceFormField(
        key: 'activityLocation',
        label: 'Activity Location',
        placeholder: 'Enter activity location',
        type: ServiceFieldType.text,
        isRequired: true,
        validationMessage: 'Please enter location',
      ),
      ServiceFormField(
        key: 'providerName',
        label: 'Provider Name',
        placeholder: 'Enter provider name',
        type: ServiceFieldType.text,
        isRequired: true,
        validationMessage: 'Please enter provider name',
      ),
      ServiceFormField(
        key: 'workTimes',
        label: 'Work Times',
        placeholder: 'Enter work times',
        type: ServiceFieldType.text,
        isRequired: true,
        validationMessage: 'Please enter work times',
      ),
      ServiceFormField(
        key: 'whatsIncluded',
        label: 'What\'s Included',
        placeholder: 'Enter what\'s included',
        type: ServiceFieldType.textarea,
        isRequired: true,
        validationMessage: 'Please enter what\'s included',
      ),
      ServiceFormField(
        key: 'rulesAndCancellationPolicy',
        label: 'Rules & Cancellation Policy',
        placeholder: 'Enter rules and cancellation policy',
        type: ServiceFieldType.textarea,
        isRequired: true,
        validationMessage: 'Please enter rules and policy',
      ),
      ServiceFormField(
        key: 'importantInformation',
        label: 'Important Information',
        placeholder: 'Enter important information',
        type: ServiceFieldType.textarea,
        isRequired: false,
      ),
    ],
  );

  static final ServiceFormConfig _tripConfig = ServiceFormConfig(
    fields: [
      ServiceFormField(
        key: 'name',
        label: 'Trip Name',
        placeholder: 'Enter trip name',
        type: ServiceFieldType.text,
        isRequired: true,
        validationMessage: 'Please enter trip name',
      ),
      ServiceFormField(
        key: 'description',
        label: 'Description',
        placeholder: 'Enter trip description',
        type: ServiceFieldType.textarea,
        isRequired: true,
        validationMessage: 'Please enter description',
      ),
      ServiceFormField(
        key: 'pricePerPerson',
        label: 'Price Per Person',
        placeholder: 'Enter price per person',
        type: ServiceFieldType.number,
        isRequired: true,
        validationMessage: 'Please enter valid price',
        minValue: 0,
      ),
      ServiceFormField(
        key: 'pickupMeetingLocation',
        label: 'Pickup/Meeting Location',
        placeholder: 'Enter pickup or meeting location',
        type: ServiceFieldType.text,
        isRequired: true,
        validationMessage: 'Please enter pickup location',
      ),
      ServiceFormField(
        key: 'image',
        label: 'Trip Image',
        placeholder: 'Upload trip image',
        type: ServiceFieldType.imageUpload,
        isRequired: true,
        validationMessage: 'Please upload trip image',
      ),
      ServiceFormField(
        key: 'providerName',
        label: 'Provider Name',
        placeholder: 'Enter provider name',
        type: ServiceFieldType.text,
        isRequired: true,
        validationMessage: 'Please enter provider name',
      ),
      ServiceFormField(
        key: 'durationInHours',
        label: 'Duration (Hours)',
        placeholder: 'Enter trip duration in hours',
        type: ServiceFieldType.number,
        isRequired: true,
        validationMessage: 'Please enter valid duration',
        minValue: 1,
        maxValue: 720, // 30 days max
      ),
      ServiceFormField(
        key: 'endPoint',
        label: 'End Point',
        placeholder: 'Enter trip end point',
        type: ServiceFieldType.text,
        isRequired: true,
        validationMessage: 'Please enter end point',
      ),
      ServiceFormField(
        key: 'whatsIncluded',
        label: 'What\'s Included',
        placeholder: 'Enter what\'s included',
        type: ServiceFieldType.textarea,
        isRequired: true,
        validationMessage: 'Please enter what\'s included',
      ),
      ServiceFormField(
        key: 'rulesAndCancellationPolicy',
        label: 'Rules & Cancellation Policy',
        placeholder: 'Enter rules and cancellation policy',
        type: ServiceFieldType.textarea,
        isRequired: true,
        validationMessage: 'Please enter rules and policy',
      ),
      ServiceFormField(
        key: 'importantInformation',
        label: 'Important Information',
        placeholder: 'Enter important information',
        type: ServiceFieldType.textarea,
        isRequired: false,
      ),
    ],
  );

  static final ServiceFormConfig _productConfig = ServiceFormConfig(
    fields: [
      ServiceFormField(
        key: 'name',
        label: 'Product Name',
        placeholder: 'Enter product name',
        type: ServiceFieldType.text,
        isRequired: true,
        validationMessage: 'Please enter product name',
      ),
      ServiceFormField(
        key: 'description',
        label: 'Description',
        placeholder: 'Enter product description',
        type: ServiceFieldType.textarea,
        isRequired: true,
        validationMessage: 'Please enter description',
      ),
      ServiceFormField(
        key: 'price',
        label: 'Price',
        placeholder: 'Enter product price',
        type: ServiceFieldType.number,
        isRequired: true,
        validationMessage: 'Please enter valid price',
        minValue: 0,
      ),
      ServiceFormField(
        key: 'categoryId',
        label: 'Category',
        placeholder: 'Select product category',
        type: ServiceFieldType.categoryDropdown,
        isRequired: true,
        validationMessage: 'Please select category',
      ),
      ServiceFormField(
        key: 'isDeliveryAvailable',
        label: 'Delivery Available',
        placeholder: 'Select delivery availability',
        type: ServiceFieldType.dropdown,
        options: ['Yes', 'No'],
        isRequired: true,
        validationMessage: 'Please select delivery option',
      ),
      ServiceFormField(
        key: 'shippingCost',
        label: 'Shipping Cost',
        placeholder: 'Enter shipping cost',
        type: ServiceFieldType.number,
        isRequired: false,
        minValue: 0,
      ),
      ServiceFormField(
        key: 'location',
        label: 'Location',
        placeholder: 'Enter product location',
        type: ServiceFieldType.text,
        isRequired: true,
        validationMessage: 'Please enter location',
      ),
      ServiceFormField(
        key: 'image',
        label: 'Product Image',
        placeholder: 'Upload product image',
        type: ServiceFieldType.imageUpload,
        isRequired: true,
        validationMessage: 'Please upload product image',
      ),
      ServiceFormField(
        key: 'rulesAndCancellationPolicy',
        label: 'Rules & Cancellation Policy',
        placeholder: 'Enter rules and cancellation policy',
        type: ServiceFieldType.textarea,
        isRequired: true,
        validationMessage: 'Please enter rules and policy',
      ),
      ServiceFormField(
        key: 'importantInformation',
        label: 'Important Information',
        placeholder: 'Enter important information',
        type: ServiceFieldType.textarea,
        isRequired: false,
      ),
    ],
  );
}
