
import 'package:flutter/material.dart';
import 'Payment Screen/payment_option_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final String? userId;

  const CheckoutScreen({super.key, this.userId});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postcodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    cityController.dispose();
    postcodeController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _saveDetails() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        addressController.text.isEmpty ||
        cityController.text.isEmpty ||
        postcodeController.text.isEmpty ||
        phoneController.text.isEmpty ||
        emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentOptionScreen(
          userId: widget.userId ?? "20",
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          address: addressController.text,
          city: cityController.text,
          postcode: postcodeController.text,
          phone: phoneController.text,
          email: emailController.text,
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return TextField(controller: controller, keyboardType: keyboardType, decoration: InputDecoration(labelText: label, border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)), contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout"), centerTitle: true, backgroundColor: Colors.white, foregroundColor: Colors.black),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [Expanded(child: _buildTextField("First Name", firstNameController)), const SizedBox(width: 12), Expanded(child: _buildTextField("Last Name", lastNameController))]),
          const SizedBox(height: 16),
          _buildTextField("Street Address", addressController),
          const SizedBox(height: 16),
          _buildTextField("Town / City", cityController),
          const SizedBox(height: 16),
          _buildTextField("Postcode", postcodeController, keyboardType: TextInputType.number),
          const SizedBox(height: 16),
          _buildTextField("Phone no", phoneController, keyboardType: TextInputType.phone),
          const SizedBox(height: 16),
          _buildTextField("E-Mail", emailController, keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 30),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.red, Colors.pink]), borderRadius: BorderRadius.circular(30)),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
              onPressed: _saveDetails,
              child: const Text("Save Details", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
        ]),
      ),
    );
  }
}
