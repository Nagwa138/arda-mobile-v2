import 'package:PassPort/models/traveller/accomandating/randomAccomandtion.dart';
import 'package:PassPort/version2_module/core/services/api_services.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';

abstract class UniqueStaysRepository {
  Future<Either<Failure, List<Data>>> getUniqueStays();
}

class UniqueStaysRepositoryImpl implements UniqueStaysRepository {
  final ApiService apiService;

  UniqueStaysRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<Data>>> getUniqueStays() async {
    try {
      var data = await apiService.get(
        endPoint: 'Accomodation/GetRandomAccomodations',
      );
      List<Data> uniqueStaysList = [];
      for (var item in data['data']) {
        uniqueStaysList.add(Data.fromJson(item));
      }
      return right(uniqueStaysList);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
