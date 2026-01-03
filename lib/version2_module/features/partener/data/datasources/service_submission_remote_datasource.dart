import 'dart:convert';
import 'dart:io';
import 'package:PassPort/models/partner/acommdation_model.dart';
import 'package:PassPort/screens/partner/profile/profileLanding.dart';
import 'package:http/http.dart' as http;
import 'package:PassPort/consts/api/api.dart';
import '../models/add_accommodation_request.dart';
import '../models/add_activity_request.dart';
import '../models/add_product_request.dart';

abstract class ServiceSubmissionRemoteDataSource {
  Future<Map<String, dynamic>> submitAccommodation(
      AddAccommodationRequest request);
  Future<Map<String, dynamic>> submitActivity(AddActivityRequest request);
  Future<Map<String, dynamic>> submitProduct(AddProductRequest request);
  Future<List<String>> uploadImages(List<File> images);
  Future<String> uploadSingleImage(File image);
  Future<AccommodationModel> getAccommodationServices(String id);
}

class ServiceSubmissionRemoteDataSourceImpl
    implements ServiceSubmissionRemoteDataSource {
  final http.Client client;

  ServiceSubmissionRemoteDataSourceImpl({required this.client});

  @override
  Future<Map<String, dynamic>> submitAccommodation(
      AddAccommodationRequest request) async {
    try {
      print('🚀 === ACCOMMODATION SUBMISSION DEBUG ===');
      print('📤 Request URL: ${Api.BASE_URL}/api/Accomodation');
      print('📤 Request Body: ${jsonEncode(request.toJson())}');

      final response = await client.post(
        Uri.parse('${Api.BASE_URL}/api/Accomodation'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      print('📥 Response Status: ${response.statusCode}');
      print('📥 Response Body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': responseData,
          'message':
              responseData['message'] ?? 'Accommodation added successfully',
        };
      } else {
        return {
          'success': false,
          'error': responseData['message'] ?? 'Failed to add accommodation',
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      print('❌ Error in submitAccommodation: $e');
      return {
        'success': false,
        'error': 'Network error: ${e.toString()}',
      };
    }
  }

  @override
  Future<Map<String, dynamic>> submitActivity(
      AddActivityRequest request) async {
    try {
      print('🚀 === ACTIVITY SUBMISSION DEBUG ===');
      print('📤 Request URL: ${Api.BASE_URL}/api/Companies/AddPartnerActivity');
      print('📤 Request Body: ${jsonEncode(request.toJson())}');

      final response = await client.post(
        Uri.parse('${Api.BASE_URL}/api/Companies/AddPartnerActivity'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      print('📥 Response Status: ${response.statusCode}');
      print('📥 Response Body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': responseData,
          'message': responseData['message'] ?? 'Activity added successfully',
        };
      } else {
        return {
          'success': false,
          'error': responseData['message'] ?? 'Failed to add activity',
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      print('❌ Error in submitActivity: $e');
      return {
        'success': false,
        'error': 'Network error: ${e.toString()}',
      };
    }
  }

  @override
  Future<Map<String, dynamic>> submitProduct(AddProductRequest request) async {
    try {
      print('🚀 === PRODUCT SUBMISSION DEBUG ===');
      print('📤 Request URL: ${Api.BASE_URL}/api/Companies/AddPartnerProduct');
      print('📤 Request Body: ${jsonEncode(request.toJson())}');

      final response = await client.post(
        Uri.parse('${Api.BASE_URL}/api/Companies/AddPartnerProduct'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      print('📥 Response Status: ${response.statusCode}');
      print('📥 Response Body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': responseData,
          'message': responseData['message'] ?? 'Product added successfully',
        };
      } else {
        return {
          'success': false,
          'error': responseData['message'] ?? 'Failed to add product',
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      print('❌ Error in submitProduct: $e');
      return {
        'success': false,
        'error': 'Network error: ${e.toString()}',
      };
    }
  }

  @override
  Future<List<String>> uploadImages(List<File> images) async {
    List<String> uploadedUrls = [];

    for (File image in images) {
      try {
        final url = await uploadSingleImage(image);
        uploadedUrls.add(url);
      } catch (e) {
        print('❌ Error uploading image: $e');
        // Continue with other images even if one fails
      }
    }

    return uploadedUrls;
  }

  @override
  Future<String> uploadSingleImage(File image) async {
    try {
      print('🚀 === IMAGE UPLOAD DEBUG ===');
      print(
          '📤 Upload URL: ${Api.BASE_URL}/api/Accomodation/Accomodation/UploadImage');

      var multipartRequest = http.MultipartRequest(
        'POST',
        Uri.parse('${Api.BASE_URL}/api/Accomodation/Accomodation/UploadImage'),
      );

      // Add the image file
      multipartRequest.files.add(
        await http.MultipartFile.fromPath(
          'file',
          image.path,
        ),
      );

      final streamedResponse = await multipartRequest.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('📥 Upload Response Status: ${response.statusCode}');
      print('📥 Upload Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['data'] ?? responseData['url'] ?? '';
      } else {
        throw Exception('Failed to upload image: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error in uploadSingleImage: $e');
      throw Exception('Image upload failed: ${e.toString()}');
    }
  }

  Future<AccommodationModel> getAccommodationServices(String id) async {
    try {
      print('🏨 === GET ACCOMMODATION SERVICES DEBUG ===');
      final token = await storage.read(key: "token");
      print(
          '📤 Request URL: ${Api.API_URL}Accomodation/Admin/GetServiceById?id=$id');
      print('📤 Accommodation ID: $id');

      final response = await client.get(
        Uri.parse('${Api.API_URL}Accomodation/Admin/GetServiceById?id=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('📥 Response Status Code: ${response.statusCode}');
      print('📥 Response Headers: ${response.headers}');
      print('📥 Response Body: ${response.body}');
      print('📥 Response Body Length: ${response.body.length}');
      print('📥 Response Body Type: ${response.body.runtimeType}');

      // شوف إيه اللي راجع
      if (response.body.isEmpty) {
        print('⚠️ Response body is EMPTY!');
      }

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          throw Exception('Response body is empty');
        }

        final data = jsonDecode(response.body);
        print('✅ Response Data Parsed: $data');

        return AccommodationModel.fromJson(data); // 👈 استخدم الـ model الجديد
      } else {
        print('❌ Get Accommodation Services Failed!');
        print('❌ Status Code: ${response.statusCode}');
        print('❌ Error Response Body: ${response.body}');
        throw Exception(
            'Failed to get accommodation services: ${response.statusCode}');
      }
    } catch (e) {
      print('💥 Exception occurred: $e');
      print('💥 Exception type: ${e.runtimeType}');
      print('💥 Stack trace: ${StackTrace.current}');
      rethrow;
    }
  }
}
