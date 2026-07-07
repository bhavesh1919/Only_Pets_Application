import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterApi {
  static const String baseUrl = "http://localhost/api"; 
  //static const String baseUrl = "http://10.230.93.43/api";
  // If using emulator → "http://10.0.2.2/api"
  // If using real device → use your PC IP e.g. "http://192.168.1.5/api"

  static Future<bool> registerUser(
      String name, String phone, String email, String password) async {
    try {
      final url = Uri.parse("$baseUrl/registration.php");

      final response = await http.post(
        url,
        body: {
          "name": name,
          "phone": phone,
          "email": email,
          "pass": password,
        },
      );

      print("REGISTER RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return data["status"] == "success";
      }

      return false;
    } catch (e) {
      print("REGISTER ERROR: $e");
      return false;
    }
  }
}