part of 'add_trip_cubit.dart';

@immutable
sealed class AddTripState {}

final class AddTripInitial extends AddTripState {}

final class AddTripLoading extends AddTripState {}

final class AddTripSuccess extends AddTripState {}

final class AddTripError extends AddTripState {
  final String message;
  AddTripError(this.message);
}

final class AddTripImagePicked extends AddTripState {}

final class AddTripImageRemoved extends AddTripState {}
