// ignore_for_file: prefer_const_constructors

import 'package:carihio/pages/home.dart';
import 'package:carihio/pages/map_page.dart';
import 'package:carihio/pages/select_location.dart';
import 'package:carihio/pages/settings.dart';
import 'package:carihio/pages/update_profile.dart';
import 'package:carihio/pages/ChooseRolePage.dart';
import 'package:carihio/pages/Sign.dart';
import 'package:carihio/pages/Reset.dart';
import 'package:carihio/pages/savingemail.dart';
import 'package:carihio/pages/Signup.dart';
import 'package:carihio/pages/SignIn.dart';
import 'package:carihio/pages/Via.dart';
import 'package:carihio/pages/welcom.dart';
import 'package:carihio/pages/fullname.dart';
import 'package:carihio/pages/passwd.dart';
import 'package:carihio/pages/tutorial.dart';
import 'package:carihio/pages/phon_sign_in.dart';
import 'package:carihio/pages/otp_verification_screen.dart';
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
      home: welcom(),
    );
  }
}
