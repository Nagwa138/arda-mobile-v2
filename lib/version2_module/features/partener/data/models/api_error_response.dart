class ApiErrorResponse {
  final int statusCode;
  final String message;

  ApiErrorResponse({
    required this.statusCode,
    required this.message,
  });

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) {
    return ApiErrorResponse(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
    };
  }

  @override
  String toString() => 'ApiError($statusCode): $message';
}

class ApiException implements Exception {
  final ApiErrorResponse error;

  ApiException(this.error);

  @override
  String toString() => error.toString();
}
