import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:PassPort/consts/api/api.dart';
import '../models/partner_register_request.dart';
import '../models/partner_register_response.dart';
import '../models/application_service.dart';
import '../models/government.dart';

abstract class PartnerRegisterRemoteDataSource {
  Future<PartnerRegisterResponse> registerPartner(
      PartnerRegisterRequest request);
  Future<ApplicationServicesResponse> getApplicationServices();
  Future<GovernmentsResponse> getGovernments();
}

class PartnerRegisterRemoteDataSourceImpl
    implements PartnerRegisterRemoteDataSource {
  final http.Client client;

  PartnerRegisterRemoteDataSourceImpl({required this.client});

  @override
  Future<PartnerRegisterResponse> registerPartner(
      PartnerRegisterRequest request) async {
    try {
      print('🚀 === PARTNER REGISTRATION DEBUG ===');
      print('📤 Request URL: ${Api.BASE_URL}/api/Accounts/Partener/register');
      print('📤 Request Headers: Content-Type: application/json');
      print('📤 Request Body (JSON): ${jsonEncode(request.toJson())}');
      print('📤 Request Form Fields: ${request.toFormFields()}');

      // Use multipart form data instead of JSON
      var multipartRequest = http.MultipartRequest(
        'POST',
        Uri.parse('${Api.BASE_URL}/api/Accounts/Partener/register'),
      );

      // Add form fields
      multipartRequest.fields.addAll(request.toFormFields());
      print('📤 Multipart Fields: ${multipartRequest.fields}');

      // Send the request
      final streamedResponse = await multipartRequest.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('📥 Response Status Code: ${response.statusCode}');
      print('📥 Response Headers: ${response.headers}');
      print('📥 Response Body: ${response.body}');
      print('📥 Response Body Length: ${response.body.length}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('✅ Response Data Parsed: $data');
        // Add statusCode to the response data since the API doesn't include it
        data['statusCode'] = response.statusCode;
        return PartnerRegisterResponse.fromJson(data);
      } else {
        print('❌ Registration Failed!');
        print('❌ Status Code: ${response.statusCode}');
        print('❌ Error Response Body: ${response.body}');
        throw Exception('Failed to register partner: ${response.statusCode}');
      }
    } catch (e) {
      print('💥 Exception occurred: $e');
      print('💥 Exception type: ${e.runtimeType}');
      throw Exception('Network error: $e');
    }
  }

  @override
  Future<ApplicationServicesResponse> getApplicationServices() async {
    try {
      print('🔍 === APPLICATION SERVICES DEBUG ===');
      print('📤 Request URL: ${Api.BASE_URL}/api/ApplicationServices');
      print('📤 Request Method: GET');
      print('📤 Request Headers: Content-Type: application/json');

      final response = await client.get(
        Uri.parse('${Api.BASE_URL}/api/ApplicationServices'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print('📥 Response Status Code: ${response.statusCode}');
      print('📥 Response Headers: ${response.headers}');
      print('📥 Response Body: ${response.body}');
      print('📥 Response Body Length: ${response.body.length}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('✅ Response Data Parsed: $data');
        return ApplicationServicesResponse.fromJson(data);
      } else {
        print('❌ Get Services Failed!');
        print('❌ Status Code: ${response.statusCode}');
        print('❌ Error Response Body: ${response.body}');
        throw Exception(
            'Failed to get application services: ${response.statusCode}');
      }
    } catch (e) {
      print('💥 Exception occurred: $e');
      print('💥 Exception type: ${e.runtimeType}');
      throw Exception('Network error: $e');
    }
  }

  @override
  Future<GovernmentsResponse> getGovernments() async {
    try {
      print('🏛️ === GOVERNMENTS DEBUG ===');
      print('📤 Request URL: ${Api.BASE_URL}/api/Governments');
      print('📤 Request Method: GET');
      print('📤 Request Headers: Content-Type: application/json');

      final response = await client.get(
        Uri.parse('${Api.BASE_URL}/api/Governments'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print('📥 Response Status Code: ${response.statusCode}');
      print('📥 Response Headers: ${response.headers}');
      print('📥 Response Body: ${response.body}');
      print('📥 Response Body Length: ${response.body.length}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('✅ Response Data Parsed: $data');
        return GovernmentsResponse.fromJson(data);
      } else {
        print('❌ Get Governments Failed!');
        print('❌ Status Code: ${response.statusCode}');
        print('❌ Error Response Body: ${response.body}');
        throw Exception('Failed to get governments: ${response.statusCode}');
      }
    } catch (e) {
      print('💥 Exception occurred: $e');
      print('💥 Exception type: ${e.runtimeType}');
      throw Exception('Network error: $e');
    }
  }
}
