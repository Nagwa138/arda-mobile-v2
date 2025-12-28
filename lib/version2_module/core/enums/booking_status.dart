import 'package:flutter/material.dart';

enum BookingStatus {
  pending(0, 'Pending'),
  upcoming(1, 'Upcoming'),
  completed(2, 'Completed'),
  cancelled(3, 'Cancelled');

  const BookingStatus(this.id, this.displayName);

  final int id;
  final String displayName;

  static BookingStatus fromId(int id) {
    return BookingStatus.values.firstWhere((status) => status.id == id);
  }

  static BookingStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return BookingStatus.pending;
      case 'upcoming':
        return BookingStatus.upcoming;
      case 'completed':
        return BookingStatus.completed;
      case 'cancelled':
        return BookingStatus.cancelled;
      default:
        return BookingStatus.pending;
    }
  }

  Color get statusColor {
    switch (this) {
      case BookingStatus.pending:
        return const Color(0xFFFFA726); // Orange
      case BookingStatus.upcoming:
        return const Color(0xFF42A5F5); // Blue
      case BookingStatus.completed:
        return const Color(0xFF66BB6A); // Green
      case BookingStatus.cancelled:
        return const Color(0xFFEF5350); // Red
    }
  }

  Color get backgroundColor {
    switch (this) {
      case BookingStatus.pending:
        return const Color(0xFFFFF3E0); // Light Orange
      case BookingStatus.upcoming:
        return const Color(0xFFE3F2FD); // Light Blue
      case BookingStatus.completed:
        return const Color(0xFFE8F5E8); // Light Green
      case BookingStatus.cancelled:
        return const Color(0xFFFFEBEE); // Light Red
    }
  }
}
