// lib/OrdersScreen/OrdersScreen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'OrderDetailsScreen.dart';
import '../bottamNavbar.dart';

class OrdersScreen extends StatefulWidget {
  final Map<String, dynamic>? orderData;

  const OrdersScreen({super.key, this.orderData});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List orders = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  // 🔥 Fetch orders from your PHP API
 Future<void> fetchOrders() async {
  const String url = "http://localhost/api/orders.php";

  try {
    final response = await http.get(Uri.parse(url));
    final decoded = jsonDecode(response.body);

    if (decoded is List) {
      setState(() {
        orders = decoded;
        loading = false;
      });
    } else {
      setState(() {
        orders = [];
        loading = false;
      });
    }
  } catch (e) {
    setState(() => loading = false);
    debugPrint("Order fetch error: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,

      body: loading
          ? const Center(child: CircularProgressIndicator())

          : orders.isEmpty
              ? const Center(
                  child: Text(
                    "No orders found",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          return _buildOrderCard(context, orders[index]);
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(50),
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          gradient:
                              const LinearGradient(colors: [Colors.red, Colors.pink]),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BottomNavigatorBar(userData: {})),
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text(
                            "HOME",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
    );
  }

  // 🔥 Build each order card
  Widget _buildOrderCard(BuildContext context, Map order) {
    List<dynamic> products = jsonDecode(order["products"]);
    final firstProduct = products.isNotEmpty ? products[0] : {};

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 6, spreadRadius: 1)
        ],
      ),

      child: Row(
        children: [
          // ❗ If you want product images, add image URL to each product in DB.
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.shopping_bag, size: 40),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.circle,
                      size: 12,
                      color: order["status"] == "Confirmed"
                          ? Colors.green
                          : order["status"] == "Cancelled"
                              ? Colors.red
                              : Colors.orange),
                  const SizedBox(width: 6),
                  Text(
                    order["status"],
                    style: TextStyle(
                      color: order["status"] == "Confirmed"
                          ? Colors.green
                          : order["status"] == "Cancelled"
                              ? Colors.red
                              : Colors.orange,
                    ),
                  ),
                ]),

                const SizedBox(height: 6),

                Text("Order ID: ${order["id"]}"),
                Text("${firstProduct["title"] ?? "Product"}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("₹ ${order["total"]}"),
              ],
            ),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OrderDetailsScreen(
                    orderData: order,
                    customer: {
                      "name": "User",
                      "phone": "Not Added",
                      "address": "Not Added",
                    },
                  ),
                ),
              );
            },
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.red, Colors.pink]),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: const Text("View Details",
                      style: TextStyle(color: Colors.white))),
            ),
          ),
        ],
      ),
    );
  }
}
