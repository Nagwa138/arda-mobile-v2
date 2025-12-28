# User Type Switching System

## النظرة العامة / Overview

هذا النظام يسمح للمستخدمين بالتبديل بين أنواع المستخدمين المختلفة في التطبيق (Traveller, Partner, Admin) مع إعادة تحميل التطبيق والانتقال للواجهة المناسبة.

This system allows users to switch between different user types in the application (Traveller, Partner, Admin) with app restart and navigation to the appropriate interface.

## المكونات الأساسية / Core Components

### 1. UserType Enum

```dart
enum UserType {
  traveller(0),    // المسافر
  partner(1),      // الشريك العام
  admin(2),        // المدير
  accommodation(3), // مقدم الإقامة
  activity(4),     // مقدم الأنشطة
  trip(5),         // منظم الرحلات
  product(6);      // بائع المنتجات
}
```

### 2. UserManager Service

خدمة شاملة لإدارة:

- تسجيل الدخول والخروج
- التبديل بين أنواع المستخدمين
- حفظ واسترجاع بيانات المستخدم
- إدارة الموافقات للشركاء

### 3. UserTypeSwitcher Widget

Widget جاهز للاستخدام يمكن إضافته لأي صفحة للسماح بالتبديل بين أنواع المستخدمين.

## كيفية الاستخدام / How to Use

### 1. إضافة UserTypeSwitcher لصفحة الProfile

```dart
import 'package:PassPort/components/widgets/user_type_switcher.dart';

// في صفحة الProfile
const UserTypeSwitcher(
  showCurrentType: true,
  showAsCard: true,
)
```

### 2. التبديل البرمجي / Programmatic Switching

```dart
import 'package:PassPort/services/user_manager/user_manager.dart';
import 'package:PassPort/models/user_type.dart';

// التبديل لنوع مستخدم جديد
await UserManager.switchUserType(
  newUserType: UserType.accommodation,
  context: context,
  requiresApproval: true, // يتطلب موافقة الإدارة
);
```

### 3. تسجيل الدخول

```dart
await UserManager.login(
  token: 'user_token_from_api',
  userType: UserType.traveller,
);
```

### 4. تسجيل الخروج

```dart
await UserManager.logout();
```

## سيناريوهات الاستخدام / Usage Scenarios

### سيناريو 1: مسافر يريد أن يصبح شريك

1. المسافر يذهب لصفحة الProfile
2. يضغط على "Switch to Partner"
3. يختار نوع الخدمة (Accommodation, Activity, etc.)
4. يرسل طلب للإدارة
5. بعد الموافقة، يتم التبديل تلقائياً

### سيناريو 2: شريك يريد العودة للمسافر

1. الشريك يذهب لصفحة الProfile
2. يضغط على "Switch to Traveller"
3. يتم التبديل فوراً بدون موافقة

### سيناريو 3: المدير يبدل بين الأنواع

1. المدير يمكنه التبديل لأي نوع مستخدم
2. بدون الحاجة لموافقات

## التخصيص / Customization

### تخصيص UserTypeSwitcher

```dart
UserTypeSwitcher(
  showCurrentType: false,  // إخفاء النوع الحالي
  showAsCard: false,       // عرض كقائمة بدلاً من كارت
)
```

### إضافة أنواع مستخدمين جديدة

1. أضف النوع الجديد في `UserType` enum
2. أضف `displayName` و `arabicName`
3. أضف `homeRoute` للتوجيه
4. أضف الألوان والأيقونات في `UserTypeSwitcher`

## الأمان / Security

### التحقق من الصلاحيات

```dart
// التحقق من إمكانية التبديل
if (UserManager.canSwitchTo(UserType.accommodation)) {
  // السماح بالتبديل
}

// الحصول على الأنواع المتاحة
List<UserType> availableTypes = UserManager.getAvailableUserTypes();
```

### حماية التبديل

- المسافر → شريك: يتطلب موافقة الإدارة
- شريك → مسافر: مباشر
- المدير: يمكنه التبديل لأي نوع

## API Integration

### إرسال طلب الموافقة للخادم

```dart
// في UserManager._requestPartnerApproval()
// إضافة API call للخادم
final response = await http.post(
  Uri.parse('${API_BASE}/partner-request'),
  body: {
    'userId': currentUserId,
    'requestedType': partnerType.value.toString(),
  },
);
```

### استقبال الموافقات من الخادم

```dart
// عند الموافقة من الإدارة
await UserManager.switchUserType(
  newUserType: approvedType,
  context: context,
  requiresApproval: false, // تم الموافقة مسبقاً
);
```

## تحديث التطبيق / App Updates

### إضافة UserManager للتطبيق الحالي

1. **في main.dart:**

```dart
import 'services/user_manager/user_manager.dart';

void main() async {
  // إضافة هذا السطر
  await UserManager.initialize();
  // باقي الكود...
}
```

2. **تحديث صفحات الProfile:**

```dart
import 'package:PassPort/components/widgets/user_type_switcher.dart';

// إضافة في body
const UserTypeSwitcher(
  showCurrentType: true,
  showAsCard: true,
),
```

3. **تحديث تسجيل الدخول/الخروج:**

```dart
// بدلاً من SecureStorage مباشرة
await UserManager.login(token: token, userType: userType);
await UserManager.logout();
```

## المثال الكامل / Complete Example

شاهد `lib/examples/user_type_switching_example.dart` للمثال الكامل مع جميع الاستخدامات.

## الاختبار / Testing

### اختبار التبديل

```dart
// محاكاة تسجيل الدخول
await UserManager.login(
  token: 'test_token',
  userType: UserType.traveller,
);

// اختبار التبديل
bool success = await UserManager.switchUserType(
  newUserType: UserType.accommodation,
  context: context,
  requiresApproval: false,
);

assert(success == true);
assert(UserManager.currentUserType == UserType.accommodation);
```

## المشاكل الشائعة / Common Issues

### 1. التطبيق لا يعيد التحميل بعد التبديل

- تأكد من استدعاء `AppNavigation.navigateToUserTypeHome(context)`

### 2. UserTypeSwitcher لا يظهر خيارات

- تأكد من تسجيل الدخول أولاً
- تحقق من `UserManager.getAvailableUserTypes()`

### 3. خطأ في الNavigation

- تأكد من إضافة جميع routes في `route.dart`
- تحقق من `UserType.homeRoute` values

## الدعم / Support

للمساعدة أو الاستفسارات، يرجى مراجعة:

- الكود في `lib/services/user_manager/`
- المثال في `lib/examples/user_type_switching_example.dart`
- هذا الملف للتوثيق الكامل
