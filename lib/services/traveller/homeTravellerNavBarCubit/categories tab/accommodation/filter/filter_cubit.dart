import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterInitial());

  int selectedSort = 0;
  double currentPrice = 0;
  int selectedRoomType = 0;

  void selectSort(int index) {
    selectedSort = index;
    print(selectedSort);
    emit(FilterSortSelected());
  }

  void selectRoomType(int index) {
    selectedRoomType = index;
    emit(FilterRoomTypeSelected());
  }

  void changePrice(double price) {
    currentPrice = price;
    emit(FilterPriceRangeChanged());
  }
}
