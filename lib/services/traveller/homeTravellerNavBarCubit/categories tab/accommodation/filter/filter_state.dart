part of 'filter_cubit.dart';

@immutable
sealed class FilterState {}

final class FilterInitial extends FilterState {}

final class FilterSortSelected extends FilterState {}

final class FilterPriceRangeChanged extends FilterState {}

final class FilterRoomTypeSelected extends FilterState {}
