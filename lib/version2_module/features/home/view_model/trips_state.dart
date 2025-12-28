import 'package:equatable/equatable.dart';
import 'package:PassPort/models/traveller/trips_model/trips_model.dart'
    as trips_model;

abstract class TripsState extends Equatable {
  const TripsState();

  @override
  List<Object> get props => [];
}

class TripsInitial extends TripsState {}

class TripsLoading extends TripsState {}

class TripsSuccess extends TripsState {
  final List<trips_model.Data> trips;

  const TripsSuccess(this.trips);
}

class TripsError extends TripsState {
  final String message;

  const TripsError(this.message);
}
