// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';
import 'package:carihio/pages/ResetPassword/ForgetPasswordPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carihio/pages/authentication/config.dart';
import 'package:carihio/pages/authentication/SignUp.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailOrPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidated = false;
  String _errorMessage = '';
  late bool _isobscure = true;
  late bool _isTrue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/back2.png'),
              fit: BoxFit.fill,
            )),
            child: Container(
                margin: EdgeInsets.only(top: 80),
                child: SingleChildScrollView(
                  child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                        Column(
                          children: <Widget>[
                            FadeInUp(
                                duration: Duration(milliseconds: 800),
                                child: Container(
                                  width: 90,
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Color(0xffE1D8FF),
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 2, color: Color(0xbd5036fa))),
                                  child: Image.asset(
                                    "images/user.png",
                                    fit: BoxFit.fill,
                                    width: 50,
                                  ),
                                )),
                            FadeInUp(
                                duration: Duration(milliseconds: 900),
                                child: Text(
                                  "Sign in",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold)),
                                )),
                            SizedBox(height: 15),
                            FadeInUp(
                                duration: Duration(milliseconds: 1000),
                                child: Text(
                                  "Enter your email or phone and password",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 26,
                        ),
                        Column(
                          children: <Widget>[
                            FadeInUp(
                              duration: Duration(milliseconds: 1200),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      height: 58,
                                      width: MediaQuery.of(context).size.width *
                                          0.87,
                                      child: TextFormField(
                                        controller: emailOrPhoneController,
                                        decoration: InputDecoration(
                                            hintText: "Email",
                                            hintStyle: GoogleFonts.poppins(
                                                textStyle:
                                                    TextStyle(fontSize: 17)),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      )),
                                  SizedBox(
                                    height: 31,
                                  ),
                                  Container(
                                      height: 58,
                                      width: MediaQuery.of(context).size.width *
                                          0.87,
                                      child: TextFormField(
                                        controller: passwordController,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            suffixIcon: IconButton(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .only(end: 12.0),
                                              icon: _isobscure
                                                  ? const Icon(Icons.visibility)
                                                  : const Icon(
                                                      Icons.visibility_off),
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
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: _isobscure,
                                      )),
                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to the "forget password" route
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgetPasswordPage()),
                                      );
                                    },
                                    child: Container(
                                        margin:
                                            EdgeInsets.only(top: 12, left: 140),
                                        child: Text(
                                          'Forget The Password ?',
                                          style: GoogleFonts.poppins(
                                              textStyle:
                                                  TextStyle(fontSize: 15)),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 45,
                                  ),
                                  GestureDetector(
                                    onTap: _submitForm,
                                    child: Container(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            _submitForm();
                                          },
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              fixedSize: Size(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.85,
                                                  57),
                                              backgroundColor:
                                                  Color(0xbd5036fa)),
                                          child: Text(
                                            "sign in",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white)),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Don't have an account ? ",
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  textBaseline: TextBaseline
                                                      .ideographic)),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignupPage()));
                                          },
                                          child: Text(
                                            "Sign up",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: Colors.blue,
                                                decorationThickness:2,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                                color: Color(0xbd5036fa)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ])),
                ))));
  }

  Widget makeInput({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
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

    String emailOrPhone = emailOrPhoneController.text;
    String password = passwordController.text;

    if (emailOrPhone.isNotEmpty && password.isNotEmpty) {
      // Determine if email or phone format
      bool isEmail =
          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailOrPhone);

      loginUser(emailOrPhone, password, isEmail);
    } else {
      setState(() {
        _isNotValidated = true;
        _errorMessage = 'Please fill out all fields';
      });
    }
  }

  void loginUser(String emailOrPhone, String password, bool isEmail) async {
    Map<String, String> loginBody = {
      if (isEmail) "email": emailOrPhone else "phone": emailOrPhone,
      "password": password,
    };
    var uri = Uri.parse('http://192.168.14.43:32/login'); // Correct URI format
    try {
      var response = await http.post(
        uri,
        headers: {"Content-type": "application/json"},
        body: jsonEncode(loginBody),
      );
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse != null && jsonResponse['status'] == true) {
        // Handle successful login
        // Navigator.push(
        //context,
        //MaterialPageRoute(
        //builder: (context) => homescreen(),
        //),
        //);
      } else {
        // Handle unsuccessful login
        print('Login failed: ${jsonResponse['message']}');
      }
    } catch (e) {
      print('Error with logging in: $e');
      // Handle the error
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: SignIn(),
  ));
}
