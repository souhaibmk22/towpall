import 'package:carihio/pages/initialPages/select_location.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'Otppage.dart';
import 'phone_auth.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'dart:io' if (dart.library.html) 'dart:html';
import 'package:carihio/pages/map/maptesting.dart';

class PhoneSignIn extends StatefulWidget {
  const PhoneSignIn({super.key});

  static TextEditingController phoneController = TextEditingController();
  static TextEditingController nameController = TextEditingController();
  static String phone = "";

  @override
  State<PhoneSignIn> createState() => _PhoneSignInState();
}

class _PhoneSignInState extends State<PhoneSignIn> {
  late PhoneNumber phonenumber;
  final _formKey = GlobalKey<FormState>(); // Create a global key for the form

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
                  textStyle: TextStyle(fontSize: 40, color: Color(0xffF39F5A)),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Enter your name and phone number to get started",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14)),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.07),
            Form(
              key: _formKey, // Assign the global key to the form
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06,
                    ),
                    child: TextFormField(
                      controller: PhoneSignIn.nameController,
                      decoration: InputDecoration(
                        labelText: 'Enter your name',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06,
                    ),
                    child: IntlPhoneField(
                      invalidNumberMessage: 'Invalid mobile number',
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
                          completeNumber: phone.completeNumber,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width * 0.90, 55),
                backgroundColor: Color(0xffF39F5A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Validate the form
                  PhoneSignIn.phone =
                      '+${phonenumber.countryCode}${PhoneSignIn.phoneController.value.text}';

                  print(PhoneSignIn.phone);
                  AuthServic.sentOTP(
                    phone: PhoneSignIn.phone,
                    errorStep: () =>
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Invalid phone number",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      backgroundColor: Colors.red,
                    )),
                    nextStep: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => otp()),
                    ),
                  );
                }
              },
              child: Text(
                "Submit",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
