import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiConsumer {
  Future<Response> post(
      {required String uri, required rawData, String? token}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    // Debug logging for request
    print('🚀 === API POST REQUEST ===');
    print('📍 URL: $uri');
    print('📋 Headers: $headers');
    print('📦 Raw Data Type: ${rawData.runtimeType}');
    print('📦 Request Body: ${rawData is Map ? jsonEncode(rawData) : rawData}');
    print('🕒 Timestamp: ${DateTime.now()}');
    print('================================');

    http.Response response = await http.post(
      Uri.parse(uri),
      body: rawData is Map ? jsonEncode(rawData) : rawData,
      headers: headers,
    );

    // Debug logging for response
    print('📥 === API POST RESPONSE ===');
    print('📍 URL: $uri');
    print('🔢 Status Code: ${response.statusCode}');
    print('📋 Response Headers: ${response.headers}');
    print('📦 Response Body: ${response.body}');
    print('🕒 Timestamp: ${DateTime.now()}');
    print('================================');

    return response;
  }

  Future<Response> get({required String uri, String? token}) async {
    Map<String, String>? headers = token != null
        ? {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'}
        : null;

    // Debug logging for request
    print('🚀 === API GET REQUEST ===');
    print('📍 URL: $uri');
    print('📋 Headers: $headers');
    print('🕒 Timestamp: ${DateTime.now()}');
    print('===============================');

    http.Response response = await http.get(
      Uri.parse(uri),
      headers: headers,
    );

    // Debug logging for response
    print('📥 === API GET RESPONSE ===');
    print('📍 URL: $uri');
    print('🔢 Status Code: ${response.statusCode}');
    print('📋 Response Headers: ${response.headers}');
    print('📦 Response Body: ${response.body}');
    print('🕒 Timestamp: ${DateTime.now()}');
    print('===============================');

    return response;
  }

  Future<Response> delete(
      {required String uri,
      Map<String, dynamic>? rawData,
      String? token}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    // Debug logging for request
    print('🚀 === API DELETE REQUEST ===');
    print('📍 URL: $uri');
    print('📋 Headers: $headers');
    print('📦 Request Body: ${rawData != null ? jsonEncode(rawData) : "null"}');
    print('🕒 Timestamp: ${DateTime.now()}');
    print('==================================');

    http.Response response = await http.delete(
      Uri.parse(uri),
      body: rawData != null ? jsonEncode(rawData) : null,
      headers: headers,
    );

    // Debug logging for response
    print('📥 === API DELETE RESPONSE ===');
    print('📍 URL: $uri');
    print('🔢 Status Code: ${response.statusCode}');
    print('📋 Response Headers: ${response.headers}');
    print('📦 Response Body: ${response.body}');
    print('🕒 Timestamp: ${DateTime.now()}');
    print('==================================');

    return response;
  }

  put({required String uri, required rawData, String? token}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    // Debug logging for request
    print('🚀 === API PUT REQUEST ===');
    print('📍 URL: $uri');
    print('📋 Headers: $headers');
    print('📦 Raw Data Type: ${rawData.runtimeType}');
    print('📦 Request Body: ${rawData is Map ? jsonEncode(rawData) : rawData}');
    print('🕒 Timestamp: ${DateTime.now()}');
    print('==============================');

    http.Response response = await http.put(
      Uri.parse(uri),
      body: rawData is Map ? jsonEncode(rawData) : rawData,
      headers: headers,
    );

    // Debug logging for response
    print('📥 === API PUT RESPONSE ===');
    print('📍 URL: $uri');
    print('🔢 Status Code: ${response.statusCode}');
    print('📋 Response Headers: ${response.headers}');
    print('📦 Response Body: ${response.body}');
    print('🕒 Timestamp: ${DateTime.now()}');
    print('==============================');

    return response;
  }
}
