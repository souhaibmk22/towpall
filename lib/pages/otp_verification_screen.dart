import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'passwd.dart';

class otpScreen extends StatefulWidget {
  const otpScreen({super.key});

  @override
  State<otpScreen> createState() => _otpScreenState();
}

class _otpScreenState extends State<otpScreen> {
  final OTPcontroller = TextEditingController();
  var _explanationText;

  late Color _ColorAlert = Colors.black.withOpacity(0.6);
  Color MainColor = Color.fromARGB(255,243, 159, 90); //icon,text,border
  @override
  void dispose() {
    OTPcontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _explanationText = 'We have sent a OTP on your number';
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
        width: 45,
        height: 52,
        textStyle: GoogleFonts.poppins(
          textStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
        decoration: BoxDecoration(
            color: Color.fromRGBO(196, 22, 215, 1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.transparent)));

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
          Column(
            children: [
              Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1641,
                  left: MediaQuery.of(context).size.width * 0.0605),
              child: Text(
                'ENTER VERIFICATION CODE',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: MainColor),
                    height: 1.0),
              )
              ),
              SizedBox(
                height: 95,
              ),
              Column(children: [
                Text(
                  'ENTER OTP  ',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                          color: MainColor)),
                ),
                Text(
                  _explanationText,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: _ColorAlert)),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: Pinput(
                    length: 5,
                    defaultPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration
                            ?.copyWith(color: MainColor.withOpacity(0.6))),
                    controller: OTPcontroller, //hna win telga l OTP value
                    focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                            border:
                                Border.all(color: MainColor, width: 3),
                            color: MainColor)),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (OTPcontroller.text.length < 5) {
                        setState(() {
                          _explanationText = 'Please enter a 5-digit OTP.';
                          _ColorAlert = Colors.red.withOpacity(0.9);
                        });
                      } else {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => pass()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.8, 47),
                        backgroundColor: MainColor),
                    child: Text(
                      'Verify',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                    ))
              ])
            ],
          )
        ],
      ),
    );
  }
}
