import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseRolePage extends StatefulWidget {
  const ChooseRolePage({super.key});

  @override
  State<ChooseRolePage> createState() => _ChooseRolePageState();
}

class _ChooseRolePageState extends State<ChooseRolePage> {
  Color ClickColor = Color(0xbd5036fa);
  late Color temp;
  Color backTowerButtonColor = Color(0xffFBFBF2);
  Color backDriverButtonColor = Color(0xffFBFBF2);
  Color DriverTextColor = Color(0xbd5036fa);
  Color TowerTextColor = Color(0xbd5036fa);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'images/img.png',
            fit: BoxFit.fill,
          ),
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.148,
                  left: MediaQuery.of(context).size.width * 0.1),
              child: Text(
                'YOU ARE OFFICIALLY HERE AS A ?',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: Color(0xbd5036fa)),
                    height: 1.0),
              )),
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.26),
              child: Column(
                children: [
                  Container(
                      width: 180,
                      height: 180,
                      child: ElevatedButton(
                          onPressed: () {
                            if (backDriverButtonColor == Color(0xbd5036fa)) {
                              setState(() {
                                backDriverButtonColor = Color(0xffFBFBF2);
                                backTowerButtonColor = Color(0xbd5036fa);
                                TowerTextColor=Color(0xffFBFBF2);
                                DriverTextColor=Color(0xbd5036fa);
                              });
                            } else {
                              setState(() {
                                backTowerButtonColor = Color(0xbd5036fa);
                                TowerTextColor = Color(0xffFBFBF2);
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            side: BorderSide(
                                width: 2.0, color: Color(0xbd5036fa)),
                            shadowColor: Colors.black.withOpacity(0.9),
                            backgroundColor: backTowerButtonColor,
                          ),
                          child: Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    'images/tower.png',
                                    fit: BoxFit.fill,
                                    height: 138,
                                  ),
                                  Text(
                                    'Tower ',
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.w700,
                                            color: TowerTextColor)),
                                  )
                                ],
                              )))),
                  SizedBox(
                    height: 34,
                  ),
                  Container(
                      height: 180,
                      width: 180,
                      child: ElevatedButton(
                          onPressed: () {
                            if (backTowerButtonColor == Color(0xbd5036fa)) {
                              setState(() {
                                backTowerButtonColor = Color(0xffFBFBF2);
                                backDriverButtonColor = Color(0xbd5036fa);
                                DriverTextColor=Color(0xffFBFBF2);
                                TowerTextColor=Color(0xbd5036fa);
                              });
                            } else {
                              setState(() {
                                backDriverButtonColor = Color(0xbd5036fa);
                                DriverTextColor = Color(0xffFBFBF2);
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              side: BorderSide(
                                  width: 2.0, color: Color(0xbd5036fa)),
                              backgroundColor: backDriverButtonColor,
                              shadowColor: Color(0x9fC416D7)),
                          child: Center(
                              child: Column(children: [
                                Image.asset(
                                  'images/driver.png',
                                  fit: BoxFit.fill,
                                  height: 138,
                                ),
                                Text(
                                  'Driver ',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.w700,
                                          color: DriverTextColor)),
                                )
                              ]))))
                ],
              ))
        ],
      ),
    );
  }
}
