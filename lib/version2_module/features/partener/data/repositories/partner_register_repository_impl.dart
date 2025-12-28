import '../../domain/entities/partner_register_entity.dart';
import '../../domain/repositories/partner_register_repository.dart';
import '../datasources/partner_register_remote_datasource.dart';
import '../models/partner_register_request.dart';

class PartnerRegisterRepositoryImpl implements PartnerRegisterRepository {
  final PartnerRegisterRemoteDataSource remoteDataSource;

  PartnerRegisterRepositoryImpl({required this.remoteDataSource});

  @override
  Future<bool> registerPartner(PartnerRegisterEntity entity) async {
    try {
      final request = PartnerRegisterRequest(
        email: entity.email,
        firebaseToken: entity.firebaseToken,
        partnerInformation: PartnerInformation(
          companyName: entity.companyName,
          applicantName: entity.applicantName,
          governmentId: entity.governmentId,
          addressLink: entity.addressLink,
          websiteLink: entity.websiteLink,
          serviceId: entity.serviceId,
          companyLogo: entity.companyLogo,
          tripType: entity.tripType,
        ),
      );

      final response = await remoteDataSource.registerPartner(request);
      // Check for success based on status code only since the API returns user data on success
      // The presence of a successful HTTP 200 response indicates successful registration
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<List<ApplicationServiceEntity>> getApplicationServices() async {
    try {
      final response = await remoteDataSource.getApplicationServices();
      return response.data
              ?.map((service) => ApplicationServiceEntity(
                    id: service.id,
                    serviceName: service.serviceName,
                  ))
              .toList() ??
          [];
    } catch (e) {
      throw Exception('Failed to get services: $e');
    }
  }

  @override
  Future<List<GovernmentEntity>> getGovernments() async {
    try {
      final response = await remoteDataSource.getGovernments();
      return response.data
              ?.map((government) => GovernmentEntity(
                    id: government.id,
                    name: government.name,
                  ))
              .toList() ??
          [];
    } catch (e) {
      throw Exception('Failed to get governments: $e');
    }
  }
}
