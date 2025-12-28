import 'package:PassPort/version2_module/features/home/data/repositories/products_repo.dart';
import 'package:bloc/bloc.dart';

import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepository productsRepository;

  ProductsCubit(this.productsRepository) : super(ProductsInitial());

  Future<void> getProducts() async {
    emit(ProductsLoading());
    var result = await productsRepository.getProducts();
    result.fold(
      (failure) => emit(ProductsError(failure.message)),
      (products) => emit(ProductsSuccess(products)),
    );
  }
}
