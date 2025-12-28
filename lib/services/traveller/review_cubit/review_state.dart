abstract class ReviewState {}

final class ReviewInitial extends ReviewState {}

final class GetReviewLoading extends ReviewState {}

final class GetReviewSuccessful extends ReviewState {}

final class GetReviewError extends ReviewState {
  final String error;

  GetReviewError({required this.error});
}


final class GetReviewLoadingAll extends ReviewState {}

final class GetReviewSuccessfulAll extends ReviewState {}

final class GetReviewErrorAll extends ReviewState {
  final String error;

  GetReviewErrorAll({required this.error});
}

/// create review

final class CreateReviewLoading extends ReviewState {}

final class CreateReviewSuccessful extends ReviewState {}

final class CreateReviewError extends ReviewState {
  final String error;

  CreateReviewError({required this.error});
}