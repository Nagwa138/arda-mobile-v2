import 'dart:io';
import 'package:PassPort/models/partner/ServicesModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../data/repositories/service_submission_repository_impl.dart';
import '../../data/datasources/service_submission_remote_datasource.dart';

part 'service_submission_state.dart';

class ServiceSubmissionCubit extends Cubit<ServiceSubmissionState> {
  final ServiceSubmissionRepository repository;

  ServiceSubmissionCubit({required this.repository})
      : super(ServiceSubmissionInitial());

  Future<void> submitService(
      String serviceType, Map<String, dynamic> formData) async {
    emit(ServiceSubmissionLoading());

    try {
      print('🚀 === SERVICE SUBMISSION CUBIT DEBUG ===');
      print('📤 Service Type: $serviceType');
      print('📤 Form Data Keys: ${formData.keys.toList()}');

      final result = await repository.submitService(serviceType, formData);

      if (result['success'] == true) {
        emit(ServiceSubmissionSuccess(
            result['message'] ?? 'Service submitted successfully'));
      } else {
        emit(ServiceSubmissionError(
            result['error'] ?? 'Failed to submit service'));
      }
    } catch (e) {
      print('❌ Error in ServiceSubmissionCubit: $e');
      emit(ServiceSubmissionError('Unexpected error: ${e.toString()}'));
    }
  }

  Future<List<String>> uploadImages(List<String> imagePaths) async {
    try {
      // Convert string paths to File objects
      final files = imagePaths
          .where((path) => path.startsWith('/'))
          .map((path) => File(path))
          .where((file) => file.existsSync())
          .toList();

      return await repository.uploadImages(files);
    } catch (e) {
      print('❌ Error uploading images: $e');
      return [];
    }
  }

  Future<String> uploadSingleImage(String imagePath) async {
    try {
      if (imagePath.startsWith('/')) {
        final file = File(imagePath);
        if (await file.exists()) {
          return await repository.uploadSingleImage(file);
        }
      }
      return imagePath; // Return as-is if it's already a URL
    } catch (e) {
      print('❌ Error uploading single image: $e');
      return '';
    }
  }

  void resetState() {
    emit(ServiceSubmissionInitial());
  }

  Future<void> getAccommodationServiceDetails(String id) async {
    emit(GetServiceDetailsLoading());
    try {
      final serviceDetail =
          await repository.getAccommodationServices(id.toString());
      emit(GetServiceDetailsSuccess(serviceDetail));
    } catch (e) {
      print('❌ Error fetching service details: $e');
      emit(GetServiceDetailsError('Failed to fetch service details'));
    }
  }
}
