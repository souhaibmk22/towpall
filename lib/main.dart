// ignore_for_file: prefer_const_constructors

import 'package:carihio/pages/home.dart';
import 'package:carihio/pages/select_location.dart';
import 'package:carihio/pages/profile/settings.dart';
import 'package:carihio/pages/profile/update_profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'let me start',
      home: homescreen(),
    );
  }
}
