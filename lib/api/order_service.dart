import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderApi {
  static const String baseUrl =
      "http://localhost/api/orders.php";
  // For real device:
  // "http://192.168.1.5/admin_panel/api/orders.php";

  /// PLACE ORDER


static Future<Map<String, dynamic>> placeOrder({
  required String userId,
  required double total,
  required List<Map<String, dynamic>> products,
}) async {
  try {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: {
        "user_id": userId,
        "total": total.toString(),
        "status": "pending",
        "products": jsonEncode(products),
      },
    );

    debugPrint("STATUS CODE: ${response.statusCode}");
    debugPrint("RESPONSE BODY: ${response.body}");

    return jsonDecode(response.body);
  } catch (e) {
    debugPrint("ERROR: $e");
    return {
      "status": false,
      "message": e.toString(),
    };
  }
}


  /// GET ORDER STATUS
  Future<String> getOrderStatus(String orderId) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl?order_id=$orderId"),
      );

      final data = jsonDecode(response.body);

      if (data["status"] == true) {
        return data["order_status"];
      }
      return "pending";
    } catch (_) {
      return "pending";
    }
  }
}
