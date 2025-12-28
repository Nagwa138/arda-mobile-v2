
abstract class TravellerRegisterState {}

final class TravellerRegisterInitial extends TravellerRegisterState {}

final class TravellerRegisterPasswordVisibilityChanged extends TravellerRegisterState {}

final class TravellerRegisterGenderChanged extends TravellerRegisterState {}

final class TravellerRegisterToggleBtn extends TravellerRegisterState {}
final class PickDateBlocSSuccessfulState extends TravellerRegisterState {}

final class PickDateBlocLoading extends TravellerRegisterState {}

///  state Register traveller

final class RegisterTravellingLoading extends TravellerRegisterState {}

final class RegisterTravellingError extends TravellerRegisterState {
  final String error;

  RegisterTravellingError(this.error);
}

final class RegisterTravellingSuccessful extends TravellerRegisterState {}
