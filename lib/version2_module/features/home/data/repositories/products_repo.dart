import 'package:PassPort/version2_module/core/services/api_services.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:PassPort/models/traveller/randomProduct/random_product.dart'
    as product_model;

import '../../../../core/errors/failures.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<product_model.Data>>> getProducts();
}

class ProductsRepositoryImpl implements ProductsRepository {
  final ApiService apiService;

  ProductsRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<product_model.Data>>> getProducts() async {
    try {
      var data = await apiService.get(
        endPoint: 'Product/GetRandomProducts',
      );
      List<product_model.Data> productsList = [];
      for (var item in data['data']) {
        productsList.add(product_model.Data.fromJson(item));
      }
      return right(productsList);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
