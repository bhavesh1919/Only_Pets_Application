// lib/DetailsScreen.dart
import 'package:flutter/material.dart';
import 'package:only_pets/Models/models.dart';
import 'package:only_pets/cartScreen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String title;
  final String image; // now a network URL
  final double price;

  const ProductDetailsScreen({
    super.key,
    required this.title,
    required this.image,
    required this.price,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), backgroundColor: Colors.red),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.broken_image, size: 60),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(widget.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text("₹${widget.price.toStringAsFixed(2)}",
              style: const TextStyle(
                  fontSize: 20, color: Colors.red, fontWeight: FontWeight.w500)),
          const SizedBox(height: 12),
          Row(children: [
            const Text("Quantity: ", style: TextStyle(fontSize: 16)),
            IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => setState(() {
                      if (quantity > 1) quantity--;
                    })),
            Text(quantity.toString(), style: const TextStyle(fontSize: 18)),
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => setState(() => quantity++)),
          ]),
          const SizedBox(height: 20),
          const Text("Product Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
              "This is a premium pet product carefully selected to keep your pet healthy and happy.",
              style: TextStyle(color: Colors.black87, fontSize: 15)),
          const Spacer(),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.red, Colors.pink]),
                borderRadius: BorderRadius.circular(30)),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              onPressed: () {
                final index =
                    cartItems.indexWhere((p) => p.title == widget.title);
                setState(() {
                  if (index != -1) {
                    cartItems[index].quantity += quantity;
                  } else {
                    cartItems.add(Product(
                        title: widget.title,
                        image: widget.image,
                        price: widget.price,
                        quantity: quantity));
                  }
                });

                // Navigate to cart screen (you used pushReplacement previously; using push here)
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const CartScreen()));
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${widget.title} added to cart successfully!')));
              },
              child: const Text("BUY NOW",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ]),
      ),
    );
  }
}
