import 'package:flutter/material.dart';
import 'package:only_pets/OrdersScreen/Orderscreen.dart';
import 'package:only_pets/my_orders.dart';
import '../bottamNavbar.dart';

class OrderSuccessScreen extends StatelessWidget {
  final String orderId;
  final Map<String, dynamic> userData;

  const OrderSuccessScreen({super.key, required this.orderId, this.userData = const {}});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 120),
            const SizedBox(height: 20),
            Text("Order #$orderId Placed Successfully!",
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => BottomNavigatorBar(userData: {})),
                  (route) => false,
                );
              },
              child: const Text("Back to Home"),
            ),

            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => MyOrders(
          userId: "20", // 👈 pass logged-in user id
        ),),
                  (route) => false,
                );
              },
              child: const Text("View Orders"),
            ),
          ],
        ),
      ),
    );
  }
}
