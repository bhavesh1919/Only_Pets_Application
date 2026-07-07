import 'package:flutter/material.dart';
import 'package:only_pets/HomePage/homepage.dart';
import 'package:only_pets/Product%20Screen/productScreen.dart';
import 'package:only_pets/bottamNavbar.dart';
import 'package:only_pets/login.dart';
import 'package:only_pets/splashCreen.dart';
import 'package:window_manager/window_manager.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Only Pets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}