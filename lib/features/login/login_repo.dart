import 'dart:convert';
import 'package:ecommerce_app/core/utils/api_end_points.dart';
import 'package:ecommerce_app/features/login/models/login_request.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepo {
  Future<Map<String, dynamic>> loginAndCacheUser(
    LoginRequest loginRequest,
  ) async {
    try {
      final response = await http.post(
        headers: {'Content-Type': 'application/json'},
        Uri.parse(ApiEndPoints.auth),
        body: jsonEncode(loginRequest.toJson()),
      );

      if ((response.statusCode == 200) || (response.statusCode == 201)) {
        final Map<String, dynamic> data = json.decode(response.body);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool("isLoggedIn", true);
        return {"success": true, "token": data["token"]};
      } else {
        return {"success": false, "message": response.body};
      }
    } catch (e) {
      return {"success": false, "message": "Please check your connection."};
    }
  }
}
