import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../data/datasources/partner_register_remote_datasource.dart';
import '../../data/repositories/partner_register_repository_impl.dart';
import '../../domain/entities/partner_register_entity.dart';
import '../../domain/usecases/register_partner_usecase.dart';
import 'partner_register_state.dart';

class PartnerRegisterCubit extends Cubit<PartnerRegisterState> {
  late final RegisterPartnerUseCase _registerPartnerUseCase;
  late final GetApplicationServicesUseCase _getApplicationServicesUseCase;
  late final GetGovernmentsUseCase _getGovernmentsUseCase;

  List<ApplicationServiceEntity> _services = [];
  ApplicationServiceEntity? _selectedService;
  List<GovernmentEntity> _governments = [];
  GovernmentEntity? _selectedGovernment;

  PartnerRegisterCubit() : super(PartnerRegisterInitial()) {
    _initializeUseCases();
  }

  void _initializeUseCases() {
    final remoteDataSource = PartnerRegisterRemoteDataSourceImpl(
      client: http.Client(),
    );
    final repository = PartnerRegisterRepositoryImpl(
      remoteDataSource: remoteDataSource,
    );
    _registerPartnerUseCase = RegisterPartnerUseCase(repository: repository);
    _getApplicationServicesUseCase =
        GetApplicationServicesUseCase(repository: repository);
    _getGovernmentsUseCase = GetGovernmentsUseCase(repository: repository);
  }

  List<ApplicationServiceEntity> get services => _services;
  ApplicationServiceEntity? get selectedService => _selectedService;
  List<GovernmentEntity> get governments => _governments;
  GovernmentEntity? get selectedGovernment => _selectedGovernment;

  Future<void> getApplicationServices() async {
    try {
      print('🔄 Cubit: Starting to load application services...');
      emit(ServicesLoading());

      final services = await _getApplicationServicesUseCase();
      _services = services;

      print('✅ Cubit: Services loaded successfully!');
      print('📊 Cubit: Number of services: ${services.length}');
      for (var service in services) {
        print('   - ${service.serviceName} (ID: ${service.id})');
      }

      emit(ServicesLoaded(services: services));
    } catch (e) {
      print('❌ Cubit: Error loading services: $e');
      emit(ServicesError(message: e.toString()));
    }
  }

  void selectService(ApplicationServiceEntity service) {
    print(
        '🎯 Cubit: Service selected - ${service.serviceName} (ID: ${service.id})');
    _selectedService = service;
    emit(ServicesLoaded(services: _services));
  }

  Future<void> getGovernments() async {
    try {
      print('🔄 Cubit: Starting to load governments...');

      final governments = await _getGovernmentsUseCase();
      _governments = governments;

      print('✅ Cubit: Governments loaded successfully!');
      print('🏛️ Cubit: Number of governments: ${governments.length}');
      for (var government in governments) {
        print('   - ${government.name} (ID: ${government.id})');
      }

      emit(ServicesLoaded(services: _services));
    } catch (e) {
      print('❌ Cubit: Error loading governments: $e');
      emit(ServicesError(message: e.toString()));
    }
  }

  void selectGovernment(GovernmentEntity government) {
    print(
        '🏛️ Cubit: Government selected - ${government.name} (ID: ${government.id})');
    _selectedGovernment = government;
    emit(ServicesLoaded(services: _services));
  }

  Future<void> registerPartner({
    required String email,
    required String companyName,
    String? applicantName,
    String? governmentId,
    String? addressLink,
    String? websiteLink,
    String? companyLogo,
    String? tripType,
  }) async {
    try {
      print('🚀 Cubit: Starting partner registration...');
      print('📝 Cubit: Registration Data:');
      print('   Email: $email');
      print('   Company Name: $companyName');
      print('   Applicant Name: $applicantName');
      print('   Government ID: $governmentId');
      print('   Address Link: "$addressLink" (temporary placeholder)');
      print('   Website Link: $websiteLink');
      print(
          '   Selected Service: ${_selectedService?.serviceName} (${_selectedService?.id})');
      print(
          '   Selected Government: ${_selectedGovernment?.name} (${_selectedGovernment?.id})');
      print('   Company Logo: $companyLogo');
      print('   Trip Type: $tripType');

      emit(PartnerRegisterLoading());

      final entity = PartnerRegisterEntity(
        email: email,
        companyName: companyName,
        applicantName: applicantName,
        governmentId: _selectedGovernment?.id ?? governmentId,
        addressLink: addressLink,
        websiteLink: websiteLink,
        serviceId: _selectedService?.id,
        companyLogo: companyLogo,
        tripType: tripType,
      );

      print('🔄 Cubit: Calling registration use case...');
      final success = await _registerPartnerUseCase(entity);
      print('📥 Cubit: Registration result: $success');

      if (success) {
        print('✅ Cubit: Registration successful!');
        emit(const PartnerRegisterSuccess(
            message: 'Partner registered successfully, please wait for approval'));
      } else {
        print('❌ Cubit: Registration failed - API returned false');
        emit(const PartnerRegisterError(message: 'Registration failed'));
      }
    } catch (e) {
      print('💥 Cubit: Registration exception: $e');
      print('💥 Cubit: Exception type: ${e.runtimeType}');
      emit(PartnerRegisterError(message: e.toString()));
    }
  }
}
