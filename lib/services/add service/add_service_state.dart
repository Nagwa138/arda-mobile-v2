part of 'add_service_cubit.dart';

@immutable
sealed class AddServiceState {}

final class AddServiceInitial extends AddServiceState {}

final class AddServiceDescriptionIndex extends AddServiceState {}

final class AddServiceChangeIndex extends AddServiceState {}

final class AddServiceRoomNumChanged extends AddServiceState {}

final class AddServiceAmenitiesChanged extends AddServiceState {}

final class AgreeCheckLoading extends AddServiceState {}

final class AgreeCheckLoadingSuccessful extends AddServiceState {}

final class AgreeCheckDoubleLoading extends AddServiceState {}

final class AgreeCheckDoubleLoadingSuccessful extends AddServiceState {}

final class AgreeCheckTripleLoading extends AddServiceState {}

final class AgreeCheckTripleLoadingSuccessful extends AddServiceState {}

final class AgreeCheckKingSizeLoading extends AddServiceState {}

final class AgreeCheckKingSizeLoadingSuccessful extends AddServiceState {}

final class AddServiceFeatureChanged extends AddServiceState {}

final class AddServiceImagesChanged extends AddServiceState {}

final class AddServiceDataFetched extends AddServiceState {}

//add

final class AddServiceLoading extends AddServiceState {}

final class AddServiceSuccess extends AddServiceState {}

final class AddServiceError extends AddServiceState {
  final String message;

  AddServiceError(this.message);
}

final class UpdateRoomQuantityState extends AddServiceState {}
