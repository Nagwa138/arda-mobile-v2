import 'package:PassPort/version2_module/features/home/data/repositories/activities_repo.dart';
import 'package:bloc/bloc.dart';

import 'activities_state.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  final ActivitiesRepository activitiesRepository;

  ActivitiesCubit(this.activitiesRepository) : super(ActivitiesInitial());

  Future<void> getActivities() async {
    emit(ActivitiesLoading());
    var result = await activitiesRepository.getActivities();
    result.fold(
      (failure) => emit(ActivitiesError(failure.message)),
      (activities) => emit(ActivitiesSuccess(activities)),
    );
  }
}
