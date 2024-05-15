import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:carihio/pages/map/appConst.dart';
import 'package:carihio/pages/map/maptesting.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Driver extends StatefulWidget {
  final usersRef = FirebaseDatabase.instanceFor(
          databaseURL: AppConstants.dburl, app: Firebase.app("TowPal"))
      .ref();

  @override
  State<Driver> createState() => _DriverState();
}

class _DriverState extends State<Driver> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
