class PartnerRegisterResponse {
  final int? statusCode;
  final String? message;
  final bool? success;
  final String? userName;
  final String? email;
  final String? token;
  final int? userType;
  final int? genralStatus;

  PartnerRegisterResponse({
    this.statusCode,
    this.message,
    this.success,
    this.userName,
    this.email,
    this.token,
    this.userType,
    this.genralStatus,
  });

  factory PartnerRegisterResponse.fromJson(Map<String, dynamic> json) {
    return PartnerRegisterResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      success: json['success'],
      userName: json['userName'],
      email: json['email'],
      token: json['token'],
      userType: json['userType'],
      genralStatus: json['genralStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'success': success,
      'userName': userName,
      'email': email,
      'token': token,
      'userType': userType,
      'genralStatus': genralStatus,
    };
  }
}
