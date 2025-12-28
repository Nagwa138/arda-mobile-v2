import 'package:PassPort/version2_module/core/enums/booking_status.dart';
import 'package:PassPort/version2_module/core/enums/user_type.dart';

class PartnerBookingModel {
  final String id;
  final String bookingId;
  final String name;
  final String email;
  final String gender;
  final String status;
  final int? numOfPersons;
  final DateTime bookingDate;
  final double price;

  // Additional computed fields for UI compatibility
  final UserType? partnerType;

  const PartnerBookingModel({
    required this.id,
    required this.bookingId,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
    this.numOfPersons,
    required this.bookingDate,
    required this.price,
    this.partnerType,
  });

  factory PartnerBookingModel.fromJson(Map<String, dynamic> json,
      {UserType? partnerType}) {
    return PartnerBookingModel(
      id: json['id']?.toString() ?? '',
      bookingId: json['bookingId']?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      gender: json['gender'] ?? '',
      status: json['status']?.toString() ?? '',
      numOfPersons: json['numOfPersons'],
      bookingDate:
          DateTime.tryParse(json['bookingDate'] ?? '') ?? DateTime.now(),
      price: (json['price'] ?? 0).toDouble(),
      partnerType: partnerType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookingId': bookingId,
      'name': name,
      'email': email,
      'gender': gender,
      'status': status,
      'numOfPersons': numOfPersons,
      'bookingDate': bookingDate.toIso8601String(),
      'price': price,
    };
  }

  PartnerBookingModel copyWith({
    String? id,
    String? bookingId,
    String? name,
    String? email,
    String? gender,
    String? status,
    int? numOfPersons,
    DateTime? bookingDate,
    double? price,
    UserType? partnerType,
  }) {
    return PartnerBookingModel(
      id: id ?? this.id,
      bookingId: bookingId ?? this.bookingId,
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      status: status ?? this.status,
      numOfPersons: numOfPersons ?? this.numOfPersons,
      bookingDate: bookingDate ?? this.bookingDate,
      price: price ?? this.price,
      partnerType: partnerType ?? this.partnerType,
    );
  }

  // UI Compatibility getters
  String get guestName => name;
  String get guestEmail => email;
  String get guestPhone => ''; // Not available in API
  String get serviceName => partnerType?.displayName ?? 'Service';
  String get serviceId => bookingId;
  DateTime get checkIn => bookingDate; // Using booking date as placeholder
  DateTime get checkOut =>
      bookingDate.add(Duration(days: 1)); // Default 1 day duration
  int get guests => numOfPersons ?? 1;
  double get totalAmount => price;
  String? get profileImage => null; // Not available in API
  Map<String, dynamic>? get additionalDetails => {
        'gender': gender,
        'partnerType': partnerType?.displayName,
      };

  BookingStatus get bookingStatus {
    // Since status is empty in API, we'll determine based on booking date and status content
    if (status.isNotEmpty) {
      final statusLower = status.toLowerCase();
      if (statusLower.contains('pending')) {
        return BookingStatus.pending;
      } else if (statusLower.contains('cancelled') ||
          statusLower.contains('rejected')) {
        return BookingStatus.cancelled;
      } else if (statusLower.contains('completed') ||
          statusLower.contains('finished')) {
        return BookingStatus.completed;
      } else if (statusLower.contains('confirmed') ||
          statusLower.contains('upcoming')) {
        return BookingStatus.upcoming;
      }
    }

    // Fallback: determine based on booking date
    final now = DateTime.now();
    final daysDifference = now.difference(bookingDate).inDays;

    if (daysDifference < -1) {
      return BookingStatus.upcoming; // Future bookings
    } else if (daysDifference > 1) {
      return BookingStatus.completed; // Past bookings
    } else {
      return BookingStatus.pending; // Current or recent bookings
    }
  }

  // Formatted getters
  String get formattedAmount => '\$${price.toStringAsFixed(2)}';

  String get formattedCheckIn =>
      '${bookingDate.day}/${bookingDate.month}/${bookingDate.year}';

  String get formattedCheckOut =>
      '${checkOut.day}/${checkOut.month}/${checkOut.year}';

  String get formattedBookingDate =>
      '${bookingDate.day}/${bookingDate.month}/${bookingDate.year}';

  int get numberOfNights =>
      1; // Default to 1 night since we don't have checkout date

  String get formattedDateTime =>
      '${bookingDate.day}/${bookingDate.month}/${bookingDate.year} ${bookingDate.hour}:${bookingDate.minute.toString().padLeft(2, '0')}';

  String get genderIcon {
    switch (gender.toLowerCase()) {
      case 'male':
        return '👨';
      case 'female':
        return '👩';
      default:
        return '👤';
    }
  }

  String get statusDisplayText {
    if (status.isNotEmpty) {
      return status;
    }
    return bookingStatus.displayName;
  }
}

class PartnerBookingsResponse {
  final List<PartnerBookingModel> bookings;
  final int totalCount;
  final int skip;
  final int take;
  final int statusCode;
  final String message;

  const PartnerBookingsResponse({
    required this.bookings,
    required this.totalCount,
    required this.skip,
    required this.take,
    required this.statusCode,
    required this.message,
  });

  factory PartnerBookingsResponse.fromJson(Map<String, dynamic> json,
      {UserType? partnerType}) {
    return PartnerBookingsResponse(
      bookings: (json['data'] as List?)
              ?.map((booking) => PartnerBookingModel.fromJson(booking,
                  partnerType: partnerType))
              .toList() ??
          [],
      totalCount: json['totalCount'] ?? 0,
      skip: json['skip'] ?? 0,
      take: json['take'] ?? 10,
      statusCode: json['statusCode'] ?? 200,
      message: json['message'] ?? '',
    );
  }

  bool get hasMore => (skip + take) < totalCount;
  bool get isSuccess => statusCode == 200;
}
