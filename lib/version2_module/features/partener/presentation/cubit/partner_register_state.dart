import '../../domain/entities/partner_register_entity.dart';

abstract class PartnerRegisterState {
  const PartnerRegisterState();
}

class PartnerRegisterInitial extends PartnerRegisterState {}

class PartnerRegisterLoading extends PartnerRegisterState {}

class ServicesLoading extends PartnerRegisterState {}

class ServicesLoaded extends PartnerRegisterState {
  final List<ApplicationServiceEntity> services;

  const ServicesLoaded({required this.services});
}

class ServicesError extends PartnerRegisterState {
  final String message;

  const ServicesError({required this.message});
}

class PartnerRegisterSuccess extends PartnerRegisterState {
  final String message;
  final Map<String, dynamic>? responseData;

  const PartnerRegisterSuccess({
    required this.message,
    this.responseData,
  });
}

class PartnerRegisterError extends PartnerRegisterState {
  final String message;

  const PartnerRegisterError({required this.message});
}
