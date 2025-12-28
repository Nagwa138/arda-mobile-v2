abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final String message;
  final String? token;

  SignupSuccess({required this.message, this.token});
}

class SignupError extends SignupState {
  final String error;

  SignupError({required this.error});
}

class SignupPasswordVisibilityChanged extends SignupState {}

class SignupPasswordLabelChanged extends SignupState {}

class SignupValidationChanged extends SignupState {
  final bool isValid;

  SignupValidationChanged({required this.isValid});
}
