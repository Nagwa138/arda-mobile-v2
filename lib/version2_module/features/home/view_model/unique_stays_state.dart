import 'package:PassPort/models/traveller/accomandating/randomAccomandtion.dart';
import 'package:equatable/equatable.dart';

abstract class UniqueStaysState extends Equatable {
  const UniqueStaysState();

  @override
  List<Object> get props => [];
}

class UniqueStaysInitial extends UniqueStaysState {}

class UniqueStaysLoading extends UniqueStaysState {}

class UniqueStaysSuccess extends UniqueStaysState {
  final List<Data> uniqueStays;

  const UniqueStaysSuccess(this.uniqueStays);
}

class UniqueStaysError extends UniqueStaysState {
  final String message;

  const UniqueStaysError(this.message);
}
