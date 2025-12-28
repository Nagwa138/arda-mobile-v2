abstract class UserState {}

final class UserInitial extends UserState {}

final class getInformationLoading extends UserState {}

final class getInformationSuccessful extends UserState {}

final class getInformationError extends UserState {
  final String error;

  getInformationError({required this.error});
}

///
final class UpdateInformationLoading extends UserState {}

final class UpdateInformationSuccessful extends UserState {}

final class UpdateInformationError extends UserState {
  final String error;

  UpdateInformationError({required this.error});
}
///
final class CheckGenderLoading extends UserState {}

final class CheckGenderSuccessful extends UserState {}

/// delete account
final class DeleteAccountLoading extends UserState {}

final class DeleteAccountSuccessful extends UserState {}

final class DeleteAccountError extends UserState {
  final String error;

  DeleteAccountError({required this.error});
}

final class ProfitsLoading extends UserState {}

final class ProfitsSuccessful extends UserState {}

final class ProfitsError extends UserState {
  final String error;

  ProfitsError({required this.error});
}

final class ChangePasswordLoading extends UserState {}
final class ChangePasswordIcon extends UserState {}
final class LanchEmailLoaded extends UserState {}
final class LanchEmailError extends UserState {}

final class ChangePasswordIconNew extends UserState {}

final class ChangePasswordIconDelete extends UserState {}


final class WhatsAppLoading extends UserState {}

final class WhatsAppSuccess extends UserState {}

final class WhatsAppFailure extends UserState {
  final String error;

  WhatsAppFailure({required this.error});
}


final class ChangePasswordSuccessful extends UserState {}

final class ChangePasswordError extends UserState {
  final String error;

  ChangePasswordError({required this.error});
}