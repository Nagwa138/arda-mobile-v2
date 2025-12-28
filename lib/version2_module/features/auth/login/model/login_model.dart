class LoginRequest {
  final String email;
  final String password;
  String? firebaseToken;

  LoginRequest({
    required this.email,
    required this.password,
    this.firebaseToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'Email': email,
      'Password': password,
      'FirebaseToken': firebaseToken,
    };
  }
}

class LoginResponse {
  final bool isSuccess;
  final String message;
  final UserData? data;

  LoginResponse({
    required this.isSuccess,
    required this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      isSuccess: json['statusCode'] == 200,
      message: json['message'] ?? '',
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }
}

class UserData {
  final String? userName;
  final String? email;
  final String? token;
  final int? userType;

  UserData({
    this.userName,
    this.email,
    this.token,
    this.userType,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userName: json['userName'],
      email: json['email'],
      token: json['token'],
      userType: json['userType'],
    );
  }
}
