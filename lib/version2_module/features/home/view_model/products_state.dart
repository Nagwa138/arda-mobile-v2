import 'package:equatable/equatable.dart';
import 'package:PassPort/models/traveller/randomProduct/random_product.dart'
    as product_model;

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsSuccess extends ProductsState {
  final List<product_model.Data> products;

  const ProductsSuccess(this.products);
}

class ProductsError extends ProductsState {
  final String message;

  const ProductsError(this.message);
}
