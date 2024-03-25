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
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('images/img.png', fit: BoxFit.fill),
          Column(
            children: [
              Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.151,
                  ),
                  child: Center(
                    child: Text(
                      'ENTER VERIFICATION CODE',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Color(0xbd5036fa))),
                    ),
                  )),
              SizedBox(
                height: 95,
              ),
              Column(children: [
                Text(
                  'ENTER OTP  ',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          color: Color(0xbd5036fa))),
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
                            ?.copyWith(color: Color(0xbd5036fa))),
                    controller: OTPcontroller, //hna win telga l OTP value
                    focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                            border:
                                Border.all(color: Color(0xffBAA7F4), width: 3),
                            color: Color(0xfa4f20ad))),
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
                        backgroundColor: Color(0xbd5036fa)),
                    child: Text(
                      'Verify',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 23,
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
