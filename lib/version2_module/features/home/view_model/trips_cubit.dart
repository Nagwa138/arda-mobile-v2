import 'package:PassPort/version2_module/features/home/data/repositories/trips_repo.dart';
import 'package:bloc/bloc.dart';

import 'trips_state.dart';

class TripsCubit extends Cubit<TripsState> {
  final TripsRepository tripsRepository;

  TripsCubit(this.tripsRepository) : super(TripsInitial());

  Future<void> getTrips() async {
    emit(TripsLoading());
    var result = await tripsRepository.getTrips();
    result.fold(
      (failure) => emit(TripsError(failure.message)),
      (trips) => emit(TripsSuccess(trips)),
    );
  }
}
