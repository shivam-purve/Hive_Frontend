import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:hive/screens/comment.dart';
import 'package:hive/services/api_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:uni_links/uni_links.dart';
import 'home.dart';
import 'notifs/noti_service.dart';

final GoogleSignIn googleSignIn = GoogleSignIn(
  serverClientId:
      '1054235009294-au7ct1olifehpfabqmo068d2pshrba8p.apps.googleusercontent.com',
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://urgjympujyzkghpshrct.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVyZ2p5bXB1anl6a2docHNocmN0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTYxOTgyNTQsImV4cCI6MjA3MTc3NDI1NH0.NbuZIxH9-jTBoL9OCML0bxUlplY7pzGXA25orw9nhIo',
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
      routes:
      {'/comment': (context) => const Comment(),
        '/login': (context) => const LoginScreen()},
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // StreamSubscription? _sub;
  final _formKey = GlobalKey<FormState>();
  String email = "", password = "";

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) async {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        try {
          // Hide any loading dialog
          if (context.mounted && Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }

          // Get the Supabase access token
          final session = supabase.auth.currentSession;
          final supabaseToken = session?.accessToken;

          if (supabaseToken != null) {
            // Call backend to set up user defaults
            final response = await http.post(
              Uri.parse("$kBaseUrl/user/defaults"),
              headers: {
                "Authorization": "Bearer $supabaseToken",
                "Content-Type": "application/json",
              },
            );

            if (response.statusCode == 200) {
              // Successfully set up user, navigate to home
              if (context.mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              }
            } else {
              // Backend call failed but user is authenticated
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("⚠️ User setup failed: ${response.body}"),
                  ),
                );
                // Still navigate to home as user is authenticated
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              }
            }
          } else {
            // No token available
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("❌ Authentication failed: No token"),
                ),
              );
            }
          }
        } catch (e) {
          // Handle any errors during backend call
          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("❌ Error: $e")));
            // Still navigate to home as user is authenticated
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Home()),
            );
          }
        }
      }
    });
  }

  @override
  void initState() {
    _setupAuthListener();
    super.initState();
  }

  @override
  void dispose() {
    // _sub?.cancel();
    super.dispose();
  }

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
                const Image(
                  image: AssetImage("assets/icons/hive_logo.png"),
                  height: 200,
                ),
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
                  icon: Image.asset("assets/icons/google.png", height: 24),
                  label: const Text(
                    "Sign in with Google",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    try {
                      // Show loading indicator
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      );

                      // Start OAuth flow - this will open browser/WebView
                      await supabase.auth.signInWithOAuth(
                        OAuthProvider.google,
                        redirectTo: "com.hive://login-callback",
                      );

                      // The auth listener will handle the redirect and navigation
                      // No need to manually check session here as OAuth is asynchronous
                    } catch (e) {
                      // Hide loading indicator
                      if (context.mounted) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("❌ Login failed: $e")),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
