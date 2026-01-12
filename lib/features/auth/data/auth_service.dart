import 'dart:convert';
import 'package:http/http.dart' as http;
import 'UserRole.dart';

class AuthService {
  // Use 10.0.2.2 for Android Emulator, or your Local IP for physical devices
  final String baseUrl = "http://10.0.2.2:5117/api/User";

  Future<bool> createBusDetail(Map<String, dynamic> data) async {
    print("13456789100");
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/Create'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      // Returns true if .NET returns 201 Created or 200 OK
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Connection Error: $e");
      print("Response: ${e.toString()}");
      return false;
    }
  }

  Future<List<UserRole>> getUserRoles() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:5117/api/UserRole'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => UserRole.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print("Error fetching roles: $e");
      return [];
    }
  }
}