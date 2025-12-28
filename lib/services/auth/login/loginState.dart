abstract class LoginStates {}

final class LoginInitial extends LoginStates {}

final class ChangePasswordIcon extends LoginStates {}

final class ChangeColorBtnSucsses extends LoginStates {}

final class LoginLoading extends LoginStates {}

final class LoginSuccess extends LoginStates {
  final int userType;
  LoginSuccess(this.userType);
}

final class LoginError extends LoginStates {
  final String error;
  LoginError(this.error);
}

final class ForgotPasswordLoading extends LoginStates {}

final class ForgotPasswordSuccess extends LoginStates {
  final String message;
  ForgotPasswordSuccess(this.message);
}

final class ForgotPasswordError extends LoginStates {
  final String error;
  ForgotPasswordError(this.error);
}

final class VerifyCodeLoading extends LoginStates {}

final class VerifyCodeSuccess extends LoginStates {}

final class VerifyCodeError extends LoginStates {
  final String error;
  VerifyCodeError(this.error);
}

final class ChangePasswordLoading extends LoginStates {}

final class ChangePasswordSuccess extends LoginStates {
  final String message;
  ChangePasswordSuccess(this.message);
}

final class ChangePasswordError extends LoginStates {
  final String error;
  ChangePasswordError(this.error);
}
