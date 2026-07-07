import 'package:flutter/material.dart';
import 'dart:async';

import 'package:only_pets/login.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  Timer? _autoSwipeTimer;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/img/dogFpic1.jpg",
      "title": "Welcome to our app",
      "subtitle": "With our app you make life of our funny friends happier",
    },
    {
      "image": "assets/img/catFpic.png",
      "title": "Social for your pet",
      "subtitle":
          "Pawsitively together pet owners and animal lovers from all over the country!",
    },
    {
      "image": "assets/img/dogFpic2.jpg",
      "title": "Find and buy attractive items",
      "subtitle":
          "Will help you order the needed items as soon as you are at home",
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _autoSwipeTimer?.cancel(); // Cancel timer
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _autoSwipeTimer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      int nextPage = (_currentPage + 1) % onboardingData.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemCount: onboardingData.length,
        itemBuilder: (context, index) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(onboardingData[index]['image']!, fit: BoxFit.cover),
              Container(color: Colors.black.withOpacity(0.4)),
              Positioned(
                bottom: 35,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      onboardingData[index]['title']!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      onboardingData[index]['subtitle']!,
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white, width: 1.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: GestureDetector(
                            //onTap: _onStartPressed,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Start",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 45,
                left: 20,
                child: Row(
                  children: List.generate(onboardingData.length, (dotIndex) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        shape: BoxShape.circle,
                        color: _currentPage == dotIndex
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
