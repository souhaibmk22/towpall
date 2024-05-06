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
      backgroundColor: Colors.white,
      body: ListView(children: [
        Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
          child: Column(children: [
            Container(
              child: Text(
                "TowPal",
                style: GoogleFonts.racingSansOne(
                    textStyle:
                        TextStyle(fontSize: 40, color: Color(0xffF39F5A))),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Enter your correct phone number to get started",
              style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14)),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.06),
                child: IntlPhoneField(
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
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.90, 55),
                    backgroundColor: Color(0xffF39F5A),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
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
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                            color:
                                                                Colors.white)),
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
        )
      ]),
    );
  }
}
