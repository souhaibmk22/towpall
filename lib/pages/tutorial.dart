import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding_page/onboarding_page.dart';

class tutorial extends StatefulWidget {
  const tutorial({super.key});

  @override
  State<tutorial> createState() => _tutorialState();
}
class _tutorialState extends State<tutorial> {
  final PageController _pageController = PageController();
  int _currentPage = 0;


 Widget buildBottomNavigation() {
   String button1;
  String button2;

  if (_currentPage == 0) {
    button1 = 'Skip';
    button2 = 'Next';
  } else if (_currentPage == 3) {
    button1 = 'Previous';
    button2 = 'Done';
  } else {
    button1= 'Previous';
    button2 = 'Next';
  }
    return Positioned(
      bottom: 20,
      left: 20,
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              // Handle skip button press
            },
            child: Text(
              button1,
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 60),
          Row(
            children: List.generate(
              4,
              (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.4),
                ),
              ),
            ),
          ),
          SizedBox(width: 60),
          TextButton(
            onPressed: () {
              // Handle next button press
            },
            child: Text(
              button2,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

   Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
       body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
           children: [
              TutorialPage(
                image: 'images/tuto1.png',
                title: 'Fuel Failure',
                description: 'For reliable applications, focus on regular maintenance, quality fuel, proper storage, backups, staff training, monitoring, emergency plans, and inspections.',
                pageIndex: 0,
                currentPage: _currentPage,
              ),
              TutorialPage(
                image: 'images/tuto2.png',
                title: 'Battery Failure',
                description: 'For battery reliability, prioritize proper charging, regular inspections, backup power sources, safety training, and emergency response plans.',
                pageIndex: 1,
                currentPage: _currentPage,
              ),
              TutorialPage(
                image: 'images/tuto3.png',
                title: 'Crevation Failure',
                description: 'To prevent corrosion failure,focus on proper material selection, regular inspections, moisture control, corrosion inhibitors,and maintenance training.',
                pageIndex: 2,
                currentPage: _currentPage,
              ),
              TutorialPage(
                image: 'images/tuto4.png',
                title: 'Depann',
                description: 'To prevent accidents, prioritize safety protocols, staff training, risk assessments, emergency preparedness, equipment maintenance, supervision, and continuous improvement.',
                pageIndex: 3,
                currentPage: _currentPage,
              ),
            ],
    ),
    buildBottomNavigation(),
        ]
       )
    );
  }
}


class TutorialPage extends StatelessWidget {
  final String image;
 final String title;
  final String description;
  final int pageIndex;
   final int currentPage;
  Color MainColor = Color.fromARGB(255,243, 159, 90);

  TutorialPage({required this.image, required this.title, required this.description, required this.pageIndex, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    List<String> backgroundImages = [
      'images/tuto1.png',
      'images/tuto2.png',
      'images/tuto3.png',
      'images/tuto4.png',
    ];
    return Stack(
      children: [
        Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImages[pageIndex]),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
          color: Color.fromARGB(153,78, 77, 77), // Adjust opacity as needed
        ),
    Positioned(
          top: MediaQuery.of(context).size.height * 0.1502, // 15% from the top
         left: MediaQuery.of(context).size.width * 0.0977,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
            text: 'Tow', // Replace with your app name
            style: GoogleFonts.getFont(
              'Racing Sans One',
              fontSize: 35,
              fontWeight: FontWeight.w400,
              color: MainColor, // Adjust color as needed
            ),
          ),
          TextSpan(
            text: 'pal', // Replace with your app name
            style: GoogleFonts.getFont(
              'Racing Sans One',
              fontSize: 35,
              fontWeight: FontWeight.w400,
              color: Colors.white, // Adjust color as needed
            ),
          ),
              ]
        ),
          ),
    ),
    Container(
      margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2425, // 24.25% from the top
left: MediaQuery.of(context).size.width * 0.0488,), 
height: MediaQuery.of(context).size.height * 0.4592, // 45.92% of the screen height
width: MediaQuery.of(context).size.width * 0.9058, // 90.58% of the screen width// 4.88% from the left
decoration: BoxDecoration(
  color: Color.fromARGB(26,217, 217, 217),
    border: Border.all(
      color: MainColor, // Border color
      width: 2, // Border width
    ),
    borderRadius: BorderRadius.circular(30), // Border radius
  ),
  padding: EdgeInsets.all(30), // Add padding as needed
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: GoogleFonts.getFont(
              'Racing Sans One',
              fontSize: 35,
              fontWeight: FontWeight.w400,
              color: Colors.white, // Adjust color as needed
            ),
      ),
      SizedBox(height: 15), // Add spacing between title and description
      Text(
        description,
        style: GoogleFonts.getFont(
              'Questrial',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white, // Adjust color as needed
            ),
      ),
    ],
  ),
),
      ]
    );
  }
}