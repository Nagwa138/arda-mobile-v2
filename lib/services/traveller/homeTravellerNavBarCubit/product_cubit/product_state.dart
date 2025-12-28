import 'package:PassPort/models/traveller/products/card_model.dart';

abstract class ProductState {}

final class ProductInitial extends ProductState {}

final class getProductLoading extends ProductState {}

final class getProductSuccessful extends ProductState {}

final class getProductError extends ProductState {
  final String error;

  getProductError({required this.error});
}

/// product by Id
final class getProductByIdLoading extends ProductState {}

final class getProductByIdSuccessful extends ProductState {}

final class getProductByIdError extends ProductState {
  final String error;

  getProductByIdError({required this.error});
}

/// product all by Id
final class getAllProductByIdLoading extends ProductState {}

final class getAllProductByIdSuccessful extends ProductState {}

final class getAllProductByIdError extends ProductState {
  final String error;

  getAllProductByIdError({required this.error});
}
///
/// change Favourite
final class FavouriteChange extends ProductState {}

final class FavChange extends ProductState {}


/// Favourite add Of Products
final class AddFavouriteOfProductLoading extends ProductState {}

final class AddFavouriteOfProductSuccessful extends ProductState {}

final class AddFavouriteOfProductError extends ProductState {
final  String error;

  AddFavouriteOfProductError({required this.error});
}

/// delete Favourite Of Product

final class deleteFavouriteOfProductLoading extends ProductState {}

final class deleteFavouriteOfProductSuccessful extends ProductState {}

final class deleteFavouriteOfProductError extends ProductState {
  final  String error;

  deleteFavouriteOfProductError({required this.error});
}

/// add card


final class getOrderLoading extends ProductState {}

final class getOrderSuccessful extends ProductState {}

final class getOrderError extends ProductState {
  final  String error;

  getOrderError({required this.error});
}
final class MadeOrderLoading extends ProductState {}

final class MadeOrderSuccessful extends ProductState {}

final class MadeOrderError extends ProductState {
  final  String error;

  MadeOrderError({required this.error});
}

final class Add extends ProductState {}

final class Sub extends ProductState {}

final class ChangeColor extends ProductState {}

final class CartLoaded extends ProductState {}

final class CartError extends ProductState {
  final  String error;

  CartError({required this.error});
}


/// details order
final class GetDetailsLoading extends ProductState {}

final class GetDetailsSuccessful extends ProductState {}

final class GetDetailsError extends ProductState {
  final  String error;

  GetDetailsError({required this.error});
}

/// made order again
final class OrderAgainLoading extends ProductState {}

final class OrderAgainSuccessful extends ProductState {}

final class OrderAgainError extends ProductState {
  final  String error;

  OrderAgainError({required this.error});
}

final class PaymentLoading extends ProductState {}

final class PaymentSuccess extends ProductState {}

final class PaymentFailure extends ProductState {
  final  String error;

  PaymentFailure({required this.error});
}
final class PaymentOrNotLoading extends ProductState {}

final class PaymentOrNotSuccessful extends ProductState {}

final class PaymentOrNotError extends ProductState {
  final  String error;

  PaymentOrNotError({required this.error});
}
final class AddProfitLoading extends ProductState {}

final class AddProfitSuccessful extends ProductState {}

final class AddProfitError extends ProductState {
  final  String error;

  AddProfitError({ required this.error});
}