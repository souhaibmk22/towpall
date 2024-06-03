import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTypeSelectionPage extends StatefulWidget {
  static String selectedType = '';

  @override
  _UserTypeSelectionPageState createState() => _UserTypeSelectionPageState();
}

class _UserTypeSelectionPageState extends State<UserTypeSelectionPage> {
  var hipper = "Select your role to get started :";
  bool isLoading = false;

  void selectType(String type) {
    setState(() {
      UserTypeSelectionPage.selectedType = type;
      isLoading = true;
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
          Navigator.pushReplacementNamed(context, "selecteposition");

          /// navigate the the selectelocation page
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tow Pal',
          style: GoogleFonts.racingSansOne(
              textStyle: TextStyle(fontSize: 40, color: Color(0xffF39F5A))),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              Center(
                child: CircularProgressIndicator(
                  color: Color(0xffF39F5A),
                ),
              )
            else
              Text(
                hipper,
                style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16)),
              ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () => selectType('tower'),
              child: Container(
                decoration: BoxDecoration(
                  color: UserTypeSelectionPage.selectedType == 'tower'
                      ? Colors.orange[100]
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: UserTypeSelectionPage.selectedType == 'tower'
                        ? Colors.orange
                        : Colors.grey,
                    width: 2,
                  ),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.asset('images/TM1.png', height: 60),
                        // replace with your tower image
                        if (UserTypeSelectionPage.selectedType == 'tower')
                          Positioned(
                            top: 8,
                            child:
                                Icon(Icons.check_circle, color: Colors.green),
                          ),
                      ],
                    ),
                    Text('Tower',
                        style: GoogleFonts.racingSansOne(
                            textStyle: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w400))),
                    Text(
                      'You are a professional and you want to boost your towing activity?',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontSize: 12)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => selectType('driver'),
              child: Container(
                decoration: BoxDecoration(
                  color: UserTypeSelectionPage.selectedType == 'driver'
                      ? Colors.orange[100]
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: UserTypeSelectionPage.selectedType == 'driver'
                        ? Colors.orange
                        : Colors.grey,
                    width: 2,
                  ),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.asset('images/CarMarker.png', height: 80),
                        // replace with your driver image
                        if (UserTypeSelectionPage.selectedType == 'driver')
                          Positioned(
                            top: 8,
                            child:
                                Icon(Icons.check_circle, color: Colors.green),
                          ),
                      ],
                    ),
                    Text(
                      'Driver',
                      style: GoogleFonts.racingSansOne(
                          textStyle: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w400)),
                    ),
                    Text(
                      'You are broken down or you want to tow your vehicle?',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontSize: 12)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
