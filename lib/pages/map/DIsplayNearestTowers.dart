import 'package:carihio/pages/map/appConst.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carihio/pages/map/appConst.dart';
import '../PhoneAuth_With_Firebase/simplephonelogin.dart';
import 'notification_service.dart';

class TowerData {
  String towerId = "";
  bool isLoading = false;
  String towerPhoneNumber = "";
  static List<Map<String, dynamic>> nearestTowers = [];
  late DatabaseReference ref;
  late DatabaseReference nearestTowerRef;

  TowerData() {
    initializeReferences();
  }

  void initializeReferences() {
    ref = FirebaseDatabase.instance.ref().child('towers');
    nearestTowerRef = ref.child('nearestTower');
  }

  YourClass() {
    initializeReferences();
  }

  List<Map<String, dynamic>> requests = [];

  /// ********** class constructor *************
  ///  Future<void> sendRequestNotification()async {
  //     final url=Uri.parse('https://fcm.googleapis.com/fcm/send');
  //   }

  /// ***************** Fetch Towers from Database ***************** ///
  Future<List<Map<String, dynamic>>> fetchTowers() async {
    DataSnapshot snapshot = await this.ref.get();

    List<Map<String, dynamic>> towers = [];
    if (snapshot.exists) {
      Map<dynamic, dynamic>? values = snapshot.value as Map<dynamic, dynamic>?;
      if (values != null) {
        values.forEach((key, value) {
          towers.add({
            'name': value['name'],
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

    /// nearestTowers is a list that contain only the nearest towers to the driver according to the distance between them

    for (var tower in towers) {
      /// check if the tower is active which means he is available or not
      if (tower['available'] == true) {
        double distance = calculateDistance(driverPosition.latitude,
            driverPosition.longitude, tower['latitude'], tower['longitude']);

        /// Add the distance to the tower data for sorting later
        tower['distance'] = distance;

        /// Comparing the distance with the radius
        if (distance <= radius) {
          TowerData.nearestTowers.add(tower);
        }
      }
    }

    /// Sort the nearest towers by distance
    TowerData.nearestTowers
        .sort((a, b) => a['distance'].compareTo(b['distance']));

    /// returning only the nearest towers according to the radius
    return TowerData.nearestTowers;
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

  /// sending the request from the driver to the tower
  Future<void> requestHelp(BuildContext context) async {
    this.isLoading = true;
    await Future.delayed(Duration(seconds: 2));
    if (TowerData.nearestTowers.isNotEmpty) {
      final nearestTower = TowerData.nearestTowers.first;
      this.towerPhoneNumber = nearestTower['phone number'];

      ///  Create a special node for the nearest tower's token
      final nearestTowerRef = this.ref.child(nearestTower['id']);
      final tokenNodeRef = nearestTowerRef.child('nearestTowerToken');

      /// Assuming you have the nearest tower's token available in nearestTower['token']
      await tokenNodeRef.set(nearestTower['token']);

      ///  Send request to the nearest tower
      await nearestTowerRef.child('requests').push().set({
        'driverPhoneNumber': PhoneSignIn.phone,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });

      // Show confirmation message
      showDialog(
        barrierColor: Color(0xffF39F5A).withOpacity(0.5),
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Request Sent',
            style: GoogleFonts.poppins(
                textStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          ),
          content: Text(
            'Help request sent to the nearest tower.',
            style: GoogleFonts.poppins(
                textStyle:
                    TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      );
      this.isLoading = false;
    } else {
      // Show error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'No Towers Available',
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.red)),
          ),
          content: Text('No available towers found nearby.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  /// sending the notification request to the tower

  /// add a listener to listen to any added request in the requests node inside the tower node :
  void listenForRequests(void Function(Map<String, dynamic>?) onRequestAdded) {
    ref.child(towerId).child('requests').onChildAdded.listen((event) {
      // Check if the snapshot value is not null
      if (event.snapshot.value != null) {
        // Convert the data to a map and pass it to the callback function
        final request = Map<String, dynamic>.from(
            event.snapshot.value as Map<dynamic, dynamic>);
        requests.add(request); // Store the request
        onRequestAdded(request); // Call the callback with the new request

        // Send notification to tower using NotificationService
        print("SOHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIB");
        NotificationService.sendNotification(
          title: "Assistance Requested",
          body: "Urgent Response Needed",
          token: AppConstants.token,
        );
      } else {
        // Handle the case where snapshot value is null, if needed
      }
    });
  }
}
