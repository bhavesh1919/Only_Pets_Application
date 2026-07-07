import 'dart:io';
import 'package:flutter/material.dart';
import 'package:only_pets/OrdersScreen/Orderscreen.dart';
import 'package:only_pets/Profile Screen/editpro.dart';
import 'package:only_pets/login.dart';
import '/my_orders.dart';

class Profilescreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const Profilescreen({super.key, required this.userData});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  late String _name;
  late String _email;
  late String _phone;
  String _imagePath = '';

  @override
  void initState() {
    super.initState();
    _name = widget.userData['name'] ?? "User Name";
    _email = widget.userData['email'] ?? "User Email";
    _phone = widget.userData['phone'] ?? "User Phone";
    _imagePath = widget.userData['imagePath'] ?? '';
  }

  ImageProvider? get profileImage {
    if (_imagePath.isNotEmpty) {
      return FileImage(File(_imagePath));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Profile",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // PROFILE CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.red[300],
                    backgroundImage: profileImage,
                    child: profileImage == null
                        ? Text(
                            _name.isNotEmpty ? _name.substring(0, 2) : "UP",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 16),

                  // USER NAME + EDIT
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () async {
                            final updatedData = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditProfileScreen(
                                  userData: {
                                    "name": _name,
                                    "email": _email,
                                    "phone": _phone,
                                    "imagePath": _imagePath,
                                  },
                                ),
                              ),
                            );

                            if (updatedData != null &&
                                updatedData is Map<String, dynamic>) {
                              setState(() {
                                _name = updatedData['name'] ?? _name;
                                _email = updatedData['email'] ?? _email;
                                _phone = updatedData['phone'] ?? _phone;
                                _imagePath =
                                    updatedData['imagePath'] ?? _imagePath;
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                "Edit Profile",
                                style: TextStyle(
                                    color: Colors.red[300], fontSize: 14),
                              ),
                              const SizedBox(width: 4),
                              Icon(Icons.edit,
                                  size: 16, color: Colors.red[300]),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            // EMAIL
            _infoTile("Email", _email, Icons.email),
            const Divider(color: Colors.red),

            // PHONE
            _infoTile("Phone No.", _phone, Icons.phone_android),
            const Divider(color: Colors.red),

            // ORDERS
            GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MyOrders(
          userId: "1", // 👈 pass logged-in user id
        ),
      ),
    );
  },
  child: _menuTile("Orders", Icons.list_alt),
),
            // GestureDetector(
            //   onTap: () {
            //    Navigator.push(context,
            //   MaterialPageRoute(builder: (_) => OrdersScreen(orderData: {})));

            //   },
            //   child: _menuTile("Orders", Icons.list_alt),
            // ),
            const Divider(color: Colors.red),

            // LOGOUT
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              },
              child: _menuTile("Sign Out", Icons.logout),
            ),
            const Divider(color: Colors.red),
          ],
        ),
      ),
    );
  }

  // INFO TILE
  Widget _infoTile(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Colors.red[300]),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.red[300],
                    fontWeight: FontWeight.w600),
              ),
              Text(
                value,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          )
        ],
      ),
    );
  }

  // MENU TILE
  Widget _menuTile(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Colors.red[300]),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.red[300],
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Icon(Icons.arrow_forward_ios,
              size: 18, color: Colors.red[300]),
        ],
      ),
    );
  }
}
