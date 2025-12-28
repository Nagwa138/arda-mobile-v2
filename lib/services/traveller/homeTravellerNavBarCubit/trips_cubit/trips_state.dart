abstract class TripsStates {}

/// Get All Trips

final class TripsInitial extends TripsStates {}

final class CalendarLoaded extends TripsStates {}


final class GetTripsLoading extends TripsStates {}

final class GetTripsSuccessful extends TripsStates {}

final class GetTripsError extends TripsStates {
  final String error;

  GetTripsError({required this.error});
}

/// get Id trip
final class GetTripByIdLoading extends TripsStates {}

final class GetTripByIdSuccessful extends TripsStates {}

final class GetTripByIdError extends TripsStates {
  final String error;

  GetTripByIdError({required this.error});
}
/// create trips
final class CreateTripLoading extends TripsStates {}

final class CreateTripSuccessful extends TripsStates {}

final class CreateTripError extends TripsStates {
  final String error;

  CreateTripError({required this.error});
}

///
final class PickDateBlocLoading extends TripsStates {}

final class PickDateBlocSSuccessfulState extends TripsStates {}
/// favourite
final class AddFavouriteOfTripsLoading extends TripsStates {}

final class AddFavouriteOfTripsSuccessful extends TripsStates {}

final class AddFavouriteOfTripsError extends TripsStates {
  final String error;

  AddFavouriteOfTripsError({required this.error});
}

final class deleteFavouriteOfTripsLoading extends TripsStates {}

final class deleteFavouriteOfTripsSuccessful extends TripsStates {}

final class deleteFavouriteOfTripsError extends TripsStates {
  final String error;

  deleteFavouriteOfTripsError({required this.error});
}

final class FavChange extends TripsStates {}

