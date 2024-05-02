import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../initialPages/ChooseRolePage.dart';

class fullname extends StatefulWidget {
  const fullname({super.key});

  @override
  State<fullname> createState() => _fullnameState();
}

class _fullnameState extends State<fullname> {
  final firstcontroller = TextEditingController();
  final lastcontroller = TextEditingController();
  final firstfocusednode = FocusNode();
  final lastfocusednode = FocusNode();
  var errorText = '';
  late Color errorColor = Colors.black;

  @override
  void dispose() {
    firstcontroller.dispose();
    lastcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'images/img.png',
            fit: BoxFit.fill,
          ),
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.148,
                  left: MediaQuery.of(context).size.width * 0.1),
              child: Text(
                'WHAT’S YOUR NAME?',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: Color(0xbd5036fa)),
                    height: 1.0),
              )),
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25,
                  left: MediaQuery.of(context).size.width * 0.07,
                  right: MediaQuery.of(context).size.width * 0.07),
              child: Column(
                children: [
                  TextFormField(
                    controller: firstcontroller,
                    focusNode: firstfocusednode,
                    keyboardType: TextInputType.visiblePassword,
                    style:
                        GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16)),
                    cursorColor: Color(0x2ad716b0),
                    decoration: InputDecoration(
                        hintText: 'First name',
                        hintStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.black.withOpacity(0.58)))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: lastcontroller,
                    focusNode: lastfocusednode,
                    keyboardType: TextInputType.visiblePassword,
                    style:
                        GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16)),
                    cursorColor: Color(0x2ad716b0),
                    decoration: InputDecoration(
                        hintText: 'Last name',
                        hintStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.black.withOpacity(0.58)))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    errorText,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(fontSize: 12),
                        color: errorColor,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 107,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if ((firstcontroller.text.isEmpty) |
                            (lastcontroller.text.isEmpty)) {
                          setState(() {
                            errorText = 'Please enter your full Name';
                            errorColor = Colors.red;
                          });
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChooseRolePage()));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.83, 50),
                          backgroundColor: Color(0xbd5036fa)),
                      child: Text(
                        'Confirm',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ))
                ],
              ))
        ],
      ),
    );
  }
}
