# Partner Service Details Screens

هذا المجلد يحتوي على صفحات تفاصيل الخدمات للشركاء مع UI رائع وجذاب.

## الصفحات المتوفرة:

### 1. Partner Product Details Screen

- **الملف**: `partner_product_details_screen.dart`
- **الروت**: `partnerProductDetails`
- **الغرض**: عرض تفاصيل المنتج مع إمكانية التعديل والحذف
- **المميزات**:
  - عرض صورة المنتج بـ Hero Animation
  - عرض السعر والتقييم
  - معلومات التوصيل
  - الوصف والقوانين
  - أزرار التعديل والحذف

### 2. Partner Activity Details Screen

- **الملف**: `partner_activity_details_screen.dart`
- **الروت**: `partnerActivityDetails`
- **الغرض**: عرض تفاصيل النشاط مع إمكانية التعديل والحذف
- **المميزات**:
  - عرض صورة النشاط
  - مدة النشاط والموقع
  - مقدم الخدمة وأوقات العمل
  - ما هو متضمن
  - القوانين والمعلومات المهمة

### 3. Partner Trip Details Screen

- **الملف**: `partner_trip_details_screen.dart`
- **الروت**: `partnerTripDetails`
- **الغرض**: عرض تفاصيل الرحلة مع إمكانية التعديل والحذف
- **المميزات**:
  - عرض صورة الرحلة
  - مدة الرحلة ونقطة البداية والنهاية
  - مقدم الخدمة
  - ما هو متضمن
  - القوانين والمعلومات المهمة

## الاستخدام:

### 1. التنقل إلى صفحة تفاصيل المنتج:

```dart
Navigator.pushNamed(context, 'partnerProductDetails', arguments: {
  'id': productId,
  'name': productName,
  'location': productLocation,
  'price': productPrice,
  'rate': productRating,
  'status': productStatus,
  'image': productImageUrl,
});
```

### 2. التنقل إلى صفحة تفاصيل النشاط:

```dart
Navigator.pushNamed(context, 'partnerActivityDetails', arguments: {
  'id': activityId,
  'name': activityName,
  'activityLocation': activityLocation,
  'pricePerPerson': pricePerPerson,
  'rate': activityRating,
  'status': activityStatus,
  'image': activityImageUrl,
});
```

### 3. التنقل إلى صفحة تفاصيل الرحلة:

```dart
Navigator.pushNamed(context, 'partnerTripDetails', arguments: {
  'id': tripId,
  'name': tripName,
  'pickupMeetingLocation': pickupLocation,
  'pricePerPerson': pricePerPerson,
  'rate': tripRating,
  'status': tripStatus,
  'image': tripImageUrl,
});
```

## المميزات العامة:

1. **UI جذاب ومتطور**: استخدام SliverAppBar مع صور بـ Hero Animation
2. **تصميم متجاوب**: يتكيف مع جميع أحجام الشاشات
3. **ألوان حالة الخدمة**: ألوان مختلفة حسب حالة الخدمة (نشط، معلق، مرفوض)
4. **أقسام قابلة للتوسيع**: لعرض القوانين والمعلومات المهمة
5. **أزرار الإجراءات**: تعديل وحذف مع تأكيد
6. **تعامل مع الأخطاء**: عرض صور بديلة عند عدم توفر الصورة

## الروتس المطلوبة في route.dart:

```dart
// Partner Service Details Routes
const String partnerProductDetails = "partnerProductDetails";
const String partnerActivityDetails = "partnerActivityDetails";
const String partnerTripDetails = "partnerTripDetails";
```

## الاعتمادات:

- `flutter_screenutil`: للتصميم المتجاوب
- `flutter_rating_bar`: لعرض التقييمات
- `PassPort/components/color/color.dart`: للألوان المخصصة

تم إنشاء هذه الصفحات لتحسين تجربة المستخدم وتوفير واجهة أنيقة وسهلة الاستخدام للشركاء لإدارة خدماتهم.
