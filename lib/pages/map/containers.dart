import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'appConst.dart';
import 'maptesting.dart';

class AddTower {
  static List<Tower> towers = [];

  static void add(String name, String imagePath, int? id) {
    towers.add(Tower(
      name: name,
      truckImage: imagePath,
      id: id,
    ));
  }
}

class Tower extends StatefulWidget {
  int? id;
  String name;
  String truckImage;
  static int index = 0;

  Tower({required this.name, required this.truckImage, required this.id}) {
    id = index;
    index++;

    ///NOT CORRECT
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
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _goToTposition(AppConstants.locations[widget.id!]);
          print(widget.id!);
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
              '${widget.name} id:${widget.id}',
              style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
            ),
            Image.asset(
              widget.truckImage,
              width: 108,
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}
