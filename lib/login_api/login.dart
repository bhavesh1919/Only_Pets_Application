import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
//  static const String baseUrl = "http://10.230.93.43/api";
static const String baseUrl = "http://localhost/api";

  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final url = Uri.parse("$baseUrl/login.php");

      final response = await http.post(
        url,
        body: {
          "email": email,
          "password": password,
        },
      );

      print("API RAW RESPONSE : ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        return {"status": "error", "message": "Server error"};
      }
    } catch (e) {
      print("LOGIN ERROR : $e");
      return {"status": "error", "message": "Something went wrong"};
      }
  }
}