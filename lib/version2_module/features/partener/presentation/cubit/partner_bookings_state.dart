import 'package:equatable/equatable.dart';
import '../../domain/models/partner_booking_model.dart';

abstract class PartnerBookingsState extends Equatable {
  const PartnerBookingsState();

  @override
  List<Object?> get props => [];
}

class PartnerBookingsInitial extends PartnerBookingsState {}

class PartnerBookingsLoading extends PartnerBookingsState {}

class PartnerBookingsLoaded extends PartnerBookingsState {
  final List<PartnerBookingModel> bookings;
  final bool hasMore;
  final int totalCount;

  const PartnerBookingsLoaded({
    required this.bookings,
    required this.hasMore,
    required this.totalCount,
  });

  @override
  List<Object?> get props => [bookings, hasMore, totalCount];
}

class PartnerBookingsError extends PartnerBookingsState {
  final String message;

  const PartnerBookingsError(this.message);

  @override
  List<Object?> get props => [message];
}
