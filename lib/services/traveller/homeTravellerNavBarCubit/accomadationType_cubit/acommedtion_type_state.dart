abstract class AccommodatingState {}

/// Get All accomondation
final class AccommodatingInitial extends AccommodatingState {}

final class GetAccommodatingLoading extends AccommodatingState {}

final class GetAccommodatingSuccessful extends AccommodatingState {}

final class GetAccommodatingError extends AccommodatingState {
  final String error;

  GetAccommodatingError({required this.error});
}

final class FavouriteChange extends AccommodatingState {}
///
final class GetAccommodatingBasedTypeLoading extends AccommodatingState {}

final class GetAccommodatingBasedTypeSuccessful extends AccommodatingState {}

final class GetAccommodatingBasedTypeError extends AccommodatingState {
  final String error;

  GetAccommodatingBasedTypeError({required this.error});
}

///
final class GetAccommodatingBasedTypeCampLoading extends AccommodatingState {}

final class GetAccommodatingBasedTypeSuccessfulCamp extends AccommodatingState {}

final class GetAccommodatingBasedTypeErrorCamp extends AccommodatingState {
  final String error;

  GetAccommodatingBasedTypeErrorCamp({required this.error});
}

/// one get accomandation
final class GetOneAccommodatingLoading extends AccommodatingState {}

final class GetOneAccommodatingSuccessful extends AccommodatingState {}

final class GetOneAccommodatingError extends AccommodatingState {
  final String error;

  GetOneAccommodatingError({required this.error});
}

/// add favourite
final class AddFavouriteOfAccomandationSuccessful extends AccommodatingState {}

final class AddFavouriteOfAccomandationLoading extends AccommodatingState {}

final class AddFavouriteOfAccomandationError extends AccommodatingState {
  final String error;

  AddFavouriteOfAccomandationError({required this.error});
}

/// delete favourite
final class deleteFavouriteOfAccomandationSuccessful extends AccommodatingState {}

final class deleteFavouriteOfAccomandationLoading extends AccommodatingState {}

final class deleteFavouriteOfAccomandationError extends AccommodatingState {
  final String error;

  deleteFavouriteOfAccomandationError({required this.error});
}

final class FavChangeHotel extends AccommodatingState {}
final class FavChangeCamp extends AccommodatingState {}



final class GetFiltertionSuccessful extends AccommodatingState {}
final class GetFiltertionLoading extends AccommodatingState {}

final class GetAllFavouriteAccomandationLoading extends AccommodatingState {}



final class GetAllFavouriteAccomandationSuccessful extends AccommodatingState {}
final class GetAllFavouriteAccomandationError extends AccommodatingState {
  final String error ;

  GetAllFavouriteAccomandationError(this.error);
}
