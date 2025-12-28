import 'package:PassPort/version2_module/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:PassPort/version2_module/features/home/data/models/top_rated_model.dart';
import 'package:PassPort/version2_module/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/home_repo.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImpl(this.homeRemoteDataSource);

  @override
  Future<Either<Failure, List<TopRatedModel>>> getTopRated() async {
    return await homeRemoteDataSource.getTopRated();
  }
}
