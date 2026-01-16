import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hiwaygo/core/constants/app_assets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'bus_route_model.dart';
import 'booking_model.dart';

class BookingService {

  
  Future<List<BusRouteModel>> getBusRoutes() async {
    try {
      final response = await http.get(Uri.parse('${AppAssets.baseUrl}/BusBooking/routes'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => BusRouteModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load routes: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching routes: $e");
    }
  }

  Future<List<BookingModel>> getBookings() async {
    try {
      final userId = await _getUserIdFromToken();
      if (userId == null) {
        print("User ID not found in token");
        return [];
      }

      final response = await http.get(Uri.parse('${AppAssets.baseUrl}/BusBooking/details/$userId'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => BookingModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load bookings: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching bookings: $e");
    }
  }

  Future<bool> createBooking({
    required String busRouteId,
    required String pickupLocation,
    required int noOfSeats,
    required DateTime bookingDate,
  }) async {
    try {
      print("--- STARTING BOOKING REQUEST ---");
      final userId = await _getUserIdFromToken();
      print("User ID from Token: $userId");

      if (userId == null) {
        print("❌ ABORTING: User ID is null. User might not be logged in or token is invalid.");
        return false;
      }

      final url = Uri.parse('${AppAssets.baseUrl}/BusBooking/newBooking');
      print("Target URL: $url");
      
      final body = {
        "id": _generateUuidV4(),
        "busRouteId": busRouteId,
        "busId": null,
        "bookBy": userId,
        "payAmount": 0,
        "createDate": DateTime.now().toIso8601String(),
        "bookingDate": bookingDate.toIso8601String(),
        "isTransactionComplete": true,
        "pickupLocation": pickupLocation,
        "noOfSeats": noOfSeats
      };

      print("Request Body: ${jsonEncode(body)}");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("❌ EXCEPTION during booking: $e");
      return false;
    }
  }

  Future<String?> _getUserIdFromToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    if (token != null) {
      final payload = _parseJwt(token);
      final String? userRoleId = payload['UserRole'];
      print("UserRole: $userRoleId");
    }
    if (token == null) return null;

    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;
      
      final payload = base64Url.normalize(parts[1]);
      final decoded = utf8.decode(base64Url.decode(payload));
      final Map<String, dynamic> data = jsonDecode(decoded);
      
      // Adjust key based on your token claims (e.g., 'id', 'sub', 'nameid')
      return data['id'] ?? data['sub'] ?? data['userId'];
    } catch (e) {
      print("Token decode error: $e");
      return null;
    }
  }

   Map<String, dynamic> _parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }
    String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0: break;
      case 2: output += '=='; break;
      case 3: output += '='; break;
      default: throw Exception('Illegal base64url string!"');
    }
    return utf8.decode(base64Url.decode(output));
  }

  String _generateUuidV4() {
    final Random random = Random();
    final List<String> hexDigits = '0123456789abcdef'.split('');
    final List<String> uuid = List.filled(36, '');

    for (int i = 0; i < 36; i++) {
      if (i == 8 || i == 13 || i == 18 || i == 23) {
        uuid[i] = '-';
      } else if (i == 14) {
        uuid[i] = '4';
      } else if (i == 19) {
        uuid[i] = hexDigits[(random.nextInt(4) + 8)];
      } else {
        uuid[i] = hexDigits[random.nextInt(16)];
      }
    }
    return uuid.join('');
  }
}