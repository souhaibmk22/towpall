import 'package:carihio/pages/initialPages/select_location.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'phone_auth.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'dart:io' if (dart.library.html) 'dart:html';
import 'package:carihio/pages/map/maptesting.dart';

class PhoneSignIn extends StatefulWidget {
  const PhoneSignIn({super.key});

  static TextEditingController phoneController = TextEditingController();
  static String phone = "";

  @override
  State<PhoneSignIn> createState() => _PhoneSignInState();
}

class _PhoneSignInState extends State<PhoneSignIn> {
  late PhoneNumber phonenumber;
  final _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.5,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05),
        child: Column(children: [
          IntlPhoneField(
            invalidNumberMessage: 'invalid mobile number',
            controller: PhoneSignIn.phoneController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
            initialCountryCode: 'DZ',
            onChanged: (phone) {
              phonenumber = PhoneNumber.fromCompleteNumber(
                  completeNumber: phone.completeNumber);
            },
          ),
          ElevatedButton(
              onPressed: () {
                PhoneSignIn.phone =
                    '+${phonenumber.countryCode}${PhoneSignIn.phoneController.value.text}';

                print(PhoneSignIn.phone);
                AuthServic.sentOTP(
                    phone: PhoneSignIn.phone,
                    errorStep: () =>
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          "Error in Sending OTP",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red)),
                        ))),
                    nextStep: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text(
                                "OTP verification",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600)),
                              ),
                              content: Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Enter 6 digits OTP",
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                          child: OtpTextField(
                                        keyboardType: TextInputType.number,
                                        numberOfFields: 6,
                                        borderColor: Colors.black,
                                        showFieldAsBox: true,
                                        onCodeChanged: (String code) {},
                                        onSubmit: (String verificationCode) {
                                          AuthServic.loginWithOtp(
                                                  otp: verificationCode)
                                              .then((value) {
                                            if (value == "Success") {
                                              print(
                                                  "====================here is fine ==================");
                                              Navigator.pop(context);
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          selecte_location()));
                                              print(
                                                  "===============here is fine twooo=============");
                                            } else {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                  "invalid OTP number",
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white)),
                                                ),
                                                backgroundColor: Colors.red,
                                              ));
                                            }
                                          });
                                        },
                                      ))
                                    ],
                                  )),
                            )));
              },
              child: Text(
                "submit",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
              ))
        ]),
      ),
    );
  }
}
