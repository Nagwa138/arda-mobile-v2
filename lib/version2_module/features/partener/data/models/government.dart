class Government {
  final String id;
  final String name;

  Government({
    required this.id,
    required this.name,
  });

  factory Government.fromJson(Map<String, dynamic> json) {
    return Government(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class GovernmentsResponse {
  final int? statusCode;
  final String? message;
  final List<Government>? data;

  GovernmentsResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  factory GovernmentsResponse.fromJson(Map<String, dynamic> json) {
    return GovernmentsResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List)
              .map((item) => Government.fromJson(item))
              .toList()
          : null,
    );
  }
}
