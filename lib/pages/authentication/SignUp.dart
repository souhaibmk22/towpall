// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:ffi' as ff;
import 'package:carihio/pages/authentication/SingIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animate_do/animate_do.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ConfirmPasswordController = TextEditingController();
  RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', //This is the This regular expression of an email
  );
  bool _isNotValidated = false;
  String _errorMessage = '';
  late bool _isobscure = true;
  late bool _isobscure2 = true;
  late bool _isTrue = true;
  late bool _isTrue2 = true;
  String _selectedCountry = "";
  Color MainColor = Color.fromARGB(255,243, 159, 90); //icon,text,border

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(fit: StackFit.expand, children: [
          Positioned.fill(
        child: Image.asset(
            'images/background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          )),
           Positioned.fill(
      child: Container(
        color: Color.fromARGB(122,78, 77, 77), // Replace with your desired color and opacity
      ),
    ),
          Positioned.fill(
              child: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        FadeInUp(
                            duration: Duration(milliseconds: 800),
                            child: Container(
                              width:  MediaQuery.of(context).size.width * 0.3186,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255,213, 213, 213),
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 4, color: Color.fromARGB(255,99, 99, 99) ),
                                      boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.25), 
        spreadRadius: 0, 
        blurRadius: 4, 
        offset: Offset(0, 4), 
      ),
    ],),
                              child: Image.asset(
                                "images/user.png",
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width * 0.1953,
                              ),
                            )),
                        FadeInUp(
                          duration: Duration(milliseconds: 1000),
                          child: Text(
                            "Sign up",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.w700)),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                    FadeInUp(
                        duration: Duration(milliseconds: 900),
                        child: Column(
                          children: <Widget>[
                            Container(
                                height: MediaQuery.of(context).size.height * 0.0633,
                                 decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Color.fromARGB(153, 137, 137, 137),
            ),),
                                width: MediaQuery.of(context).size.width * 0.87,
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      hintText: "Email",
                                      hintStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(fontSize: 17)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  keyboardType: TextInputType.emailAddress,
                                )),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
    width: MediaQuery.of(context).size.width * 0.87,
                            child :Row(
  children: [
    Container(
                                height: MediaQuery.of(context).size.height * 0.0633,
                                 decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Color.fromARGB(153, 137, 137, 137),
            ),),
                                width: MediaQuery.of(context).size.width * 0.42,
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      hintText: "First name",
                                      hintStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(fontSize: 17)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  keyboardType: TextInputType.emailAddress,
                                )),
                                SizedBox(width: 10),
                                Container(
                                 height: MediaQuery.of(context).size.height * 0.0633,
                                 decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Color.fromARGB(153, 137, 137, 137),
            ),),
                                width: MediaQuery.of(context).size.width * 0.42,
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      hintText: "Last name",
                                      hintStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(fontSize: 17)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  keyboardType: TextInputType.emailAddress,
                                )),
  ]
                            ),
  ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                                height: MediaQuery.of(context).size.height * 0.0633,
                                 decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0), 
    border: Border.all(color: Color.fromARGB(153, 137, 137, 137) )
            ),
                                width: MediaQuery.of(context).size.width * 0.87,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: IntlPhoneField(
                                  keyboardType: TextInputType.phone,
                                  controller: phoneNumberController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                      hintText: "phone",
                                      hintStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(fontSize: 17)),
                                      ),
                                     
                                  onCountryChanged: (phone) {
                                    setState(() {
                                      _selectedCountry = phone.fullCountryCode;
                                    });
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]')),
                                    //To remove first '0'
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'^0+')),
                                    //To remove first '94' or your country code
                                  ],
                                )),),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                                 height: MediaQuery.of(context).size.height * 0.0633,
                                width: MediaQuery.of(context).size.width * 0.87,
                                decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0), // Set the radius here
              border: Border.all(color: Color.fromARGB(153, 137, 137, 137))
            ),
                                child: TextFormField(
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      suffixIcon: IconButton(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                end: 12.0),
                                        icon: _isobscure
                                            ? const Icon(Icons.visibility)
                                            : const Icon(Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            _isobscure = !_isobscure;
                                            _isTrue = !_isTrue;
                                          });
                                        },
                                      ),
                                      hintText: 'Password',
                                      hintStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                        fontSize: 17,
                                      ))),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: _isobscure,
                                )),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                                 height: MediaQuery.of(context).size.height * 0.0633,
                                 decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Color.fromARGB(153, 137, 137, 137) )// Set the radius here
            ),
                                width: MediaQuery.of(context).size.width * 0.87,
                                child: TextFormField(
                                  controller: ConfirmPasswordController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      hintText: 'Confirm password',
                                      hintStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                        fontSize: 17,
                                      ))),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                )),
                            SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  print("+" +
                                      _selectedCountry +
                                      phoneNumberController.text);
                                  if ((ConfirmPasswordController.value.text ==
                                          passwordController.value.text) &&
                                      (emailRegExp
                                          .hasMatch(emailController.text))) {
                                    _submitForm();
                                  } else {
                                    setState(() {
                                      print("error");
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    fixedSize: Size(
                                        MediaQuery.of(context).size.width *
                                            0.85,
                                        45),
                                    backgroundColor: MainColor ),
                                child: Text(
                                  "Next",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white)),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            FadeInUp(
                              duration: Duration(milliseconds: 1600),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Already have an account?",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SignIn()));
                                    },
                                    child: Text(
                                      " Sign in",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor: MainColor,
                                              decorationThickness: 2,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                              color: MainColor)),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ))
        ]));
  }

  Widget makeInput({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    bool isPhoneNumber = false,
    required String errorMessage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType:
              isPhoneNumber ? TextInputType.phone : TextInputType.text,
          inputFormatters: [
            if (isPhoneNumber) FilteringTextInputFormatter.digitsOnly,
          ],
          validator: (value) {
            if (value!.isEmpty) {
              setState(() {
                _isNotValidated = true;
              });
              return 'Please enter a ${isPhoneNumber ? 'phone number' : 'value'}';
            }
            setState(() {
              _isNotValidated = false;
            });
            return null;
          },
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  void _submitForm() {
    setState(() {
      _isNotValidated = false;
    });

    String email = emailController.text;
    String phoneNumber = "+" + _selectedCountry + phoneNumberController.text;
    String password = passwordController.text;

    if (email.isNotEmpty && phoneNumber.isNotEmpty && password.isNotEmpty) {
      registerUser(email, phoneNumber, password);
    } else {
      setState(() {
        _isNotValidated = true;
        _errorMessage = 'Please fill out all fields';
      });
    }
  }

  void registerUser(String email, String phoneNumber, String password) async {
    var regbody = {
      "email": email,
      "phone": phoneNumber,
      "password": password,
    };
    var uri = Uri.parse(registration); // Correct URI format
    try {
      var response = await http.post(
        uri,
        headers: {"Content-type": "application/json"},
        body: jsonEncode(regbody),
      );
      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['success']);
      if (jsonResponse['status']) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SignIn()), // Replace NextScreen() with your desired screen
        );
      }
      // Handle the response from the server
    } catch (e) {
      print('Error with registering user verify your code my friend : $e');
      // Handle the error
    }
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: SignupPage(),
  ));
}
