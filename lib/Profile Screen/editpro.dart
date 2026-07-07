import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  const EditProfileScreen({super.key, required this.userData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Split full name
    List<String> nameParts = widget.userData['name'].split(' ');
    _firstNameController = TextEditingController(text: nameParts.first);
    _lastNameController = TextEditingController(text: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '');
    _emailController = TextEditingController(text: widget.userData['email']);
    _phoneController = TextEditingController(text: widget.userData['phone']);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source, maxWidth: 600, maxHeight: 600);
    if (pickedFile != null) {
      setState(() => _profileImage = File(pickedFile.path));
    }
  }

  // API call to update profile
  Future<bool> _updateProfile() async {
    String id = widget.userData['id'].toString();
    String name = '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}';
    String email = _emailController.text.trim();
    String phone = _phoneController.text.trim();

    try {
      var url = Uri.parse("http://localhost/api/update_profile.php"); // your API path
      var response = await http.post(url, body: {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
      });

      var data = jsonDecode(response.body);
      if (data['status'] == 'success') return true;
      return false;
    } catch (e) {
      print("Update error: $e");
      return false;
    }
  }

  void _saveProfile() async {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("All fields required")));
      return;
    }

    bool success = await _updateProfile();
    if (success) {
      Map<String, dynamic> updatedData = {
        "id": widget.userData['id'],
        "name": '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}',
        "email": _emailController.text.trim(),
        "phone": _phoneController.text.trim(),
        "imagePath": _profileImage?.path ?? widget.userData['imagePath'] ?? ''
      };
      Navigator.pop(context, updatedData); // return updated data to profile screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(" update profile")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile"), backgroundColor: Colors.red),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _pickImage(ImageSource.gallery),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : (widget.userData['imagePath'] != null && widget.userData['imagePath'] != ''
                        ? FileImage(File(widget.userData['imagePath']))
                        : null),
                child: _profileImage == null && (widget.userData['imagePath'] == null || widget.userData['imagePath'] == '')
                    ? const Icon(Icons.person, size: 60)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            TextField(controller: _firstNameController, decoration: InputDecoration(labelText: "First Name", border: InputBorder.none)),
            TextField(controller: _lastNameController, decoration: InputDecoration(labelText: "Last Name", border: InputBorder.none)),
            TextField(controller: _emailController, decoration: InputDecoration(labelText: "Email", border: InputBorder.none)),
            TextField(controller: _phoneController, decoration: InputDecoration(labelText: "Phone", border: InputBorder.none)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Save Profile"),
            ),
          ],
        ),
      ),
    );
  }
}