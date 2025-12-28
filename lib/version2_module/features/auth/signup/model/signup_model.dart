class SignupRequest {
  final String userName;
  final String email;
  final String password;
  final String confirmPassword;
  final String phoneNumber;

   int? gender = 0;
   String? firebaseToken;
   String? nationality;

  SignupRequest({
    required this.userName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,

     this.gender,
     this.firebaseToken,
     this.nationality,

  });

  Map<String, dynamic> toJson() {
    return {
      'UserName': userName,
      'Email': email,
      'Password': password,
      'ConfirmPassword': confirmPassword,
      'PhoneNumber': phoneNumber,
      'Gender': gender,
      'FirebaseToken': firebaseToken,
      'Nationality': nationality,

    };
  }
}

class SignupResponse {
  final bool isSuccess;
  final String message;
  final String? token;
  final Map<String, dynamic>? userData;

  SignupResponse({
    required this.isSuccess,
    required this.message,
    this.token,
    this.userData,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'] ?? '',
      token: json['token'],
      userData: json['userData'],
    );
  }
}
