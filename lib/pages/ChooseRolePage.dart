import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseRolePage extends StatefulWidget {
  const ChooseRolePage({super.key});

  @override
  State<ChooseRolePage> createState() => _ChooseRolePageState();
}

class _ChooseRolePageState extends State<ChooseRolePage> {
  late Color temp;
  Color MainColor = Color.fromARGB(255,243, 159, 90); //icon,text,border
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
                'You are here officialy as ?',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: MainColor),
                    height: 1.0),
              )
              ),
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2543, 
                   ),
              child: Column(
                children: [
                  Container(
                     width: MediaQuery.of(context).size.width * 0.8767, 
                     height: MediaQuery.of(context).size.height * 0.2919, 
                     decoration: BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.25),
        blurRadius: 4, 
        offset: Offset(0, 4), 
        spreadRadius: 0, 
      ),
    ],
  ),
                      child: ElevatedButton(
                          onPressed: () { },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0), 
                            ),
                            side: BorderSide(
                                width: 4.0, color: MainColor),
                            shadowColor: Colors.black.withOpacity(0.25),
                            padding: EdgeInsets.zero,
                          ),
                          child: Center(
                                child: Stack(
                                 alignment: Alignment.center,
                                 children: [
                                  ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
                                  child:Opacity(
                           opacity: 0.7, 
        child: Image.asset(
          'images/client.png',
         fit: BoxFit.fill,
        ),
      ), 
                                  ),  
                                  Text(
                                    'Client ',
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.w700,
                                            color: MainColor)),
                                  )
                                ],
                              )))),
                  SizedBox(
                    height: 20,
                  ),
                              Container(
                     width: MediaQuery.of(context).size.width * 0.8767, 
                     height: MediaQuery.of(context).size.height * 0.2919, 
                     decoration: BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.25), 
        blurRadius: 4, 
        offset: Offset(0, 4), 
        spreadRadius: 0,
      ),
    ],
  ),
                      child: ElevatedButton(
                          onPressed: () {  },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0), 
                            ),
                            side: BorderSide(
                                width: 4.0, color: MainColor),
                            shadowColor: Colors.black.withOpacity(0.25),
                            padding: EdgeInsets.zero,
                          ),
                          child: Center(
                                child: Stack(
                                 alignment: Alignment.center,
                                 children: [
                                  ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
                                  child: Opacity(
                           opacity: 0.7, 
        child: Image.asset(
          'images/tower.png',
          fit: BoxFit.cover,
        ),
      ),   
                                ),
                                  Text(
                                    'Tower ',
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.w700,
                                            color: MainColor)),
                                  )
                                ],
                              )))),
                ], 
              ))
        ],
      ),
    );
  }
}
