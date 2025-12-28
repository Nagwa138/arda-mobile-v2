import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkLogger {
  static bool enabled = true;

  static void logRequest(
    String method,
    Uri url, {
    Map<String, String>? headers,
    Object? body,
  }) {
    if (!enabled) return;
    debugPrint('➡️  $method ${url.toString()}');
    if (headers != null && headers.isNotEmpty) {
      final redacted = Map<String, String>.from(headers);
      if (redacted.containsKey('Authorization')) {
        redacted['Authorization'] = 'Bearer ••••';
      }
      debugPrint('Headers: ${jsonEncode(redacted)}');
    }
    if (body != null) {
      try {
        final text = body is String ? body : jsonEncode(body);
        debugPrint('Body: ${_truncate(text)}');
      } catch (_) {
        debugPrint('Body: ${body.toString()}');
      }
    }
  }

  static void logResponse(http.Response response) {
    if (!enabled) return;
    final url = response.request?.url.toString() ?? '';
    debugPrint('⬅️  [${response.statusCode}] $url');
    debugPrint('Response: ${_truncate(response.body)}');
  }

  static String _truncate(String value, [int max = 1200]) {
    if (value.length <= max) return value;
    return value.substring(0, max) + '… (${value.length} chars)';
  }
}
