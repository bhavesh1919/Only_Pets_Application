import 'package:flutter/material.dart';
import 'package:only_pets/OrdersScreen/OrderStatusScreen.dart';
import '../Models/models.dart';
import '../api/order_service.dart';

class PaymentOptionScreen extends StatefulWidget {
  final String userId;
  final String firstName;
  final String lastName;
  final String address;
  final String city;
  final String postcode;
  final String phone;
  final String email;

  const PaymentOptionScreen({
    super.key,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.city,
    required this.postcode,
    required this.phone,
    required this.email,
  });

  @override
  State<PaymentOptionScreen> createState() =>
      _PaymentOptionScreenState();
}

class _PaymentOptionScreenState
    extends State<PaymentOptionScreen> {
  String selected = "COD";
  bool loading = false;

  double calculateTotal() {
    return cartItems.fold(
      0,
      (sum, item) => sum + item.price * item.quantity,
    );
  }

  Future<void> _placeOrder() async {
    setState(() => loading = true);

    final productsJson = cartItems.map((p) {
      return {
        "title": p.title,
        "price": p.price,
        "quantity": p.quantity,
      };
    }).toList();

    final result = await OrderApi.placeOrder(
      userId: widget.userId,
      total: calculateTotal(),
      products: productsJson,
    );

    setState(() => loading = false);

    if (result["status"] == true &&
        result.containsKey("orderId")) {
      final orderId = result["orderId"].toString();
      cartItems.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              OrderStatusScreen(orderId: orderId),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result["message"] ?? "Order failed",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            RadioListTile(
              value: "COD",
              groupValue: selected,
              title: const Text("Cash On Delivery"),
              onChanged: (v) => setState(() => selected = v!),
            ),
            const Spacer(),
            loading
                ? const CircularProgressIndicator()
                : Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.red, Colors.pink],
                      ),
                      borderRadius:
                          BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.transparent,
                        shadowColor:
                            Colors.transparent,
                      ),
                      onPressed: _placeOrder,
                      child: Text(
                        "Pay ₹${calculateTotal().toStringAsFixed(2)}",
                        style: const TextStyle(
                            color: Colors.white),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
