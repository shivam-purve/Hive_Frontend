// import 'package:flutter/material.dart';
// import 'package:social_garbage/screens/comment.dart';
//
// import 'home.dart';
// import 'notifs/noti_service.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   //Init notifications
//   NotiService().initNotification();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//         routes: {
//           '/comment': (context) => const Comment(),
//         },
//       home: Home()
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:social_garbage/colors_theme/color.dart';
import 'package:social_garbage/screens/comment.dart';

import 'home.dart';
import 'notifs/noti_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //Init notifications
  NotiService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/comment': (context) => const Comment(),
        },
        home: LoginScreen()
    );
  }
}


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = "", password = "";

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
                //TODO: Add Hive Logo Here
                const SizedBox(height: 20),
                const Text("Login",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),

                // Email field
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Email", border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
                  validator: (value) =>
                  value!.isEmpty ? "Enter email" : null,
                  onSaved: (value) => email = value!,
                ),
                const SizedBox(height: 15),

                // Password field
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Password", border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
                  obscureText: true,
                  validator: (value) =>
                  value!.isEmpty ? "Enter password" : null,
                  onSaved: (value) => password = value!,
                ),
                const SizedBox(height: 25),

                // Login button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // TODO: Add login logic
                      Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (_) => const Home()), (Route<dynamic> route) => false,);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Logging in...")));
                    }
                  },
                  child: const Text("Login",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),),
                ),

                const SizedBox(height: 15),

                // Go to signup
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const SignUpScreen()));
                  },
                  child: const Text("Don’t have an account? Sign Up",
                    style: TextStyle(
                        color: Colors.black
                    ),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//SIGNUP SCREEN
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = "", email = "", password = "";

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
                const Text("Sign Up",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),

                // Name
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Name", border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
                  validator: (value) =>
                  value!.isEmpty ? "Enter name" : null,
                  onSaved: (value) => name = value!,
                ),
                const SizedBox(height: 15),

                // Email
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Email", border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
                  validator: (value) =>
                  value!.isEmpty ? "Enter email" : null,
                  onSaved: (value) => email = value!,
                ),
                const SizedBox(height: 15),

                // Password
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Password", border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
                  obscureText: true,
                  validator: (value) =>
                  value!.isEmpty ? "Enter password" : null,
                  onSaved: (value) => password = value!,
                ),
                const SizedBox(height: 25),

                // Sign Up button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // TODO: Add signup logic

                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Signing up...")));
                    }
                  },
                  child: const Text("Sign Up", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),),
                ),

                const SizedBox(height: 15),

                // Back to login
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Already have an account? Login",
                    style: TextStyle(
                        color: Colors.black
                    ),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}