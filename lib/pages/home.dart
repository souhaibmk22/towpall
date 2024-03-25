// ignore_for_file: avoid_unnecessary_containers

import 'package:carihio/pages/select_location.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
        child: Center(
            child: Column(
          children: [
            Text(
              "splash screen win raha ",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      backgroundColor: Colors.white)),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => selecte_location()));
                },
                child: Text(
                  "go to the first page ",
                  style: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                ))
          ],
        )),
      ),
    );
  }
}
