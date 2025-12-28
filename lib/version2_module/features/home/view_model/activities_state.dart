import 'package:equatable/equatable.dart';
import 'package:PassPort/models/traveller/activity/activity_random_model.dart'
    as activity_model;

abstract class ActivitiesState extends Equatable {
  const ActivitiesState();

  @override
  List<Object> get props => [];
}

class ActivitiesInitial extends ActivitiesState {}

class ActivitiesLoading extends ActivitiesState {}

class ActivitiesSuccess extends ActivitiesState {
  final List<activity_model.Data> activities;

  const ActivitiesSuccess(this.activities);
}

class ActivitiesError extends ActivitiesState {
  final String message;

  const ActivitiesError(this.message);
}
