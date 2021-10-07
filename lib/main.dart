import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Screens/Home.dart';
import 'package:newsapp/Screens/Login.dart';
import 'package:newsapp/Screens/Profile.dart';
import 'package:newsapp/Screens/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String emailFirebasse = "", username = "", address = "";
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News App',
            theme: ThemeData(),
            initialRoute: FirebaseAuth.instance.currentUser == null
                ? "login_screen"
                : "Home_screen",
            routes: {
              "login_screen": (context) => Login(),
              "signUp_screen": (context) => SignUp(),
              "Home_screen": (context) => Home(true),
              "profile_screen": (context) => Profile(),
            },
          );
        }

        return Container();
      },
    );
  }
}
