import 'package:PassPort/consts/api/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final Dio _dio;
  final String _baseUrl = '${Api.API_URL}';
  final _storage = const FlutterSecureStorage();

  ApiService(this._dio) {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  Future<dynamic> get({required String endPoint}) async {
    final token = await _storage.read(key: 'token');
    _dio.options.headers['Authorization'] = 'Bearer $token';
    var response = await _dio.get('$_baseUrl$endPoint');
    return response.data;
  }
}
