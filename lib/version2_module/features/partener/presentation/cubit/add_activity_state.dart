part of 'add_activity_cubit.dart';

@immutable
sealed class AddActivityState {}

final class AddActivityInitial extends AddActivityState {}

final class AddActivityLoading extends AddActivityState {}

final class AddActivitySuccess extends AddActivityState {}

final class AddActivityError extends AddActivityState {
  final String message;
  AddActivityError(this.message);
}

final class AddActivityImagePicked extends AddActivityState {}

final class AddActivityImageRemoved extends AddActivityState {}
