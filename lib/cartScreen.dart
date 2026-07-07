// lib/cartScreen.dart
import 'package:flutter/material.dart';
import 'Models/models.dart';
import 'checkout_Screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double productCost = cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
    double deliveryCharge = 25;
    double discount = 10;
    double total = productCost + deliveryCharge - discount;

    return Scaffold(
      appBar: AppBar(title: const Text("Cart Screen")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          Expanded(
            child: cartItems.isEmpty
                ? const Center(child: Text(" Cart is empty"))
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        child: ListTile(
                          leading: Image.asset(item.image, width: 60, height: 60),
                          title: Text(item.title),
                          subtitle: Text("₹${item.price}"),
                          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                            IconButton(icon: const Icon(Icons.remove), onPressed: () => setState(() { if (item.quantity > 1) item.quantity--; else cartItems.removeAt(index); })),
                            Text("${item.quantity}"),
                            IconButton(icon: const Icon(Icons.add), onPressed: () => setState(() => item.quantity++)),
                          ]),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              SummaryRow("Product Cost", "₹${productCost.toStringAsFixed(2)}"),
              SummaryRow("Delivery Charge", "+₹$deliveryCharge"),
              SummaryRow("Discount", "-₹$discount"),
              const Divider(),
              SummaryRow("Total", "₹${total.toStringAsFixed(2)}", isBold: true),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.red, Colors.pink]), borderRadius: BorderRadius.circular(30)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  onPressed: cartItems.isEmpty ? null : () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckoutScreen())),
                  child: const Text("PROCEED TO CHECKOUT", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  const SummaryRow(this.label, this.value, {this.isBold = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)), Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal))]));
  }
}
