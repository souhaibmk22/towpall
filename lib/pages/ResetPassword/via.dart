import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class via extends StatefulWidget {
  const via({Key? key}) : super(key: key);

  @override
  State<via> createState() => _viaState();
}

class _viaState extends State<via> {
  Color MainColor = Color.fromARGB(255,243, 159, 90); 
  
  @override
  Widget build(BuildContext context) {
    String phoneNumber = '+1234567890';
    final Size screenSize = MediaQuery.of(context).size;
  final double buttonWidth = screenSize.width * 0.8372; // 70% of screen width
    final double buttonHeight = screenSize.height * 0.1126;
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
                'Forgot Password?',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: MainColor),
                    height: 1.0),
              )),
              SizedBox(
              height: 5,
            ),
               Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2177,
                  left: MediaQuery.of(context).size.width * 0.0605,
                  right: MediaQuery.of(context).size.width * 0.0605),
              child: Text(
                'Select which contact details should we use to reset your password',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: MainColor),
                    height: 1.0),
              )),
              /* SizedBox(
                  height:30.0,
                 ) ,  */
               Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () { },
                child: ListTile(
              leading: Icon(Icons.sms,
              color: MainColor,
                     size: 40.0,),
              title: Text('Via sms:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,)),
              subtitle: Text(
                '.... .... 4235',
                   style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,) 
                  ),
            ),
              ),
              SizedBox(
                  height:10.0,
                 ) ,
              ElevatedButton(
                onPressed: () { },
                child: ListTile(
              leading: Icon(Icons.email,
              color: MainColor,
                     size: 30.0,),
              title: Text('Via email:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,)),
              subtitle: Text(
                   '.... @gmail.com',
                   style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,) 
                  ),
            ),
              ),
              SizedBox(
                  height:60.0,
                 ) ,
              ]
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.6072,
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  bottom: MediaQuery.of(context).size.height * 0.335,),
              child: ElevatedButton(
                  onPressed: () {},
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
         ]
      )
      );
  }
}