part of 'partner_register_cubit.dart';

@immutable
sealed class PartnerRegisterState {}

final class PartnerRegisterPasswordVisibilityChanged
    extends PartnerRegisterState {}

final class PartnerRegisterPasswordVisibilityChanged2
    extends PartnerRegisterState {}

final class CheckGenderSuccessful extends PartnerRegisterState {}

final class PartnerRegisterToggleGeneralInfo extends PartnerRegisterState {}

final class PartnerRegisterTogglePrivateInfo extends PartnerRegisterState {}

final class PartnerRegisterChangeCurrentIndex extends PartnerRegisterState {}

final class PartnerRegisterChangeServiceSelected extends PartnerRegisterState {}

final class PartnerRegisterPickCompanyLogo extends PartnerRegisterState {}

final class RegisterPartnerLoading extends PartnerRegisterState {}

final class ChangeContry extends PartnerRegisterState {}

final class PartnerRegisterInitial extends PartnerRegisterState {}

final class PartnerRegisterLoading extends PartnerRegisterState {}

final class PartnerRegisterSuccess extends PartnerRegisterState {}

final class PartnerRegisterFailure extends PartnerRegisterState {
  final String error;

  PartnerRegisterFailure(this.error);
}

final class PartnerRegisterChangeTripType extends PartnerRegisterState {}
