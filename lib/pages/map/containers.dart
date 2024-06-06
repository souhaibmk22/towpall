import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'appConst.dart';
import 'maptesting.dart';

class AddTower {
  static List<Tower> towers = [];
  static List<CameraPosition> locations = [];

  static void add(String? name, String imagePath, int? id, double latitude,
      double longitude, String phoneNumber) {
    towers.add(Tower(
      name: name,
      truckImage: imagePath,
      id: id,
      latitude: latitude,
      longitude: longitude,
      phoneNumber: phoneNumber,
    ));
  }
}

class Tower extends StatefulWidget {
  int? id;
  String? name;
  String truckImage;
  static int index = 0;
  double latitude;
  double longitude;
  String phoneNumber;

  Tower({
    required this.name,
    required this.truckImage,
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.phoneNumber,
  }) {
    id = index;
    index++;
  }

  @override
  State<Tower> createState() => _TowerState();
}

class _TowerState extends State<Tower> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future<void> _goToTposition(CameraPosition towerPosition) async {
    final GoogleMapController controller = await AppConstants.controller.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(towerPosition));
    print(widget.name);
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _goToTposition(CameraPosition(
              target: LatLng(widget.latitude, widget.longitude), zoom: 13));
          print(widget.id!);
          _makePhoneCall(widget.phoneNumber);
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.22),
                  spreadRadius: 2,
                  blurRadius: 7)
            ],
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Text(
              '${widget.name} ',
              style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
            ),
            Image.asset(
              widget.truckImage,
              width: 120,
              height: 70,
            ),
            SizedBox(
              height: 13,
            ),
            Text(
              "Call now !!!!",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.red)),
            )
          ],
        ),
      ),
    );
  }
}
