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
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:social_garbage/screens/comment.dart';
import 'package:social_garbage/services/api_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
H// import 'package:uni_links/uni_links.dart';
import 'home.dart';
import 'notifs/noti_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoogleSignIn googleSignIn = GoogleSignIn(
  serverClientId: '1054235009294-au7ct1olifehpfabqmo068d2pshrba8p.apps.googleusercontent.com',
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://urgjympujyzkghpshrct.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVyZ2p5bXB1anl6a2docHNocmN0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTYxOTgyNTQsImV4cCI6MjA3MTc3NDI1NH0.NbuZIxH9-jTBoL9OCML0bxUlplY7pzGXA25orw9nhIo',
    // url: 'https://jkchajftfotdjrnfeuwv.supabase.co',
    // anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImprY2hhamZ0Zm90ZGpybmZldXd2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY5OTQzOTksImV4cCI6MjA3MjU3MDM5OX0.5CDJ6bq_VIM-a2pD7W3Asvpiu_vLvqG7F3vM6oyewpQ',
  );


  //Init notifications
  NotiService().initNotification();
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;
GoogleSignInAccount? googleUser;
GoogleSignInAuthentication? googleAuth;

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
  // StreamSubscription? _sub;
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
    // _sub = uriLinkStream.listen((Uri? uri) {
    //   if (uri != null && uri.scheme == 'myapp' && uri.host == 'login-callback') {
    //     final accessToken = uri.queryParameters['access_token'];
    //     final idToken = uri.queryParameters['id_token'];
    //     // Use these tokens to log in your app / backend
    //   }
    // });
    // supabase.auth.onAuthStateChange.listen((data) {
    //   setState(() {
    //     _userId = data.session?.user.id;
    //   });
    // });
  }

  @override
  void dispose() {
    // _sub?.cancel();
    super.dispose();
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

                    // try {
                    //   // 1. Trigger Google OAuth sign-in via Supabase
                    //   await supabase.auth.signInWithOAuth(
                    //     OAuthProvider.google,
                    //     // redirectTo: 'yourapp://login-callback', // optional
                    //   );
                    //
                    //   // 2. Get the current session
                    //   final session = supabase.auth.currentSession;
                    //
                    //   // 3. Check if the user signed in successfully
                    //   if (session == null) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(content: Text("Sign-in process was cancelled.")),
                    //     );
                    //     return;
                    //   }
                    //
                    //   // 4. Get the Supabase access token
                    //   final supabaseAccessToken = session.accessToken;
                    //   if (supabaseAccessToken == null) {
                    //     throw 'Error: Could not retrieve session token after sign-in.';
                    //   }
                    //
                    //   // 5. Optional: Pop a loading dialog if you showed one
                    //   if (Navigator.canPop(context)) {
                    //     Navigator.of(context).pop();
                    //   }
                    //
                    //   // 6. Make the POST request to your backend with the Supabase JWT
                    //   final url = Uri.parse("$kBaseUrl/user/defaults");
                    //   final response = await http.post(
                    //     url,
                    //     headers: {
                    //       "Content-Type": "application/json",
                    //       "Authorization": "Bearer $supabaseAccessToken",
                    //     },
                    //   );
                    //
                    //   // 7. Show the result in a SnackBar
                    //   if (!context.mounted) return;
                    //   if (response.statusCode == 200) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(content: Text("✅ Successfully set up user!")),
                    //     );
                    //   } else {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(content: Text("❌ Failed to create post: ${response.body}")),
                    //     );
                    //   }
                    // } catch (e) {
                    //   // 8. Handle errors
                    //   if (!context.mounted) return;
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text("❌ An error occurred: $e")),
                    //   );
                    // }


                    // 1️⃣ Start OAuth flow
                    await supabase.auth.signInWithOAuth(
                      OAuthProvider.google,
                      redirectTo: "com.hive://login-callback",
                    );

// 2️⃣ Get the current session after sign-in
                    final session = supabase.auth.currentSession;

// 3️⃣ Access Supabase JWT safely
                    final supabaseToken = session?.accessToken;

                    if (supabaseToken == null) {
                      throw 'Error: Could not retrieve Supabase session token';
                    }

// 4️⃣ Use supabaseToken to call backend
                    final response = await http.post(
                      Uri.parse("$kBaseUrl/user/defaults"),
                      headers: {
                        "Authorization": "Bearer $supabaseToken",
                        "Content-Type": "application/json",
                      },
                    );

                    // final navigator = Navigator.of(context);
                    //
                    // unawaited(showDialog(context: context,
                    //     barrierDismissible: false,
                    //     builder: (_) {
                    //       return Center(child: CircularProgressIndicator());
                    //     }
                    // ));
                    // final googleUser = await googleSignIn.signIn();
                    // final googleAuth = await googleUser!.authentication;
                    // final accessToken = googleAuth.accessToken;
                    // final idToken = googleAuth.idToken;
                    // final prefs = await SharedPreferences.getInstance();
                    // await prefs.setString('accessToken', accessToken!);
                    // if (idToken == null) {
                    //   throw 'No ID Token found.';
                    // }
                    // navigator.pop();
                    //
                    // final url = Uri.parse("$kBaseUrl/user/defaults");
                    // final response = await http.post(
                    //   url,
                    //   headers: {
                    //     "Content-Type": "application/json",
                    //     "Authorization": "Bearer ${googleAuth.accessToken}", // send in header
                    //   },
                    // );
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text(" post: $accessToken")));
                    // await supabase.auth.signInWithIdToken(
                    //   provider: OAuthProvider.google,
                    //   idToken: idToken,
                    //   accessToken: accessToken,
                    // );
                    //
                    //
                    //
                    // if (response.statusCode == 200) {
                    //   final data = jsonDecode(response.body);
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text("❌ Failed to create post: ${response.statusCode}")),
                    //   );
                    //   return data; // could be { access_token, user, ... }
                    // } else {
                    //   throw Exception("Login failed: ${response.body}");
                    // }


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

class UserService {
  final SupabaseClient _client = supabase;

  /// Create or update user profile when they log in
  Future<void> upsertUser({
    required String uid,
    required String fullName,
    required String email,
    String? username,
    String? profilePicUrl,
    String? bio,
  }) async {
    final response = await _client.from('users').upsert({
      'uid': uid,
      'full_name': fullName,
      'email': email,
      if (username != null) 'username': username,
      if (profilePicUrl != null) 'profile_pic_url': profilePicUrl,
      if (bio != null) 'bio': bio,
    });

    // Supabase just returns the inserted/updated row(s)
    if (response == null) {
      throw Exception("Failed to upsert user");
    }
  }

  /// Fetch user profile
  Future<Map<String, dynamic>?> getUser(String uid) async {
    final response = await _client
        .from('users')
        .select()
        .eq('uid', uid)
        .maybeSingle();

    return response;
  }
}



