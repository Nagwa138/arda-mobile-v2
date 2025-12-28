import 'dart:io';
import 'package:PassPort/models/partner/ServicesModel.dart';
import 'package:PassPort/models/partner/acommdation_model.dart';

import '../datasources/service_submission_remote_datasource.dart';
import '../models/add_accommodation_request.dart';
import '../models/add_activity_request.dart';
import '../models/add_product_request.dart';

abstract class ServiceSubmissionRepository {
  Future<Map<String, dynamic>> submitService(
      String serviceType, Map<String, dynamic> formData);
  Future<List<String>> uploadImages(List<File> images);
  Future<String> uploadSingleImage(File image);
  Future<AccommodationModel> getAccommodationServices(String id);
}

class ServiceSubmissionRepositoryImpl implements ServiceSubmissionRepository {
  final ServiceSubmissionRemoteDataSource remoteDataSource;

  ServiceSubmissionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Map<String, dynamic>> submitService(
      String serviceType, Map<String, dynamic> formData) async {
    try {
      switch (serviceType.toLowerCase()) {
        case 'accommodation':
        case 'accomodation':
          return await _submitAccommodation(formData);
        case 'activity':
        case 'activities':
          return await _submitActivity(formData);
        case 'product':
        case 'products':
          return await _submitProduct(formData);
        default:
          return {
            'success': false,
            'error': 'Unsupported service type: $serviceType',
          };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Repository error: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> _submitAccommodation(
      Map<String, dynamic> formData) async {
    try {
      // Handle image uploads first
      List<String> coverPhotoUrls = [];
      List<String> serverImageUrls = [];

      // Upload cover photo
      if (formData['coverPhotoName'] != null) {
        final coverPhotoData = formData['coverPhotoName'];
        if (coverPhotoData is List && coverPhotoData.isNotEmpty) {
          // Convert string paths to File objects and upload
          for (String imagePath in coverPhotoData) {
            if (imagePath.startsWith('/')) {
              final file = File(imagePath);
              if (await file.exists()) {
                final uploadedUrl = await uploadSingleImage(file);
                coverPhotoUrls.add(uploadedUrl);
              }
            } else {
              // If it's already a URL, use it directly
              coverPhotoUrls.add(imagePath);
            }
          }
        }
      }

      // Upload server images
      if (formData['serverImagesName'] != null) {
        final serverImagesData = formData['serverImagesName'];
        if (serverImagesData is List && serverImagesData.isNotEmpty) {
          for (String imagePath in serverImagesData) {
            if (imagePath.startsWith('/')) {
              final file = File(imagePath);
              if (await file.exists()) {
                final uploadedUrl = await uploadSingleImage(file);
                serverImageUrls.add(uploadedUrl);
              }
            } else {
              // If it's already a URL, use it directly
              serverImageUrls.add(imagePath);
            }
          }
        }
      }

      // Create accommodation request
      final request = AddAccommodationRequest(
        accomodationTypeId: formData['accomodationTypeId'] ?? 'default-type-id',
        coverPhotoName: coverPhotoUrls.isNotEmpty ? coverPhotoUrls.first : '',
        serviceName: formData['serviceName'] ?? '',
        address: formData['address'] ?? '',
        city: formData['city'] ?? '',
        government: formData['government'] ?? '',
        addressLink: formData['addressLink'] ?? '',
        roomsType: _mapRoomsType(formData['roomsType'] ?? []),
        serviceDesc: formData['serviceDetails'] ?? '',
        serverImagesName: serverImageUrls,
        website: formData['website'] ?? '',
        officialPhone: formData['officialPhone'] ?? '',
        language: formData['language'] ?? 'en',
        amenityId: _parseCommaSeparatedIds(formData['amenityId']),
        specialId: _parseCommaSeparatedIds(formData['specialId']),
      );

      return await remoteDataSource.submitAccommodation(request);
    } catch (e) {
      return {
        'success': false,
        'error': 'Accommodation submission error: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> _submitActivity(
      Map<String, dynamic> formData) async {
    try {
      // Handle image upload
      String imageUrl = '';
      if (formData['image'] != null) {
        final imageData = formData['image'];
        if (imageData is List && imageData.isNotEmpty) {
          final imagePath = imageData.first;
          if (imagePath.startsWith('/')) {
            final file = File(imagePath);
            if (await file.exists()) {
              imageUrl = await uploadSingleImage(file);
            }
          } else {
            imageUrl = imagePath;
          }
        }
      }

      // Create activity request
      final request = AddActivityRequest(
        name: formData['name'] ?? '',
        providerName: formData['providerName'] ?? '',
        description: formData['description'] ?? '',
        durationInHours:
            int.tryParse(formData['durationInHours']?.toString() ?? '0') ?? 0,
        pricePerPerson:
            double.tryParse(formData['pricePerPerson']?.toString() ?? '0.0') ??
                0.0,
        activityLocation: formData['activityLocation'] ?? '',
        workTimes: formData['workTimes'] ?? '',
        whatsIncluded: formData['whatsIncluded'] ?? '',
        rulesAndCancellationPolicy:
            formData['rulesAndCancellationPolicy'] ?? '',
        importantInformation: formData['importantInformation'],
        image: imageUrl,
      );

      return await remoteDataSource.submitActivity(request);
    } catch (e) {
      return {
        'success': false,
        'error': 'Activity submission error: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> _submitProduct(
      Map<String, dynamic> formData) async {
    try {
      // Create product request
      final request = AddProductRequest(
        name: formData['name'] ?? '',
        description: formData['description'] ?? '',
        price: double.tryParse(formData['price']?.toString() ?? '0.0') ?? 0.0,
        categoryId: formData['categoryId'] ??
            '00000005-7df5-4947-ac47-e05ea89d21e4', // Default to Others
        isDeliveryAvailable: formData['isDeliveryAvailable'] ?? false,
        shippingCost: formData['shippingCost'] != null
            ? double.tryParse(formData['shippingCost'].toString())
            : null,
        location: formData['location'] ?? '',
        rulesAndCancellationPolicy:
            formData['rulesAndCancellationPolicy'] ?? '',
        importantInformation: formData['importantInformation'],
      );

      return await remoteDataSource.submitProduct(request);
    } catch (e) {
      return {
        'success': false,
        'error': 'Product submission error: ${e.toString()}',
      };
    }
  }

  @override
  Future<List<String>> uploadImages(List<File> images) async {
    return await remoteDataSource.uploadImages(images);
  }

  @override
  Future<String> uploadSingleImage(File image) async {
    return await remoteDataSource.uploadSingleImage(image);
  }

  List<String> _parseCommaSeparatedIds(dynamic value) {
    if (value == null || value.toString().isEmpty) {
      return [];
    }
    return value
        .toString()
        .split(',')
        .map((id) => id.trim())
        .where((id) => id.isNotEmpty)
        .toList();
  }

  List<RoomTypeModel> _mapRoomsType(dynamic roomsData) {
    if (roomsData is List) {
      return roomsData
          .map((room) => RoomTypeModel(
                roomType: room['room_type'] ?? '',
                count: room['count'] ?? 0,
                guestNum: room['guest_num'] ?? 0,
                priceIncludeBreakFast: room['price_include_breakfast'] ?? false,
                roomImage: List<String>.from(room['room_images'] ?? []),
                price: (room['price'] ?? 0.0).toDouble(),
              ))
          .toList();
    }
    return [];
  }

  Future<AccommodationModel> getAccommodationServices(String id) async {
    try {
      return await remoteDataSource.getAccommodationServices(id);
    } catch (e) {
      throw Exception('Failed to get accommodation services: $e');
    }
  }
}
