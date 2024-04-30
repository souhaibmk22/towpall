import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButtonTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  const CustomButtonTile({
    Key? key,
    required this.iconData,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
         ),
         backgroundColor: Color.fromARGB(255,255,255,255),
          elevation: 2,
      ),
        child: Row(
          children: [
            Icon(
              iconData,
              color: Color.fromARGB(255,243, 159, 90),
             size: 40.0,
              ),
            SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 16,
                     fontWeight: FontWeight.bold,
                    color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      );
  }
}

class Via extends StatefulWidget {
  const Via({Key? key}) : super(key: key);

  @override
  State<Via> createState() => _ViaState();
}

class _ViaState extends State<Via> {
Color MainColor = Color.fromARGB(255,243, 159, 90); //icon,text,border

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: Colors.white,
           body:  Stack(
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
                'Forgot password ?',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: MainColor),
                    height: 1.0),
              )),
  Container (
    margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.23,
                  left: MediaQuery.of(context).size.width * 0.0605),
              child: Text(
                'Select which contact details should \n we use to reset your password',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: MainColor),
                    height: 1.0),
              )),
    Container(  
       margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3164,
                  left: MediaQuery.of(context).size.width * 0.0814,
                  bottom : MediaQuery.of(context).size.height *  0.5710,
                  right: MediaQuery.of(context).size.width * 0.0814),
              height: MediaQuery.of(context).size.height * 0.1127,
              width: MediaQuery.of(context).size.width * 0.8372,
              child: CustomButtonTile(
  iconData: Icons.sms,
  title: 'Via sms',
  subtitle: '.... .... 4235',
  onPressed: () {
    // Handle button tap here
  },
),
    ),
        Container(  
       margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.4422,
                  left: MediaQuery.of(context).size.width * 0.0814,
                  bottom : MediaQuery.of(context).size.height *  0.4445,
                  right: MediaQuery.of(context).size.width * 0.0814),
              height: MediaQuery.of(context).size.height * 0.1127,
              width: MediaQuery.of(context).size.width * 0.8372,
              child: CustomButtonTile(
  iconData: Icons.email,
  title: 'Via email',
  subtitle: '.... @gmail.com',
  onPressed: () {
    // Handle button tap here
  },
),
    ),
     Container(
      margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.6072,
                  left: MediaQuery.of(context).size.width * 0.0814,
                  bottom : MediaQuery.of(context).size.height *  0.336,
                  right: MediaQuery.of(context).size.width * 0.0814),
              child: ElevatedButton(
                  onPressed: () {
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
       
        ],         
  ),
);
          
  }
}