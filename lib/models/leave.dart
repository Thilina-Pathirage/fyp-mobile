class Leave {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime requestedDate;
  final String requestedUserEmail;
  final String status;

  Leave({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.requestedDate,
    required this.requestedUserEmail,
    required this.status,
  });
}

