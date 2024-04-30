import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class welcom extends StatefulWidget {
  const welcom({super.key});

  @override
  State<welcom> createState() => _welcomState();
}

class _welcomState extends State<welcom> {
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
        Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.png'), // Path to your image
              fit: BoxFit.cover, // Adjust as per your needs
            ),
          ),
      ),
      Container(
          color: Color.fromARGB(153,78, 77, 77), // Adjust opacity as needed
        ),
      Positioned(
        top: MediaQuery.of(context).size.height * (107 / 932), // 11.47% from the top
left: MediaQuery.of(context).size.width * (45 / 430), // 10.47% from the left
height: MediaQuery.of(context).size.height * (150 / 932), // 7.19% from the top
width: MediaQuery.of(context).size.width * (312 / 430), // 72.56% from the left

          child:RichText(
            text: TextSpan(
              children: [
                TextSpan(
            text: 'Welcom', // Replace with your app name
            style: GoogleFonts.getFont(
              'Racing Sans One',
              fontSize: 40,
              fontWeight: FontWeight.w400,
              color: Colors.white, // Adjust color as needed
            ),
                ),
                TextSpan(
            text: 'To\n', // Replace with your app name
            style: GoogleFonts.getFont(
              'Racing Sans One',
              fontSize:40,
              fontWeight: FontWeight.w400,
              color: MainColor, // Adjust color as needed
            ),
                ),
                TextSpan(
            text: 'Tow', // Replace with your app name
            style: GoogleFonts.getFont(
              'Racing Sans One',
              fontSize: 40,
              fontWeight: FontWeight.w400,
              color: MainColor, // Adjust color as needed
            ),
                ),
                TextSpan(
            text: 'Pal', // Replace with your app name
            style: GoogleFonts.getFont(
              'Racing Sans One',
              fontSize: 40,
              fontWeight: FontWeight.w400,
              color: Colors.white, // Adjust color as needed
            ),
                )
              ]
          )
        )
      ),
      Container(
         margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * (230 / 932), // 19.52% from the top
left: MediaQuery.of(context).size.width * (45.36 / 430),
right: MediaQuery.of(context).size.width * (45.36 / 430), ),// 10.55% from the left
      child: Text(
      'Get Ready To Use This App When You Need It.',
      style: GoogleFonts.getFont(
              'Poppins',
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Color.fromARGB(153,255,255,255),
      ),
    ),
      )
         ]
      )
    );
  }
}