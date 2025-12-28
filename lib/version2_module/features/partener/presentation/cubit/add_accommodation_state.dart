part of 'add_accommodation_cubit.dart';

abstract class AddAccommodationState {}

class AddAccommodationInitial extends AddAccommodationState {}

class AddAccommodationLoading extends AddAccommodationState {}

class AddAccommodationSuccess extends AddAccommodationState {}

class AddAccommodationError extends AddAccommodationState {
  final String message;
  AddAccommodationError(this.message);
}
