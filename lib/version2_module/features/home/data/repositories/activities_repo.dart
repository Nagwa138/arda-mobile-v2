import 'package:PassPort/version2_module/core/services/api_services.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:PassPort/models/traveller/activity/activity_random_model.dart'
    as activity_model;

import '../../../../core/errors/failures.dart';

abstract class ActivitiesRepository {
  Future<Either<Failure, List<activity_model.Data>>> getActivities();
}

class ActivitiesRepositoryImpl implements ActivitiesRepository {
  final ApiService apiService;

  ActivitiesRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<activity_model.Data>>> getActivities() async {
    try {
      var data = await apiService.get(
        endPoint: 'Activities/GetRandomActivities',
      );
      List<activity_model.Data> activitiesList = [];
      for (var item in data['data']) {
        activitiesList.add(activity_model.Data.fromJson(item));
      }
      return right(activitiesList);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
