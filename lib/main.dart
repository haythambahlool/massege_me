import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:massege_me/chat.dart';
import 'package:massege_me/login.dart';
import 'package:massege_me/register.dart';
import 'package:massege_me/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MessageMe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: chat(),
      initialRoute:
          _auth.currentUser != null ? chat.screenRoute : welcome.screenRoute,
      routes: {
        welcome.screenRoute: (context) => welcome(),
        login.screenRoute: (context) => login(),
        register.screenRoute: (context) => register(),
        chat.screenRoute: (context) => chat(),
      },
    );
  }
}
