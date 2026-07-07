import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:only_pets/bottamNavbar.dart';
import 'package:lottie/lottie.dart';
import 'package:only_pets/onboardingscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splash();
  }

  splash() async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OnboardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ColorFiltered(
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          child: Lottie.asset(
            "assets/img/Splash_Screen_animation.json",
            height: 200,
            width: 200,
          ),
        ),
      ),
    );
  }
}