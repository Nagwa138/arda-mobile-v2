class ChangePasswordRequest {
  final String email;
  final String newPassword;

  ChangePasswordRequest({
    required this.email,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'Email': email,
      'NewPassword': newPassword,
    };
  }
}

class ChangePasswordResponse {
  final bool isSuccess;
  final String message;

  ChangePasswordResponse({
    required this.isSuccess,
    required this.message,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
