import 'dart:async';

import 'package:carihio/pages/initialPages/select_location.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppConstants {
  static late StreamSubscription userDb;
  static Set<Marker> markers = {};
  static final dburl = dotenv.env["dbURL"];
  static final mapid = dotenv.env['mapid'];
  static final String apiKey = dotenv.env['key']!;
  static Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  static final myLocation = LatLng(
      selecte_locationState.currentLocation!.latitude,
      selecte_locationState.currentLocation!.longitude);
  static CameraPosition driverposition =
      CameraPosition(target: LatLng(myLocation.latitude, myLocation.longitude));
  static CameraPosition Tm1position = CameraPosition(
      target: LatLng(36.40507196734868, 3.80677642820754), zoom: 13);
  static CameraPosition Tm2position = CameraPosition(
      target: LatLng(36.30524972652825, 3.8299188299112696), zoom: 13);
  static CameraPosition Tm3position = CameraPosition(
      target: LatLng(36.353181736484366, 3.8286510257354927), zoom: 13);
  static CameraPosition Tm0position = CameraPosition(
      target: LatLng(36.32332484669408, 3.746228169901356), zoom: 13);
  static List<CameraPosition> locations = [
    Tm1position,
    Tm2position,
    Tm3position
  ];

  static void addLocation(CameraPosition coordonates) {
    locations.add(coordonates);
  }

  static final List<String> imagePath = [
    "images/TM1.png",
    "images/TM2.png",
    "images/TM3.png"
  ];
}
