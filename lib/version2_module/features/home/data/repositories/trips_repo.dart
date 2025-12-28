import 'package:PassPort/version2_module/core/services/api_services.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:PassPort/models/traveller/trips_model/trips_model.dart'
    as trips_model;

import '../../../../core/errors/failures.dart';

abstract class TripsRepository {
  Future<Either<Failure, List<trips_model.Data>>> getTrips();
}

class TripsRepositoryImpl implements TripsRepository {
  final ApiService apiService;

  TripsRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<trips_model.Data>>> getTrips() async {
    try {
      var data = await apiService.get(
        endPoint: 'Trips/Traveller/GetAllTrips',
      );
      List<trips_model.Data> tripsList = [];
      for (var item in data['data']) {
        tripsList.add(trips_model.Data.fromJson(item));
      }
      return right(tripsList);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
