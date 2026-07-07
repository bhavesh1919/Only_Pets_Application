// lib/HomePage/homepage.dart
import 'package:flutter/material.dart';
import 'package:only_pets/DetailsScreen.dart';
import 'package:only_pets/cartScreen.dart';
import '../Models/models.dart';
import 'homePlist.dart'; // your bannerImages, categories, trendingProducts, etc.

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBanner = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/img/logo.png', height: 40),
                  const Text(
                    "Home Screen",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_cart, size: 28),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CartScreen(),
                            ),
                          ).then((_) => setState(() {}));
                        },
                      ),
                      if (cartItems.isNotEmpty)
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            '${cartItems.length}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Hii", style: TextStyle(fontSize: 20)),
              const Text(
                "Good Evening!",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Banner slider
              SizedBox(
                height: 200,
                child: PageView.builder(
                  itemCount: bannerImages.length,
                  onPageChanged: (index) =>
                      setState(() => _currentBanner = index),
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(bannerImages[index], fit: BoxFit.cover),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(bannerImages.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentBanner == index
                          ? Colors.black
                          : Colors.grey.shade300,
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),

              sectionHeader("Categories", 70),
              const SizedBox(height: 12),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(
                            categories[index]['image']!,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          categories[index]['name']!,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                ),
              ),
              const SizedBox(height: 20),

              sectionHeader("Trending", 50),
              const SizedBox(height: 12),
              SizedBox(
                height: 280,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,

                  itemCount: trendingProducts.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final item = trendingProducts[index];
                    final double price = double.parse(
                      item['price']!.replaceAll("₹", "").trim(),
                    );
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailScreen(
                              title: item['title']!,
                              image: item['image']!,
                              price: price,
                            ),
                          ),
                        ).then((_) => setState(() {}));
                      },
                      child: productCard(item),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
              sectionHeader("Brands", 40),
              const SizedBox(height: 12),
              SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: BrandImages.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (c, i) {
                    return Container(
                      width: 190,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[300],
                      ),
                      child: Image.asset(BrandImages[i], fit: BoxFit.cover),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
              sectionHeader("Food Brands", 70),
              const SizedBox(height: 12),
              SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: FoodsImages.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (c, i) {
                    return Container(
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200],
                      ),
                      child: Image.asset(FoodsImages[i], fit: BoxFit.contain),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
              sectionHeader("Pets Food", 70),
              const SizedBox(height: 12),
              SizedBox(
                height: 280,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: PetsFood.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final item = PetsFood[index];
                    final double price = double.parse(
                      item['price']!.replaceAll("₹", "").trim(),
                    );
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailScreen(
                              title: item['title']!,
                              image: item['image']!,
                              price: price,
                            ),
                          ),
                        ).then((_) => setState(() {}));
                      },
                      child: productCard(item),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productCard(Map<String, String> item) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(item['image']!, height: 100, fit: BoxFit.cover),
          const SizedBox(height: 8),
          Text(
            item['title']!,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(item['price']!, style: const TextStyle(color: Colors.red)),
          const Spacer(),
          GestureDetector(
            onTap: () {
              final double price = double.parse(
                item['price']!.replaceAll("₹", "").trim(),
              );
              setState(() {
                final idx = cartItems.indexWhere(
                  (p) => p.title == item['title']!,
                );
                if (idx != -1) {
                  cartItems[idx].quantity++;
                } else {
                  cartItems.add(
                    Product(
                      title: item['title']!,
                      image: item['image']!,
                      price: price,
                    ),
                  );
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${item['title']} added!")),
              );
            },
            child: Container(
              width: double.infinity,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.red, Colors.pink],
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Text(
                "Add to Cart",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionHeader(String title, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 3,
              width: width,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ],
        ),
        const Text("View all", style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
