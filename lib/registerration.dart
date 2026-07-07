import 'package:flutter/material.dart';
import 'package:only_pets/login.dart';
import 'package:only_pets/login api/rgistrationapi.dart'; // correct name

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

final _formKey = GlobalKey<FormState>();

final TextEditingController nameController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passController = TextEditingController();

class _RegistrationState extends State<Registration> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              // HEADER
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 208, 84, 76),
                  image: DecorationImage(
                    image: AssetImage('assets/img/paw_bg.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Image.asset('assets/img/logo.png', height: 170),
              SizedBox(height: 20),

              Text("Register Now!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),

              // NAME FIELD
              field("Enter Full Name", Icons.person, nameController,
                  (v) => v!.isEmpty ? "Enter name" : null),

              field("Enter Phone Number", Icons.phone, phoneController,
                  (v) => v!.length != 10 ? "Enter valid phone" : null,
                  keyboard: TextInputType.phone),

              field("Enter Email", Icons.email, emailController,
                  (v) => !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v!)
                      ? "Enter valid email"
                      : null),

              field("Password", Icons.lock, passController,
                  (v) => v!.length < 6 ? "Min 6 chars" : null,
                  obscure: true),

              SizedBox(height: 25),

              // REGISTER BUTTON
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.red, Colors.pink]),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton(
                  onPressed: loading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);

                            bool success = await RegisterApi.registerUser(
                              nameController.text,
                              phoneController.text,
                              emailController.text,
                              passController.text,
                            );

                            setState(() => loading = false);

                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text("Registration Successful!")),
                              );
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginPage()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("Registration Failed!")),
                              );
                            }
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: loading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'REGISTER',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),

              SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()),
                  );
                },
                child: Text("Already have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget field(String hint, IconData icon, controller, validator,
      {bool obscure = false, keyboard = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboard,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hint,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
        validator: validator,
      ),
    );
  }
}
