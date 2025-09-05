import 'package:flutter/material.dart';
import 'package:social_garbage/colors_theme/color.dart';
import 'package:social_garbage/home.dart';
import 'package:social_garbage/screens/auth/signup_screen.dart';
import 'package:social_garbage/services/auth_service.dart';
import 'package:social_garbage/services/api_client.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = "", password = "";

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
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.lock_outline, size: 100, color: Colors.blue),
                // TO DO: add Hive logo here
                const SizedBox(height: 20),
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                // Email
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? "Enter email" : null,
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
                  validator: (value) =>
                  value!.isEmpty ? "Enter password" : null,
                  onSaved: (value) => password = value!,
                ),
                const SizedBox(height: 25),

                // Login Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      try {
                        await _authService.login(
                          email: email,
                          password: password,
                        );

                        // Navigate to Home after successful login
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const Home()),
                              (route) => false,
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Login failed: $e")),
                        );
                      }
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 15),

                // Go to signup
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignUpScreen()),
                    );
                  },
                  child: const Text(
                    "Don’t have an account? Sign Up",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
