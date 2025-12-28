import 'package:PassPort/version2_module/features/home/domain/use_cases/get_top_rated_use_case.dart';
import 'package:PassPort/version2_module/features/home/view_model/top_rated_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedCubit extends Cubit<TopRatedState> {
  final GetTopRatedUseCase getTopRatedUseCase;

  TopRatedCubit(this.getTopRatedUseCase) : super(TopRatedInitial());

  Future<void> getTopRated() async {
    emit(TopRatedLoading());
    var result = await getTopRatedUseCase();

    result.fold(
      (failure) => emit(TopRatedError(failure.message)),
      (topRated) => emit(TopRatedSuccess(topRated)),
    );
  }
}
