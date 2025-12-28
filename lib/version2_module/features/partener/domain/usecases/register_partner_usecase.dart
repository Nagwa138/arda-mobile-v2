import '../entities/partner_register_entity.dart';
import '../repositories/partner_register_repository.dart';

class RegisterPartnerUseCase {
  final PartnerRegisterRepository repository;

  RegisterPartnerUseCase({required this.repository});

  Future<bool> call(PartnerRegisterEntity entity) async {
    return await repository.registerPartner(entity);
  }
}

class GetApplicationServicesUseCase {
  final PartnerRegisterRepository repository;

  GetApplicationServicesUseCase({required this.repository});

  Future<List<ApplicationServiceEntity>> call() async {
    return await repository.getApplicationServices();
  }
}

class GetGovernmentsUseCase {
  final PartnerRegisterRepository repository;

  GetGovernmentsUseCase({required this.repository});

  Future<List<GovernmentEntity>> call() async {
    return await repository.getGovernments();
  }
}
