import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class TowerGenerator {
  String? name;
  String? phoneNumber;
  LatLng location;
  bool available;
  String? token;

  TowerGenerator(
      this.name, this.phoneNumber, this.location, this.available, this.token);

  void switchAvailability() {
    this.available = !this.available;
  }

  Future<void> generate() async {
    await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      await FirebaseAuth.instance.signInAnonymously();
      user = FirebaseAuth.instance.currentUser;
    }

    if (user == null) {
      print('Error: No authenticated user.');
      return;
    }

    final dburl = dotenv.env["dbURL"];
    if (dburl == null) {
      print("Error: Database URL not found in environment variables.");
      return;
    }

    final database =
        FirebaseDatabase.instanceFor(databaseURL: dburl, app: Firebase.app())
            .ref()
            .child("towers");

    final towerData = <String, dynamic>{
      'name': this.name,
      'phone number': this.phoneNumber,
      'latitude': this.location.latitude,
      'longitude': this.location.longitude,
      'available': this.available,
      'token': this.token
    };

    try {
      // Check if the phone number exists in the database
      DatabaseEvent event = await database
          .orderByChild('phone number')
          .equalTo(this.phoneNumber)
          .once();

      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? existingUserData =
            event.snapshot.value as Map<dynamic, dynamic>?;
        if (existingUserData != null) {
          String? towerId = existingUserData.keys.first;
          if (towerId != null) {
            // Update existing user location
            await database.child(towerId).update({
              'latitude': location.latitude,
              'longitude': location.longitude,
              'available': this.available,
            });
            print("Tower location updated");
          } else {
            print("Error: tower key not found");
          }
        } else {
          print("Error: No tower data found for the given phone number");
        }
      } else {
        // Add new user to the database
        await database.push().set(towerData);
        print("Tower info has been saved");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }
}
