import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:bank_management_system/models/application.dart';

class AdminService {
  final String baseUrl = 'https://your-backend-api.com/admin';

  Future<Map<String, dynamic>> getAggregateMetrics() async {
    final response = await http.get(Uri.parse('$baseUrl/metrics'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load metrics');
    }
  }

  // Future<List<Application>> getPendingApplications() async {
  //   final response = await http.get(Uri.parse('$baseUrl/pending-applications'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = jsonDecode(response.body);
  //     return data.map((json) => Application.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to load pending applications');
  //   }
  // }

  Future<void> approveApplication(int applicationId) async {
    final response = await http.post(Uri.parse('$baseUrl/approve/$applicationId'));
    if (response.statusCode != 200) {
      throw Exception('Failed to approve application');
    }
  }

  Future<void> denyApplication(int applicationId) async {
    final response = await http.post(Uri.parse('$baseUrl/deny/$applicationId'));
    if (response.statusCode != 200) {
      throw Exception('Failed to deny application');
    }
  }
}
