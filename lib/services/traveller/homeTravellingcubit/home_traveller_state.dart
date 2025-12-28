abstract class HomeTravellerState {}

final class HomeTravellerInitial extends HomeTravellerState {}

final class getBlocLoading extends HomeTravellerState {}

final class getBlocSuccessful extends HomeTravellerState {}

final class getBlocError extends HomeTravellerState {
  final String error;

  getBlocError({required this.error});
}
/// get blog By Id
final class getBlocByIdLoading extends HomeTravellerState {}

final class getBlocByIdSuccessful extends HomeTravellerState {}

final class getBlocByIdError extends HomeTravellerState {
  final String error;

  getBlocByIdError({required this.error});
}
/// post favourite blog
///
final class postFavouriteLoading extends HomeTravellerState {}

final class postFavouriteSuccessful extends HomeTravellerState {}

final class postFavouriteError extends HomeTravellerState {
  final String error;

  postFavouriteError({required this.error});
}

/// delete Favourite
final class deleteFavouriteLoading extends HomeTravellerState {}

final class deleteFavouriteSuccessful extends HomeTravellerState {}

final class deleteFavouriteError extends HomeTravellerState {
  final String error;

  deleteFavouriteError({required this.error});
}

///
final class FavChange extends HomeTravellerState {}

final class FavChangeRated extends HomeTravellerState {}


///  get blog category
final class getCategoryBlogLoading extends HomeTravellerState {}

final class getCategoryBlogSuccessful extends HomeTravellerState {}

final class getCategoryBlogError extends HomeTravellerState {
  final String error;

  getCategoryBlogError({required this.error});
}

final class ScrollSusccessfulRigth extends HomeTravellerState {}

final class ScrollSusccessfulLeft extends HomeTravellerState {}

/// top rated
final class TopRatedLoading extends HomeTravellerState {}

final class TopRatedSuccessful extends HomeTravellerState {}

final class TopRatedError extends HomeTravellerState {
  final String error;

  TopRatedError({required this.error});
}

/// Random Activity
final class RandomActivityLoading extends HomeTravellerState {}

final class RandomActivitySuccessful extends HomeTravellerState {}

final class RandomActivityError extends HomeTravellerState {
  final String error;

  RandomActivityError({required this.error});
}

/// Random camp
final class RandomCampLoading extends HomeTravellerState {}

final class RandomCampSuccessful extends HomeTravellerState {}

final class RandomCampError extends HomeTravellerState {
  final String error;

  RandomCampError({required this.error});
}

/// random Hotel
final class RandomHotelLoading extends HomeTravellerState {}

final class RandomHotelSuccessful extends HomeTravellerState {}

final class RandomHotelError extends HomeTravellerState {
  final String error;

  RandomHotelError({required this.error});
}

