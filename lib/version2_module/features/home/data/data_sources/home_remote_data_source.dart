import 'package:PassPort/version2_module/core/services/api_services.dart';
import 'package:PassPort/version2_module/features/home/data/models/top_rated_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failure, List<TopRatedModel>>> getTopRated();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl(this.apiService);

  @override
  @override
  Future<Either<Failure, List<TopRatedModel>>> getTopRated() async {
    try {
      final response = await apiService.get(endPoint: 'TopRated?topCount=5');

      if (response == null) {
        return left(ServerFailure('Empty response from API'));
      }

      final data = response['data'];
      if (data == null || data is! List) {
        print("⚠️ Unexpected 'data' format: $data");
        return right([]);
      }

      final topRatedList = data
          .map<TopRatedModel>((item) => TopRatedModel.fromJson(item))
          .toList();

      print("✅ Fetched Top Rated: ${topRatedList.map((e) => e.toJson())}");
      return right(topRatedList);
    } catch (e) {
      print("💥 Error in getTopRated: $e");
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
