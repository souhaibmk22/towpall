import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ChooseRolePage.dart';

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
  Color MainColor = Color.fromARGB(255,243, 159, 90); //icon,text,border
  Color TextColor = Colors.black.withOpacity(0.6);
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
                'WHAT’S YOUR NAME?',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: MainColor),
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
                                color: TextColor))),
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
                                color: TextColor))),
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
                    height: 5,
                  ),
                  Text(
          'First name is desplayed to whom you share a repair with .Last name is used to generate invoices',
          style: TextStyle(fontSize: 16, color: TextColor, fontWeight: FontWeight.w700),
        ),         
               SizedBox(
                    height: 107,
                  ), 
                  Container(
  decoration: BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.25), 
        blurRadius: 4, 
        offset: Offset(0, 4), 
        spreadRadius: 0,
      ),
    ],
  ),
                 child: ElevatedButton(
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
                          backgroundColor: MainColor),
                      child: Text(
                        'Confirm',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ))
                  )
                          
                ],
              )
              )
        ],
      ),
    );
  }
}
