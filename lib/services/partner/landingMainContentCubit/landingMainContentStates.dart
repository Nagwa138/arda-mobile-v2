abstract class LandingMainContentStates {}

final class LandingMainContentInitial extends LandingMainContentStates {}

final class ToggleServicesSucsses extends LandingMainContentStates {}

/// get all Guests
final class getAllGuestLoading extends LandingMainContentStates {}

final class getAllGuestSuccessful extends LandingMainContentStates {}

final class getAllGuestError extends LandingMainContentStates {
  final String error;

  getAllGuestError({required this.error});
}

final class getAllGuestLoadingUpcoming extends LandingMainContentStates {}

final class getAllGuestSuccessfulUpcoming extends LandingMainContentStates {}

final class getAllGuestErrorUpcoming extends LandingMainContentStates {
  final String error;

  getAllGuestErrorUpcoming({required this.error});
}
///
final class getAllGuestLoadingComplete extends LandingMainContentStates {}

final class getAllGuestSuccessfulComplete extends LandingMainContentStates {}

final class getAllGuestErrorComplete extends LandingMainContentStates {
  final String error;

  getAllGuestErrorComplete({required this.error});
}

///
final class getAllGuestLoadingCancel extends LandingMainContentStates {}

final class getAllGuestSuccessfulCancel extends LandingMainContentStates {}

final class getAllGuestErrorCancel extends LandingMainContentStates {
  final String error;

  getAllGuestErrorCancel({required this.error});
}

///
final class getGuestByIdLoadingCancel extends LandingMainContentStates {}

final class getGuestByIdSuccessfulCancel extends LandingMainContentStates {}

final class getGuestByIdErrorCancel extends LandingMainContentStates {
  final String error;

  getGuestByIdErrorCancel({required this.error});
}


///
final class getAllGuestLoadingState extends LandingMainContentStates {}

final class getAllGuestSuccessfulState extends LandingMainContentStates {}

final class getAllGuestErrorState extends LandingMainContentStates {
  final String error;

  getAllGuestErrorState({required this.error});
}

///
final class AcceptLoading extends LandingMainContentStates {}

final class AcceptSuccessful extends LandingMainContentStates {}

final class AcceptError extends LandingMainContentStates {
  final String error;

  AcceptError({required this.error});
}

///
final class RejectLoading extends LandingMainContentStates {}

final class RejectSuccessful extends LandingMainContentStates {}

final class RejectError extends LandingMainContentStates {
  final String error;

  RejectError({required this.error});
}

///
final class getAllGuestShowAllLoadingState extends LandingMainContentStates {}

final class getAllGuestShowAllSuccessfulState extends LandingMainContentStates {}

final class getAllGuestShowAllErrorState extends LandingMainContentStates {
  final String error;

  getAllGuestShowAllErrorState({required this.error});
}


