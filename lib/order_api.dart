import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderAPI {
  static const String orderURL = "http://10.139.36.7/api/order.php";

  static Future<String> placeOrder({
    required String userId,
    required String total,
    required String status,
  }) async {

    final response = await http.post(
      Uri.parse(orderURL),
      body: {
        'user_id': userId,
        'total': total,
        'status': status,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    } else {
      return "Order failed!";
    }
  }
}
