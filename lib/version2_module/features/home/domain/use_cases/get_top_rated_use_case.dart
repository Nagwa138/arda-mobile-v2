import 'package:PassPort/version2_module/core/errors/failures.dart';
import 'package:PassPort/version2_module/features/home/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/top_rated_model.dart';

class GetTopRatedUseCase {
  final HomeRepository homeRepository;

  GetTopRatedUseCase(this.homeRepository);

  Future<Either<Failure, List<TopRatedModel>>> call() async {
    return await homeRepository.getTopRated();
  }
}
