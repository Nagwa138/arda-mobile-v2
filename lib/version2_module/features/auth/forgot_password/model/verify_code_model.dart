class VerifyCodeRequest {
  final String email;
  final String verificationCode;

  VerifyCodeRequest({
    required this.email,
    required this.verificationCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'Email': email,
      'VerificationCode': verificationCode,
    };
  }
}

class VerifyCodeResponse {
  final bool isSuccess;
  final String message;
  final String? token;

  VerifyCodeResponse({
    required this.isSuccess,
    required this.message,
    this.token,
  });

  factory VerifyCodeResponse.fromJson(Map<String, dynamic> json) {
    return VerifyCodeResponse(
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'] ?? '',
      token: json['token'],
    );
  }
}

class ResendCodeRequest {
  final String email;

  ResendCodeRequest({
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'Email': email,
    };
  }
}
