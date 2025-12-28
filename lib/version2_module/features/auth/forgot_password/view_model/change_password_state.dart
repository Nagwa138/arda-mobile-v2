abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {
  final String message;

  ChangePasswordSuccess({required this.message});
}

class ChangePasswordError extends ChangePasswordState {
  final String error;

  ChangePasswordError({required this.error});
}

class ChangePasswordValidationChanged extends ChangePasswordState {
  final bool isValid;

  ChangePasswordValidationChanged({required this.isValid});
}

class PasswordVisibilityChanged extends ChangePasswordState {
  final bool isOldPasswordVisible;
  final bool isNewPasswordVisible;
  

  PasswordVisibilityChanged({
    required this.isOldPasswordVisible,
    required this.isNewPasswordVisible,
  
  });
}
