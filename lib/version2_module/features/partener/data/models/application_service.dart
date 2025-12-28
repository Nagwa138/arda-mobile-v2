class ApplicationService {
  final String id;
  final String serviceName;

  ApplicationService({
    required this.id,
    required this.serviceName,
  });

  factory ApplicationService.fromJson(Map<String, dynamic> json) {
    return ApplicationService(
      id: json['id'] ?? '',
      serviceName: json['serviceName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceName': serviceName,
    };
  }
}

class ApplicationServicesResponse {
  final int? statusCode;
  final String? message;
  final List<ApplicationService>? data;

  ApplicationServicesResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory ApplicationServicesResponse.fromJson(Map<String, dynamic> json) {
    return ApplicationServicesResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List)
              .map((item) => ApplicationService.fromJson(item))
              .toList()
          : null,
    );
  }
}
