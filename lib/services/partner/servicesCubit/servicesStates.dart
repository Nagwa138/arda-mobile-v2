abstract class ServicesStates {}

final class ServicesInitial extends ServicesStates {}

final class ChangeToggle extends ServicesStates {}

final class ServicesLoading extends ServicesStates {}

final class ServicesSuccess extends ServicesStates {}

final class ServicesError extends ServicesStates {
  final String error;
  ServicesError(this.error);
}

final class getServicesByIdLoading extends ServicesStates {}

final class getServicesByIdSuccessful extends ServicesStates {}

final class getServicesByIdError extends ServicesStates {
  final String error;
  getServicesByIdError(this.error);
}

///

final class getRoomPartnerLoading extends ServicesStates {}

final class getRoomPartnerSuccessful extends ServicesStates {}

final class getRoomPartnerError extends ServicesStates {
  final String error;
  getRoomPartnerError(this.error);
}
final class RegisterRoomLoading extends ServicesStates {}

final class RegisterRoomLoaded extends ServicesStates {}

final class RegisterRoomError extends ServicesStates {
  final String error;
  RegisterRoomError(this.error);
}
