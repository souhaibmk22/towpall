// ignore_for_file: prefer_const_constructors

import 'package:carihio/pages/home.dart';
import 'package:carihio/pages/select_location.dart';
import 'package:carihio/pages/ChooseRolePage.dart';
import 'package:carihio/pages/ResetPassword/Sign.dart';
import 'package:carihio/pages/ResetPassword/Reset.dart';
import 'package:carihio/pages/auth2/savingemail.dart';
import 'package:carihio/pages/authentication/Signup.dart';
import 'package:carihio/pages/authentication/SingIn.dart';
import 'package:carihio/pages/ResetPassword/via.dart';
import 'package:carihio/pages/welcom.dart';
import 'package:carihio/pages/auth2/fullname.dart';
import 'package:carihio/pages/auth2/passwd.dart';
import 'package:carihio/pages/tutorial.dart';
import 'package:carihio/pages/auth2/phon_sign_in.dart';
import 'package:carihio/pages/auth2/otp_verification_screen.dart';
import 'package:carihio/pages/profile/settings.dart';
import 'package:carihio/pages/profile/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
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
      title: 'let me start',
      home: Reset(),
    );
  }
}
