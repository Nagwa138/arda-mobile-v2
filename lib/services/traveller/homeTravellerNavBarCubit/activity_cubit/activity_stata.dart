abstract class ActivityState {}

/// Get All Activity
final class ActivityInitial extends ActivityState {}

final class GetActivityLoading extends ActivityState {}

final class GetActivitySuccessful extends ActivityState {}

final class GetActivityError extends ActivityState {
  final String error;

  GetActivityError({required this.error});
}

/// Change Favourite
final class FavouriteChange extends ActivityState {}

/// add Favourite activity

final class AddFavouriteOfActivityLoading extends ActivityState {}

final class AddFavouriteOfActivitySuccessful extends ActivityState {}

final class AddFavouriteOfActivityError extends ActivityState {
  final String error;

  AddFavouriteOfActivityError({required this.error});
}

/// delete Favourite activity
final class deleteFavouriteOfActivityLoading extends ActivityState {}

final class deleteFavouriteOfActivitySuccessful extends ActivityState {}

final class deleteFavouriteOfActivityError extends ActivityState {
  final String error;

  deleteFavouriteOfActivityError({required this.error});
}

/// get activity by id
final class GetActivityByIdLoading extends ActivityState {}

final class GetActivityByIdSuccessful extends ActivityState {}

final class GetActivityByIdError extends ActivityState {
  final String error;

  GetActivityByIdError({required this.error});
}