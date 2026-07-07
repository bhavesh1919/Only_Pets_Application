import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:only_pets/Models/product.dart';

class ProductAPI {
  static const String apiURL = "http://10.139.36.7/admin_panel/getProducts.php";

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiURL));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }
}
