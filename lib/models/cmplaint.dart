class Complaint {
  final String id;
  final String title;
  final String description;
  final String createdUserEmail;

  Complaint({
    required this.id,
    required this.title,
    required this.description,
    required this.createdUserEmail,
  });


  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      createdUserEmail: json['createdUserEmail'],
      
    );
  }
}

