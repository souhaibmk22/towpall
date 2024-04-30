import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carihio/pages/authentication/SingIn.dart';

class Reset extends StatefulWidget {
  const Reset({Key? key}) : super(key: key);

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  var textError1 = " 8 characters minimum";
  var textError2 = " 8 characters minimum";
  var _errorColor1 = Colors.black.withOpacity(0.6);
  var _errorColor2 = Colors.black.withOpacity(0.6);
  final NewPasswordcontroller = TextEditingController();
  final ConfirmPasswordcontroller = TextEditingController();
  final passwordfocusednode = FocusNode();
  late bool _isnpassObscured = true;
  late bool _iscpassObscured = true;
  late bool _isnpassTrue = true;
  late bool _iscpassTrue = true;
  Color MainColor = Color.fromARGB(255,243, 159, 90); //icon,text,border
   
  @override
  void dispose() {
    NewPasswordcontroller.dispose();
    ConfirmPasswordcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           resizeToAvoidBottomInset : false,
           backgroundColor: Colors.white,
           body: Stack(
            fit: StackFit.expand,
        children: [
              Positioned(
      top: MediaQuery.of(context).size.height * 0.0989,
      left: MediaQuery.of(context).size.width * 0.0605,
      child: GestureDetector(
    onTap: () {
      // Navigate to another screen here
      // Replace `YourNextScreen()` with the screen you want to navigate to
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );
    },
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
  ),      
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1641,
                  left: MediaQuery.of(context).size.width * 0.0605),
              child: Text(
                'RESET YOUR PASSWORD HERE',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: MainColor),
                    height: 1.0),
              )
              ),
                 SizedBox(
                  height:60.0,
                 ) ,  
                 Column(children: [
            Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.3426,
                    left:  MediaQuery.of(context).size.width * 0.0767,
                    right:  MediaQuery.of(context).size.width * 0.0767),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.08),
                    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.25),
  offset: Offset(0, 4),
  blurRadius: 4,
  spreadRadius: 0,
)
    ],
  ),
                child: TextFormField(
                  focusNode: passwordfocusednode,
                  keyboardType: TextInputType.visiblePassword,
                  controller: NewPasswordcontroller,
                  style:
                  GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16)),
                  cursorColor: Color(0x2ad716b0),
                  obscureText: _isnpassTrue,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        padding: const EdgeInsetsDirectional.only(end: 12.0),
                        icon: _isnpassObscured
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isnpassObscured = !_isnpassObscured;
                            _isnpassTrue = !_isnpassTrue;
                          });
                        },
                      ),
                      hintText: 'New Password',
                      hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600)
                              ),
                               border: InputBorder.none,
                              ),
                )
                ),
                SizedBox(
              height: 5,
            ),
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 32),
                child: Text(
                  textError1,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: _errorColor1,
                      )),
                )),
            SizedBox(
              height: 30,
            ),
           Container(
                margin: EdgeInsets.only(
                    left:  MediaQuery.of(context).size.width * 0.0767,
                    right:  MediaQuery.of(context).size.width * 0.0767),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.08),
                    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.25),
  offset: Offset(0, 4),
  blurRadius: 4,
  spreadRadius: 0,
)
    ],
  ),
                child: TextFormField(
                  focusNode: passwordfocusednode,
                  keyboardType: TextInputType.visiblePassword,
                  controller: ConfirmPasswordcontroller,
                  style:
                  GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16)),
                  cursorColor: Color(0x2ad716b0),
                  obscureText: _iscpassTrue,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        padding: const EdgeInsetsDirectional.only(end: 12.0),
                        icon: _iscpassObscured
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _iscpassObscured = !_iscpassObscured;
                            _iscpassTrue = !_iscpassTrue;
                          });
                        },
                      ),
                      hintText: 'Confirm Password',
                      hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600)
                              ),
                               border: InputBorder.none,
                              ),
                )
                ),
                 SizedBox(
              height: 5,
            ),
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 32),
                child: Text(
                  textError2,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: _errorColor2,
                      )),
                )),
            SizedBox(
              height: 145,
            ),
            Container(
              child: ElevatedButton(
                  onPressed: () {
                    if (NewPasswordcontroller.text == ConfirmPasswordcontroller.text && NewPasswordcontroller.text.length >= 8 && ConfirmPasswordcontroller.text.length >= 8) {
                   setState(() {
                        textError1 = '';
                        textError2 = '';
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignIn()));
                      });
                    } else if (NewPasswordcontroller.text != ConfirmPasswordcontroller.text && NewPasswordcontroller.text.length >= 8 && ConfirmPasswordcontroller.text.length >= 8) {
                     setState(() {
                      textError1 = 'Passwords do not match';
                      textError2 = 'Passwords do not match';
                      _errorColor1 = Colors.red.withOpacity(0.9);
                      _errorColor2 = Colors.red.withOpacity(0.9);
                    });
                    } else if (NewPasswordcontroller.text.length < 8) {
    setState(() {
      textError1 = 'Password must be at least 8 characters long';
      _errorColor1 = Colors.red.withOpacity(0.9);
    });
  } else if (ConfirmPasswordcontroller.text.length < 8) {
    setState(() {
      textError2 = 'Password must be at least 8 characters long';
      _errorColor2 = Colors.red.withOpacity(0.9);
    });
  } 
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: MainColor,
                      fixedSize:
                      Size(MediaQuery.of(context).size.width * 0.85, 50)),
                  child: Center(
                    child: Text(
                      'Confirm',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                    ),
                  )),
            )
          ])
            ],
          ),
             );
  }
}