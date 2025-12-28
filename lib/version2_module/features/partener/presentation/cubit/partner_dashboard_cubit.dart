import 'package:flutter_bloc/flutter_bloc.dart';
import 'partner_dashboard_state.dart';

class PartnerDashboardCubit extends Cubit<PartnerDashboardState> {
  PartnerDashboardCubit() : super(PartnerDashboardInitial());

  static PartnerDashboardCubit get(context) => BlocProvider.of(context);

  String selectedMenuItem = 'Add Service';

  // Dashboard statistics
  Map<String, dynamic> dashboardStats = {
    'totalEarnings': '200,000',
    'totalBookings': '200',
    'confirmed': '170',
    'rejected': '30',
    'pending': '10',
  };

  void selectMenuItem(String menuItem) {
    selectedMenuItem = menuItem;
    emit(MenuItemSelected(menuItem));
  }

  void loadDashboardData() {
    emit(DashboardLoading());

    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      emit(DashboardLoaded(dashboardStats));
    });
  }

  void refreshDashboard() {
    emit(DashboardLoading());

    // Simulate refresh
    Future.delayed(Duration(milliseconds: 500), () {
      // You can update stats here from API
      emit(DashboardLoaded(dashboardStats));
    });
  }

  void updateStats(Map<String, dynamic> newStats) {
    dashboardStats = newStats;
    emit(DashboardLoaded(dashboardStats));
  }
}
