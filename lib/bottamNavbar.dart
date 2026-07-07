// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:only_pets/CategoriesScreen/categoriesScreen.dart';
// import 'package:only_pets/HomePage/homepage.dart';
// import 'package:only_pets/Product%20Screen/productScreen.dart';
// import 'package:only_pets/Profile%20Screen/profilescreen.dart';
// import 'package:only_pets/favouriteScreen/favourite.dart';


// class BottomNavigatorBar extends StatefulWidget {
//   const BottomNavigatorBar({super.key});

//   @override
//   State<BottomNavigatorBar> createState() => _BottomNavigatorBarState();
// }

// class _BottomNavigatorBarState extends State<BottomNavigatorBar> {
//   int _selectedIndex = 0;

//   // Mock data for categoryList (replace with your real local data)
//   final List<String> categoryList = ["Dogs", "Cats", "Rabbit"];

//   late final List<Widget> pageOptions;

//   @override
//   void initState() {
//     super.initState();
//     pageOptions = [
//       HomeScreen(),
//       ProductScreen(),
//       FavouriteScreen(),
//        Profilescreen(),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: CurvedNavigationBar(
//         index: _selectedIndex,
//         backgroundColor: Colors.white,
//         color: Colors.pink.shade50,
//         animationDuration: const Duration(milliseconds: 300),
//         buttonBackgroundColor: Colors.pink.shade50,
//         items: const [
//           Icon(CupertinoIcons.home),
//           Icon(CupertinoIcons.square_grid_2x2),
//           Icon(CupertinoIcons.heart),
//           Icon(CupertinoIcons.person),
//         ],
//         onTap: (index) => setState(() {
//           _selectedIndex = index;
//         }),
//       ),
//       body: pageOptions[_selectedIndex]
//     );
//   }

//   // Callback for Dashboard -> Category navigation
//   void onCategoryTap(int index) {
//     setState(() {
//       _selectedIndex = 1; // Switch to category page
//     });
//   }
// }


import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:only_pets/CategoriesScreen/categoriesScreen.dart';
import 'package:only_pets/HomePage/homepage.dart';
import 'package:only_pets/Product%20Screen/productScreen.dart';
import 'package:only_pets/Profile%20Screen/profilescreen.dart';
import 'package:only_pets/favouriteScreen/favourite.dart';

class BottomNavigatorBar extends StatefulWidget {
  final Map<String, dynamic> userData; // Pass user data from login

  const BottomNavigatorBar({super.key, required this.userData});

  @override
  State<BottomNavigatorBar> createState() => _BottomNavigatorBarState();
}

class _BottomNavigatorBarState extends State<BottomNavigatorBar> {
  int _selectedIndex = 0;

  late final List<Widget> pageOptions;

  @override
  void initState() {
    super.initState();
    pageOptions = [
      HomeScreen(),
      ProductScreen(),
      FavouriteScreen(),
      Profilescreen(userData: widget.userData), // Pass logged-in user
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: Colors.white,
        color: Colors.pink.shade50,
        animationDuration: const Duration(milliseconds: 300),
        buttonBackgroundColor: Colors.pink.shade50,
        items: const [
          Icon(CupertinoIcons.home),
          Icon(CupertinoIcons.square_grid_2x2),
          Icon(CupertinoIcons.heart),
          Icon(CupertinoIcons.person),
        ],
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
      ),
      body: pageOptions[_selectedIndex],
    );
  }
}