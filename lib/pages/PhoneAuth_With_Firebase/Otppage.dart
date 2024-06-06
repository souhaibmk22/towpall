import 'package:carihio/pages/PhoneAuth_With_Firebase/phone_auth.dart';
import 'package:carihio/pages/PhoneAuth_With_Firebase/simplephonelogin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:carihio/selectUserType.dart';
import '../initialPages/select_location.dart';

class otp extends StatefulWidget {
  const otp({super.key});

  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 200,
                    width: 200,
                    child: Image.asset("images/tower.png")),
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: Text(
                  "Verification",
                  style: GoogleFonts.racingSansOne(
                      textStyle:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w400)),
                )),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Text(
                  "Please enter the 6 digit code sent to ${PhoneSignIn.phone}",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w500),
                  ),
                  textAlign: TextAlign.center,
                )),
                VerificationCode(
                  length: 6,
                  textStyle: TextStyle(fontSize: 20),
                  underlineColor: Color(0xffF39F5A),
                  onCompleted: (verificationCode) {
                    AuthServic.loginWithOtp(otp: verificationCode)
                        .then((value) {
                      if (value == "Success") {
                        print(
                            "====================hereisfine==================");
<<<<<<< HEAD
                        Navigator.pop(context);
<<<<<<< HEAD
                        Navigator.pushReplacementNamed(
                            context, "selecteposition");
=======
=======
>>>>>>> beng
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserTypeSelectionPage()));
>>>>>>> beng
                        print("===============hereisfinetwooo=============");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "invalid OTP number",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      }
                    });
                  },
                  onEditing: (bool value) {},
                )
              ],
            )));
  }
}
