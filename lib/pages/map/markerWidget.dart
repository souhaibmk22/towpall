import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'maptesting.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MarkerWidget extends StatefulWidget {
  String output;

  MarkerWidget({required this.output});

  @override
  State<MarkerWidget> createState() => _MarkerWidgetState();
}

class _MarkerWidgetState extends State<MarkerWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: Color(0xffF39F5A), borderRadius: BorderRadius.circular(10)),
        child: Text(
          widget.output,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff08415C))),
        ),
      ),
      Container(
        child: Image.asset(
          "images/destination.png",
          width: 40,
        ),
      )
    ]));
  }
}
