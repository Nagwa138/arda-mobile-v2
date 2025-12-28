import 'package:PassPort/version2_module/features/home/data/repositories/unique_stays_repo.dart';
import 'package:bloc/bloc.dart';

import 'unique_stays_state.dart';

class UniqueStaysCubit extends Cubit<UniqueStaysState> {
  final UniqueStaysRepository uniqueStaysRepository;

  UniqueStaysCubit(this.uniqueStaysRepository) : super(UniqueStaysInitial());

  Future<void> getUniqueStays() async {
    emit(UniqueStaysLoading());
    var result = await uniqueStaysRepository.getUniqueStays();
    result.fold(
      (failure) => emit(UniqueStaysError(failure.message)),
      (uniqueStays) => emit(UniqueStaysSuccess(uniqueStays)),
    );
  }
}
