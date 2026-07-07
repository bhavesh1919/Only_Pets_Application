// lib/models.dart
import 'package:flutter/material.dart';

class Product {
  String title;
  String image; // asset path
  double price;
  int quantity;

  Product({
    required this.title,
    required this.image,
    required this.price,
    this.quantity = 1,
  });
}

class Order {
  final String orderId;
  final List<Product> products;
  final String firstName;
  final String lastName;
  final String address;
  final String city;
  final String postcode;
  final String phone;
  final String email;
  final double total;
  final DateTime date;

  Order({
    required this.orderId,
    required this.products,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.city,
    required this.postcode,
    required this.phone,
    required this.email,
    required this.total,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'imageUrl': products.isNotEmpty ? products[0].image : '',
      'productName': products.isNotEmpty ? products[0].title : '',
      'price': total,
      'products': products
          .map((p) => {'title': p.title, 'image': p.image, 'price': p.price, 'quantity': p.quantity})
          .toList(),
      'customer': {
        'firstName': firstName,
        'lastName': lastName,
        'address': address,
        'city': city,
        'postcode': postcode,
        'phone': phone,
        'email': email,
      },
      'date': date.toIso8601String(),
    };
  }
}

// Global lists (in-memory)
List<Product> cartItems = [];
List<Order> orders = [];



