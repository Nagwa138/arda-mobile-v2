abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;
  final String? token;
  final int? userType;

  LoginSuccess({required this.message, this.token, this.userType});
}

class LoginError extends LoginState {
  final String error;

  LoginError({required this.error});
}

class LoginPasswordVisibilityChanged extends LoginState {}

class LoginValidationChanged extends LoginState {
  final bool isValid;

  LoginValidationChanged({required this.isValid});
}
