import 'package:equatable/equatable.dart';
import '../models/partner_service_item.dart';

abstract class PartnerServicesState extends Equatable {
  const PartnerServicesState();
  @override
  List<Object?> get props => [];
}

class PartnerServicesInitial extends PartnerServicesState {}

class PartnerServicesLoading extends PartnerServicesState {}

class PartnerServicesLoaded extends PartnerServicesState {
  final List<dynamic> items;
  final PartnerServiceType type;
  final String query;
  const PartnerServicesLoaded({
    required this.items,
    required this.type,
    required this.query,
  });

  @override
  List<Object?> get props => [items, type, query];
}

class PartnerServicesError extends PartnerServicesState {
  final String message;
  const PartnerServicesError(this.message);
  @override
  List<Object?> get props => [message];
}
