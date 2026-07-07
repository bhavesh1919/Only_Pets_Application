// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:only_pets/HomePage/homepage.dart';
// import 'Models/order_model.dart';

// class MyOrders extends StatefulWidget {
//   final String userId; // logged-in user id

//   const MyOrders({super.key, required this.userId});

//   @override
//   State<MyOrders> createState() => _MyOrdersState();
// }

// class _MyOrdersState extends State<MyOrders> {
//   List<Order> orders = [];
//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchOrders();
//   }

//   Future<void> fetchOrders() async {
//     final url = Uri.parse(
//       "http://localhost/api/get_orders.php?user_id=${widget.userId}",
//     );

//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final List data = json.decode(response.body);
//       setState(() {
//         orders = data.map((e) => Order.fromJson(e)).toList();
//         loading = false;
//       });
//     }
//   }

//   Color statusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'confirm':
//         return Colors.green;
//       case 'pending':
//         return Colors.orange;
//       case 'cancel':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("My Orders")),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : orders.isEmpty
//           ? const Center(child: Text("No orders found"))
//           : ListView.builder(
//               itemCount: orders.length,
//               itemBuilder: (context, index) {
//                 final order = orders[index];

//                 return Card(
//                   margin: const EdgeInsets.all(8),
//                   child: ListTile(
//                     title: Text("Order #${order.id}"),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Total: ₹${order.total}"),
//                         Text("Date: ${order.createdAt}"),
//                       ],
//                     ),
//                     trailing: Chip(
//                       label: Text(order.status),
//                       backgroundColor: statusColor(
//                         order.status,
//                       ).withOpacity(0.2),
//                       labelStyle: TextStyle(
//                         color: statusColor(order.status),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 8),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => HomeScreen(
//                               // pass userId if HomeScreen needs it
//                             ),
//                           ),
//                           (route) => false, // clear previous screens
//                         );
//                       },
//                       child: const Text("Buy Other"),
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:only_pets/HomePage/homepage.dart';
import 'package:only_pets/bottamNavbar.dart';
import 'Models/order_model.dart';

class MyOrders extends StatefulWidget {
  final String userId; // logged-in user id

  const MyOrders({super.key, required this.userId});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List<Order> orders = [];
  bool loading = true;
  bool hasError = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    final url = Uri.parse(
      "http://localhost/api/get_orders.php?user_id=20",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        setState(() {
          orders = data.map((e) => Order.fromJson(e)).toList();
          loading = false;
        });
      } else {
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to load orders")),
        );
      }
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirm':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancel':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Orders")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : orders.isEmpty
              ? const Center(child: Text("No orders found"))
              : ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];

                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text("Order #${order.id}"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Total: ₹${order.total}"),
                                  Text("Date: ${order.createdAt}"),
                                ],
                              ),
                              trailing: Chip(
                                label: Text(order.status),
                                backgroundColor:
                                    statusColor(order.status).withOpacity(0.2),
                                labelStyle: TextStyle(
                                  color: statusColor(order.status),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => HomeScreen(
                                        // pass userId if HomeScreen needs it
                                      ),
                                    ),
                                    (route) => false, // clear previous screens
                                  );
                                },
                                child: const Text("Buy Other"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
