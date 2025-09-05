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


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_garbage/screens/comment.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home.dart';
import 'notifs/noti_service.dart';

final GoogleSignIn googleSignIn = GoogleSignIn(
  serverClientId: '1054235009294-au7ct1olifehpfabqmo068d2pshrba8p.apps.googleusercontent.com',
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://jkchajftfotdjrnfeuwv.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImprY2hhamZ0Zm90ZGpybmZldXd2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY5OTQzOTksImV4cCI6MjA3MjU3MDM5OX0.5CDJ6bq_VIM-a2pD7W3Asvpiu_vLvqG7F3vM6oyewpQ',
  );


  //Init notifications
  NotiService().initNotification();
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

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
  String? _userId;
  final _formKey = GlobalKey<FormState>();
  String email = "", password = "";

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      }
    });
  }
  @override
  void initState() {
    _setupAuthListener();
    super.initState();

    // supabase.auth.onAuthStateChange.listen((data) {
    //   setState(() {
    //     _userId = data.session?.user.id;
    //   });
    // });


  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     body: Center(
  //       child: SingleChildScrollView(
  //         padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
  //         child: Form(
  //           key: _formKey,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: [
  //               const Icon(Icons.lock_outline, size: 100, color: Colors.blue),
  //               const SizedBox(height: 20),
  //               const Text("Login",
  //                   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
  //               const SizedBox(height: 30),
  //
  //               // Email field
  //               TextFormField(
  //                 decoration: InputDecoration(
  //                     labelText: "Email", border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(20),
  //                 )),
  //                 validator: (value) =>
  //                 value!.isEmpty ? "Enter email" : null,
  //                 onSaved: (value) => email = value!,
  //               ),
  //               const SizedBox(height: 15),
  //
  //               // Password field
  //               TextFormField(
  //                 decoration: InputDecoration(
  //                     labelText: "Password", border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(20),
  //                 )),
  //                 obscureText: true,
  //                 validator: (value) =>
  //                 value!.isEmpty ? "Enter password" : null,
  //                 onSaved: (value) => password = value!,
  //               ),
  //               const SizedBox(height: 25),
  //
  //               // Login button
  //               ElevatedButton(
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: AppColors.primary,
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(20)),
  //                     minimumSize: const Size.fromHeight(50)),
  //                 onPressed: () async {
  //                   // /// TODO: update the Web client ID with your own.
  //                   // ///
  //                   // /// Web Client ID that you registered with Google Cloud.
  //                   // const webClientId = '1054235009294-au7ct1olifehpfabqmo068d2pshrba8p.apps.googleusercontent.com';
  //                   //
  //                   // /// TODO: update the iOS client ID with your own.
  //                   // ///
  //                   // /// iOS Client ID that you registered with Google Cloud.
  //                   // const iosClientId = '1054235009294-o89m4otg3ic1kssk6kvvv4ujc84jlatb.apps.googleusercontent.com';
  //                   //
  //                   // // Google sign in on Android will work without providing the Android
  //                   // // Client ID registered on Google Cloud.
  //                   //
  //                   // final GoogleSignIn googleSignIn = GoogleSignIn(
  //                   //   serverClientId: webClientId,
  //                   // );
  //                   final googleUser = await googleSignIn.signIn();
  //                   final googleAuth = await googleUser!.authentication;
  //                   final accessToken = googleAuth.accessToken;
  //                   final idToken = googleAuth.idToken;
  //
  //                   if (accessToken == null) {
  //                     throw 'No Access Token found.';
  //                   }
  //                   if (idToken == null) {
  //                     throw 'No ID Token found.';
  //                   }
  //
  //                   await supabase.auth.signInWithIdToken(
  //                     provider: OAuthProvider.google,
  //                     idToken: idToken,
  //                     accessToken: accessToken,
  //                   );
  //                   // if (_formKey.currentState!.validate()) {
  //                   //   _formKey.currentState!.save();
  //                   //   Navigator.pushAndRemoveUntil(context,
  //                   //       MaterialPageRoute(builder: (_) => const Home()), (Route<dynamic> route) => false,);
  //                   //   ScaffoldMessenger.of(context).showSnackBar(
  //                   //       const SnackBar(content: Text("Logging in...")));
  //                   // }
  //                 },
  //                 child: const Text("Login",
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontWeight: FontWeight.bold,
  //                 ),),
  //               ),
  //
  //               const SizedBox(height: 15),
  //
  //               // Go to signup
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.push(context,
  //                       MaterialPageRoute(builder: (_) => const SignUpScreen()));
  //                 },
  //                 child: const Text("Don’t have an account? Sign Up",
  //                 style: TextStyle(
  //                   color: Colors.black
  //                 ),),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 192, 30),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Image(image: AssetImage("assets/icons/hive_logo.png"), height: 200,),
                const SizedBox(height: 20),
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),


                // ✅ Google Sign-In Button replaces email & password
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  icon: Image.asset(
                    "assets/icons/google.png",
                    height: 24,
                  ),
                  label: const Text(
                    "Sign in with Google",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    final navigator = Navigator.of(context);

                    unawaited(showDialog(context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return Center(child: CircularProgressIndicator());
                        }
                    ));
                    final googleUser = await googleSignIn.signIn();
                    final googleAuth = await googleUser!.authentication;
                    final accessToken = googleAuth.accessToken;
                    final idToken = googleAuth.idToken;

                    if (accessToken == null) {
                      throw 'No Access Token found.';
                    }
                    if (idToken == null) {
                      throw 'No ID Token found.';
                    }
                    navigator.pop();
                    await supabase.auth.signInWithIdToken(
                      provider: OAuthProvider.google,
                      idToken: idToken,
                      accessToken: accessToken,
                    );


                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}




