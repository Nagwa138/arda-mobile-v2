import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/top_rated_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<TopRatedModel>>> getTopRated();
}
