import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'savingemail.dart';

class pass extends StatefulWidget {
  const pass({super.key});

  @override
  State<pass> createState() => _passState();
}

class _passState extends State<pass> {
  var textError = " 8 characters minimum";
  var _errorColor = Colors.black.withOpacity(0.6);
   
  final passcontroller = TextEditingController();
  final passwordfocusednode = FocusNode();
  late bool _isObscured = true;
  late bool _isTrue = true;
  Color MainColor = Color.fromARGB(255,243, 159, 90); //icon,text,border
  Color ErrorColor = Colors.black.withOpacity(0.6);
  @override
  void dispose() {
    passcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1641,
                  left: MediaQuery.of(context).size.width * 0.0605),
              child: Text(
                'LET’S SET UP YOUR \n PASSWORD',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: MainColor),
                    height: 1.0),
              )),
          Column(children: [
            Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.08),
                child: TextFormField(
                  focusNode: passwordfocusednode,
                  keyboardType: TextInputType.visiblePassword,
                  controller: passcontroller,
                  style:
                  GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16)),
                  cursorColor: Color(0x2ad716b0),
                  obscureText: _isTrue,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        padding: const EdgeInsetsDirectional.only(end: 12.0),
                        icon: _isObscured
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                            _isTrue = !_isTrue;
                          });
                        },
                      ),
                      hintText: 'Password',
                      hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600))),
                )),
            SizedBox(
              height: 5,
            ),
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 32),
                child: Text(
                  textError,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: _errorColor,
                      )),
                )),
            SizedBox(
              height: 145,
            ),
            Container(
              child: ElevatedButton(
                  onPressed: () {
                    if (passcontroller.text.length < 8) {
                      setState(() {
                        textError =
                        'your password must be 8 characters minimum';
                        _errorColor = Colors.red.withOpacity(0.9);
                      });
                    } else {
                      setState(() {
                        textError = '';
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => email_page()));
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
