class Leave {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime requestedDate;
  final String requestedUserEmail;
  final String status;
  final String reason;

  Leave({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.requestedDate,
    required this.requestedUserEmail,
    required this.status,
    this.reason = '',
  });

  factory Leave.fromJson(Map<String, dynamic> json) {
    return Leave(
      id: json['_id'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      requestedDate: DateTime.parse(json['requestedDate']),
      requestedUserEmail: json['requestedUserEmail'],
      status: json['status'],
      reason: json['reason'],
    );
  }
}
