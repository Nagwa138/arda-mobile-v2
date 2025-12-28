/// Cancellation reasons for booking requests
/// Maps to the API reason parameter values: 0, 1, 2, 3, 4
enum CancellationReason {
  unavailable(0, 'Service Unavailable',
      'The requested service is currently unavailable'),
  fullyBooked(
      1, 'Fully Booked', 'No capacity available for the requested dates'),
  maintenance(
      2, 'Maintenance Required', 'Service requires maintenance or preparation'),
  policyViolation(
      3, 'Policy Violation', 'Request violates our service policies'),
  other(4, 'Other Reason', 'Other reason for cancellation');

  const CancellationReason(this.id, this.title, this.description);

  final int id;
  final String title;
  final String description;

  static CancellationReason fromId(int id) {
    return CancellationReason.values.firstWhere(
      (reason) => reason.id == id,
      orElse: () => CancellationReason.other,
    );
  }
}
