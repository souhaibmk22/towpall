import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TowerData {
  /// ***************** Fetch Towers from Database ***************** ///
  Future<List<Map<String, dynamic>>> fetchTowers() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('towers');
    DataSnapshot snapshot = await ref.get();

    List<Map<String, dynamic>> towers = [];
    if (snapshot.exists) {
      Map<dynamic, dynamic>? values = snapshot.value as Map<dynamic, dynamic>?;
      if (values != null) {
        values.forEach((key, value) {
          towers.add({
            'id': key,
            'available': value['available'],
            'latitude': value['latitude'],
            'longitude': value['longitude'],
            'phone number': value['phone number'],
          });
          print("fetching towers is done ");
        });
      }
    }
    return towers;
  }

  /// ********** Calculate the distance between the driver and each tower ************
  double calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    return Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }

  /// ************ Filter Nearest Towers *************
  Future<List<Map<String, dynamic>>> getNearestTowers(
      Position driverPosition, double radius) async {
    List<Map<String, dynamic>> towers = await fetchTowers();

    /// nearestTowers is a list that contain only the nearest towers to the driver according the the distance between them
    List<Map<String, dynamic>> nearestTowers = [];

    for (var tower in towers) {
      /// check if the tower is active which mean he is available or not
      if (tower['available'] == true) {
        double distance = calculateDistance(driverPosition.latitude,
            driverPosition.longitude, tower['latitude'], tower['longitude']);

        /// Comparing the distance with the radius
        if (distance <= radius) {
          nearestTowers.add(tower);
        }
      }
    }

    /// returning only the nearest according to the raduis
    return nearestTowers;
  }

  /// adding this function to convert from LatLng to Position object :
  Future<Position> latLngToPosition(LatLng myLocation) async {
    try {
      Position position = Position(
        latitude: myLocation.latitude,
        longitude: myLocation.longitude,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        altitudeAccuracy: 0.0,
        headingAccuracy: 0.0,
      );
      return position;
    } catch (e) {
      throw Exception('Failed to convert LatLng to Position: $e');
    }
  }
}
