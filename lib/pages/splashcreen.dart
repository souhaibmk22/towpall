// ignore_for_file: avoid_unnecessary_containers

import 'package:carihio/pages/select_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'simplephonelogin.dart';
import 'package:carihio/main.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateto();
  }

  _navigateto() async {
    await Future.delayed(Duration(milliseconds: 5000), () {});
    Navigator.pushReplacementNamed(context, "checking");
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF39F5A),
        body: Stack(children: [
          Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.43,
                left: MediaQuery.of(context).size.width * 0.28,
              ),
              child: Text(
                "Tow",
                style: GoogleFonts.racingSansOne(
                    textStyle:
                        TextStyle(fontSize: 45, fontWeight: FontWeight.w500)),
              )),
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.474,
                  left: MediaQuery.of(context).size.width * 0.47),
              child: Text("Pal",
                  style: GoogleFonts.racingSansOne(
                      textStyle: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)))),
          Center(
              child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.7),
                  child: Text(
                    "Service de Dépannage",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500)),
                  )))
        ]));
  }
}
