// lib/api/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:only_pets/Models/product.dart';

class ApiService {
  final String baseUrl = "http://localhost/api"; // change if needed

  Future<List<Product>> fetchProducts() async {
    final uri = Uri.parse("$baseUrl/products.php");

    final response = await http.get(uri).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      // debug - helpful when something goes wrong
      // print('API response: ${response.body}');

      final decoded = jsonDecode(response.body);

      // If decoded is an object with `data` field, use decoded['data'].
      // Our products.php returns a plain JSON array: [...]
      List<dynamic> list;
      if (decoded is List) {
        list = decoded;
      } else if (decoded is Map && decoded['data'] is List) {
        list = decoded['data'];
      } else {
        throw Exception("Unexpected JSON format: ${decoded.runtimeType}");
      }

      return list.map((e) {
        if (e is Map<String, dynamic>) {
          return Product.fromJson(e);
        } else {
          return Product.fromJson(Map<String, dynamic>.from(e));
        }
      }).toList();
    } else {
      throw Exception("Failed to load products: ${response.statusCode}");
    }
  }
}
