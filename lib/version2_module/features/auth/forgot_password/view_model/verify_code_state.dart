abstract class VerifyCodeState {}

class VerifyCodeInitial extends VerifyCodeState {}

class VerifyCodeLoading extends VerifyCodeState {}

class VerifyCodeSuccess extends VerifyCodeState {
  final String message;
  final String? token;

  VerifyCodeSuccess({required this.message, this.token});
}

class VerifyCodeError extends VerifyCodeState {
  final String error;

  VerifyCodeError({required this.error});
}

class VerifyCodeValidationChanged extends VerifyCodeState {
  final bool isValid;

  VerifyCodeValidationChanged({required this.isValid});
}

class ResendCodeLoading extends VerifyCodeState {}

class ResendCodeSuccess extends VerifyCodeState {
  final String message;

  ResendCodeSuccess({required this.message});
}

class ResendCodeError extends VerifyCodeState {
  final String error;

  ResendCodeError({required this.error});
}

class TimerUpdated extends VerifyCodeState {
  final int remainingSeconds;

  TimerUpdated({required this.remainingSeconds});
}
