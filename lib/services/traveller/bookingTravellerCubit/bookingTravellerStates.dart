abstract class BookingTravellerStates {}

final class  BookingTravellerInitial extends BookingTravellerStates {}

final class ToggleBookingSucsses extends BookingTravellerStates {}

final class getBookingError extends BookingTravellerStates {
  final String error;

  getBookingError(this.error);
}
final class getBookingByIdSuccessful extends BookingTravellerStates {}
final class getBookingLoading extends BookingTravellerStates {}


/// details

final class getBookingDetailsError extends BookingTravellerStates {
  final String error;

  getBookingDetailsError(this.error);
}
final class getBookingDetailsSuccessful extends BookingTravellerStates {}
final class getBookingDetailsLoading extends BookingTravellerStates {}

/// create booking

final class CreateBookingError extends BookingTravellerStates {
  final String error;

  CreateBookingError(this.error);
}
final class CreateBookingLoading extends BookingTravellerStates {}
final class CreateBookingSuccessful extends BookingTravellerStates {}
/// pick date
final class PickDateBlocLoading extends BookingTravellerStates {}
final class PickDateBlocSSuccessfulState extends BookingTravellerStates {}
/// room
final class getRoomError extends BookingTravellerStates {
  final String error;

  getRoomError(this.error);
}
final class getRoomLoading extends BookingTravellerStates {}
final class getRoomByIdSuccessful extends BookingTravellerStates {}

final class CalcOk extends BookingTravellerStates {}

/// booking Room
final class CreateBookingRoomLoading extends BookingTravellerStates {}
final class CreateBookingRoomSuccessful extends BookingTravellerStates {}

final class CreateBookingRoomError extends BookingTravellerStates {
  final String error;

  CreateBookingRoomError(this.error);
}


/// room detaisl
final class getRoomDetailsLoading extends BookingTravellerStates {}
final class getRoomDetailsSuccessful extends BookingTravellerStates {}

final class getRoomDetailsError extends BookingTravellerStates {
  final String error;

  getRoomDetailsError(this.error);
}

final class SelectItemLoaded extends BookingTravellerStates {}
final class GetRoomLoaded extends BookingTravellerStates {}
final class AddRoomLoaded extends BookingTravellerStates {}


/// check gender
final class CheckGenderLoading extends BookingTravellerStates {}
final class CheckGenderSuccessful extends BookingTravellerStates {}
final class AddAnotherBookingSuccessful extends BookingTravellerStates {}
final class AddBookingSuccessful extends BookingTravellerStates {}
final class DeleteBookingSuccessful extends BookingTravellerStates {}
final class ReplaceSuccessful extends BookingTravellerStates {}


/// create activity booking

final class CreateBookingActivityLoading extends BookingTravellerStates {}
final class CreateBookingActivitySuccessful extends BookingTravellerStates {}

final class CreateBookingActivityError extends BookingTravellerStates {
  final String error;

  CreateBookingActivityError(this.error);
}

/// cancel booking

final class CancelBookingLoading extends BookingTravellerStates {}
final class CancelBookingSuccessful extends BookingTravellerStates {
  final String data;

  CancelBookingSuccessful(this.data);
}

final class CancelBookingError extends BookingTravellerStates {
  final String error;

  CancelBookingError(this.error);
}
final class AgrreCheckSuccessful extends BookingTravellerStates {}
/// book again
final class BookingAgainLoading extends BookingTravellerStates {}
final class BookingAgainSuccessful extends BookingTravellerStates {}

final class BookingAgainError extends BookingTravellerStates {
  final String error;

  BookingAgainError(this.error);
}
/// book trips
final class BookingAgainTripsLoading extends BookingTravellerStates {}

final class BookingAgainTripsSuccessful extends BookingTravellerStates {}

final class BookingAgainTripsError extends BookingTravellerStates {
  final String error;

  BookingAgainTripsError(this.error);
}
/// accom
final class BookingAgainRoomsLoading extends BookingTravellerStates {}

final class BookingAgainRoomsSuccessful extends BookingTravellerStates {}
final class PaymentLoading extends BookingTravellerStates {}

final class BookingAgainRoomsError extends BookingTravellerStates {
  final String error;

  BookingAgainRoomsError(this.error);
}
final class PaymentSuccess extends BookingTravellerStates {
  // final String bookingId;
  //
  // PaymentSuccess(this.bookingId);
}

final class PaymentError extends BookingTravellerStates {
  final String error;

  PaymentError(this.error);
}

final class PaymentOrNotError extends BookingTravellerStates {
  final String error;

  PaymentOrNotError(this.error);
}
final class PaymentOrNotSuccessful extends BookingTravellerStates {}

final class PaymentOrNotLoading extends BookingTravellerStates {

}
final class AddProfitLoading extends BookingTravellerStates {}

final class AddProfitSuccessful extends BookingTravellerStates {

}
final class AddProfitError extends BookingTravellerStates {
final String error;

AddProfitError(this.error);
}
final class AddProfitTripsLoading extends BookingTravellerStates {}

final class AddProfitTripsSuccessful extends BookingTravellerStates {

}
final class AddProfitTripsError extends BookingTravellerStates {
final String error;

AddProfitTripsError(this.error);
}
final class AddProfitActivityLoading extends BookingTravellerStates {}

final class AddProfitActivitySuccessful extends BookingTravellerStates {

}
final class AddProfitActivityError extends BookingTravellerStates {
final String error;

AddProfitActivityError(this.error);
}
final class PaymentActivityLoading extends BookingTravellerStates {}

final class PaymentSuccessActivity extends BookingTravellerStates {
}

final class SendNotificationLoading extends BookingTravellerStates {}

final class SendNotificationSuccessful extends BookingTravellerStates {

}


final class ToggleRoomSucsses extends BookingTravellerStates {

}
final class SendNotificationError extends BookingTravellerStates {
  final String error;
  SendNotificationError(this.error);
}


