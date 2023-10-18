import 'dart:convert';
import 'package:fyp_mobile/constants/constants.dart';
import 'package:fyp_mobile/models/leave.dart';
import 'package:http/http.dart' as http;

class LeavesService {
  Future<List<Leave>> getLeavesByUser(String userEmail) async {
    try {
      final url = Uri.parse('$baseUrl/api/leaves/by-user/$userEmail');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final List<Leave> leaves =
            jsonData.map((item) => Leave.fromJson(item)).toList();
        return leaves;
      } else {
        throw Exception('Failed to get leaves: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get leaves: $e');
    }
  }

  Future<String> createLeave(
    startDate,
    endDate,
    requestedDate,
    requestedUserEmail,
    reason,
  ) async {
    final url = Uri.parse('$baseUrl/api/leaves/create');

    final headers = {
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'startDate': startDate,
      'endDate': endDate,
      'requestedDate': requestedDate,
      'requestedUserEmail': requestedUserEmail,
      'reason': reason,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Failed to create leave request: ${response.statusCode}');
    }
  }

  Future<String> updateLeave(
    id,
    startDate,
    endDate,
    reason,
  ) async {
    final url = Uri.parse('$baseUrl/api/leaves/update/$id');

    final headers = {
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'startDate': startDate,
      'endDate': endDate,
      'reason': reason,
    });

    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to update leave request: ${response.statusCode}');
    }
  }
}
