import '../entities/partner_register_entity.dart';

abstract class PartnerRegisterRepository {
  Future<bool> registerPartner(PartnerRegisterEntity entity);
  Future<List<ApplicationServiceEntity>> getApplicationServices();
  Future<List<GovernmentEntity>> getGovernments();
}
