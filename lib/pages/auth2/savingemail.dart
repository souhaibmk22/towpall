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
  Color MainColor = Color.fromARGB(255,243, 159, 90); //icon,text,border
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
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
      top: MediaQuery.of(context).size.height * 0.0989,
      left: MediaQuery.of(context).size.width * 0.0605,
      child: Container(
    width: 45.0,
    height: 45.0,
    decoration: BoxDecoration(
    color: Color.fromARGB(30, 243, 159, 90), 
    borderRadius: BorderRadius.circular(15.0), 
  ),
    
      child: Icon(
        Icons.chevron_left,
        color: MainColor,
        size: 40.0,
      ),
    ),    
  ),      
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1641,
                  left: MediaQuery.of(context).size.width * 0.0605),
              child: Text(
                'WHAT’S YOUR EMAIL?',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: MainColor),
                    height: 1.0),
              )
              ),
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
                          backgroundColor: MainColor ),
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
