import 'dart:convert';
import 'package:fyp_mobile/constants/constants.dart';
import 'package:fyp_mobile/models/cmplaint.dart';
import 'package:http/http.dart' as http;

class ComplaintsService {
  Future<List<Complaint>> getComplaintsByUser(String userEmail) async {
    try {
      final url = Uri.parse('$baseUrl/api/complaints/by-user/$userEmail');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final List<Complaint> complaints =
            jsonData.map((item) => Complaint.fromJson(item)).toList();
        return complaints;
      } else {
        throw Exception('Failed to get complaints: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get complaints: $e');
    }
  }

  Future<String> createComplaint(
    String title,
    String description,
    String createdUserEmail,
  ) async {
    final url = Uri.parse('$baseUrl/api/complaints/create');

    final headers = {
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'title': title,
      'description': description,
      'createdUserEmail': createdUserEmail,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Failed to create complaint: ${response.statusCode}');
    }
  }
}
