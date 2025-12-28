

import 'package:PassPort/version2_module/features/home/data/models/top_rated_model.dart';

abstract class TopRatedState {}

class TopRatedInitial extends TopRatedState {}

class TopRatedLoading extends TopRatedState {}

class TopRatedSuccess extends TopRatedState {
  final List<TopRatedModel> topRated;

  TopRatedSuccess(this.topRated);
}

class TopRatedError extends TopRatedState {
  final String message;

  TopRatedError(this.message);
}
