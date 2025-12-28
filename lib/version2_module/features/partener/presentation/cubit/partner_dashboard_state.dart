abstract class PartnerDashboardState {}

class PartnerDashboardInitial extends PartnerDashboardState {}

class DashboardLoading extends PartnerDashboardState {}

class DashboardLoaded extends PartnerDashboardState {
  final Map<String, dynamic> stats;

  DashboardLoaded(this.stats);
}

class DashboardError extends PartnerDashboardState {
  final String message;

  DashboardError(this.message);
}

class MenuItemSelected extends PartnerDashboardState {
  final String selectedItem;

  MenuItemSelected(this.selectedItem);
}
