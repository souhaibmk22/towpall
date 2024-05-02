// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:carihio/firebase_options.dart';
import 'package:carihio/pages/phone_auth.dart';
import 'package:carihio/pages/select_location.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io' if (dart.library.html) 'dart:html';
import 'package:carihio/pages/map/maptesting.dart';
import 'package:carihio/pages/simplephonelogin.dart';
import 'package:carihio/pages/splashcreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, name: 'TowPal');
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TowPal',
      home: splash(),
      routes: {
        "phonesignein": (context) => PhoneSignIn(),
        "MapPage": (context) => MapPage(),
        "selecteposition": (context) => selecte_location(),
        "checking": (context) => CheckUserLoggedInOrNot()
      },
    );
  }
}

class CheckUserLoggedInOrNot extends StatefulWidget {
  const CheckUserLoggedInOrNot({super.key});

  @override
  State<CheckUserLoggedInOrNot> createState() => _CheckUserLoggedInOrNotState();
}

class _CheckUserLoggedInOrNotState extends State<CheckUserLoggedInOrNot> {
  @override
  void initState() {
    super.initState();
    checking();
  }

  Future<void> checking() async {
    bool isLoggedin = await AuthServic.isLoggedIn();
    if (isLoggedin) {
      await AuthServic.isLoggedIn();
      Navigator.pushReplacementNamed(context, "selecteposition");
    } else {
      print(isLoggedin);
      Navigator.pushReplacementNamed(context, "phonesignein");
    }
  }

  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
