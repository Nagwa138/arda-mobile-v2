part of 'service_submission_cubit.dart';

abstract class ServiceSubmissionState {}

class ServiceSubmissionInitial extends ServiceSubmissionState {}

class ServiceSubmissionLoading extends ServiceSubmissionState {}

class ServiceSubmissionSuccess extends ServiceSubmissionState {
  final String message;
  ServiceSubmissionSuccess(this.message);
}

class ServiceSubmissionError extends ServiceSubmissionState {
  final String message;
  ServiceSubmissionError(this.message);
}

class GetServiceDetailsSuccess extends ServiceSubmissionState {
  final serviceDetails;
  GetServiceDetailsSuccess(this.serviceDetails);
}

class GetServiceDetailsError extends ServiceSubmissionState {
  final String message;
  GetServiceDetailsError(this.message);
}

class GetServiceDetailsLoading extends ServiceSubmissionState {}
