import 'package:flutter/material.dart';
import 'package:social_garbage/colors_theme/color.dart';
import 'package:social_garbage/services/auth_service.dart';
import 'package:social_garbage/services/api_client.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String name = "", email = "", password = "", gender = "male";
  int age = 0;

  late final AuthService _authService;

  @override
  void initState() {
    super.initState();
    // initialize AuthService with ApiClient
    _authService = AuthService(ApiClient(baseUrl: "https://your-api-base-url.com"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person_add_alt, size: 100, color: Colors.blue),
                const SizedBox(height: 20),
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                // Name
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? "Enter name" : null,
                  onSaved: (value) => name = value!,
                ),
                const SizedBox(height: 15),

                // Email
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? "Enter email" : null,
                  onSaved: (value) => email = value!,
                ),
                const SizedBox(height: 15),

                // Password
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) => value!.isEmpty ? "Enter password" : null,
                  onSaved: (value) => password = value!,
                ),
                const SizedBox(height: 15),

                // Age
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Age",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? "Enter age" : null,
                  onSaved: (value) => age = int.parse(value!),
                ),
                const SizedBox(height: 15),

                // Gender Dropdown
                DropdownButtonFormField<String>(
                  value: gender,
                  decoration: InputDecoration(
                    labelText: "Gender",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: "male", child: Text("Male")),
                    DropdownMenuItem(value: "female", child: Text("Female")),
                    DropdownMenuItem(value: "other", child: Text("Other")),
                  ],
                  onChanged: (value) => setState(() => gender = value!),
                ),
                const SizedBox(height: 25),

                // Sign Up button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      try {
                        await _authService.signUp(
                          name: name,
                          email: email,
                          age: age,
                          gender: gender,
                          password: password,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Signup successful! Please login."),
                          ),
                        );
                        Navigator.pop(context); // back to login
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Signup failed: $e")),
                        );
                      }
                    }
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 15),

                // Back to login
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Already have an account? Login",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
