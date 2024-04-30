import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'otp_verification_screen.dart';

class phone_sign extends StatefulWidget {
  const phone_sign({super.key});

  @override
  State<phone_sign> createState() => _phone_signState();
}

class _phone_signState extends State<phone_sign> {
  Color MainColor = Color.fromARGB(255,243, 159, 90); //icon,text,border
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1234,
                  left: MediaQuery.of(context).size.width * 0.0605
                ),
                child: Text(
                  'HEY YOU!',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = MainColor,
                  )),
                )),
            Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1641,
                  left: MediaQuery.of(context).size.width * 0.0605),              
              child: Text(
                'WHAT’S YOUR PHONE \nNUMBER ?',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: MainColor,
                        height: 1.0)),
              ),
            ),
            Column(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.065,
                    ),
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.3),
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (value) {},
                      cursorColor: MainColor,
                      hintText: '000 00 00 00',
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.254,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => otpScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.01,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.3),
                        backgroundColor: MainColor),
                    child: Text(
                      'Confirm',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                    ))
              ],
            )
          ],
        ));
  }
}
