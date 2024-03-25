import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'fullname.dart';

class email_page extends StatefulWidget {
  const email_page({super.key});

  @override
  State<email_page> createState() => _email_pageState();
}

class _email_pageState extends State<email_page> {
  final emailcontroller = TextEditingController();
  final emailfocusednode = FocusNode();
  var emailTextAlert =
      'You will only receive your repair receipts and anything else that you agree later on.';
  Color emailTextColor = Colors.black.withOpacity(0.6);
  RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', //This is the This regular expression of an email
  );

  @override
  void dispose() {
    emailcontroller.dispose();
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
                'WHAT’S YOUR EMAIL?',
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
                    controller: emailcontroller,
                    focusNode: emailfocusednode,
                    keyboardType: TextInputType.emailAddress,
                    style:
                        GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16)),
                    cursorColor: Color(0x2ad716b0),
                    decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.black.withOpacity(0.58)))),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        emailTextAlert,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: emailTextColor)),
                      )),
                  SizedBox(
                    height: 142,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (emailRegExp.hasMatch(emailcontroller.text)) {
                          //to Verify if the input of user is a real email format
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => fullname()));
                        } else if (emailcontroller.text.isEmpty) {
                          setState(() {
                            emailTextAlert = 'Please enter your email';
                            emailTextColor = Colors.red.withOpacity(0.87);
                          });
                        } else {
                          setState(() {
                            emailTextAlert =
                                "please enter email in correct format";
                          });
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
