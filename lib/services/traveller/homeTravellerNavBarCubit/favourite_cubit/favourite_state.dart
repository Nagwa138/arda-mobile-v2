



abstract class FavouriteState {}
final class FavouriteInitial extends FavouriteState {}



///
final class GetAllFavouriteLoading extends FavouriteState {}

final class GetAllFavouriteSuccessful extends FavouriteState {}

final class GetAllFavouriteError extends FavouriteState {
  final String error;

  GetAllFavouriteError({required this.error});
}