import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NodeGenerator {
  static String? phonenumber = "";

  static LatLng location = LatLng(0, 0);

  static void init(String? phone, LatLng locate) {
    phonenumber = phone;
    location = locate;
  }

  static Future<void> generate() async {
    try {
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
      final database =
          FirebaseDatabase.instanceFor(databaseURL: dburl, app: Firebase.app())
              .ref()
              .child("drivers");

      final driverData = <String, dynamic>{
        'phone number': phonenumber,
        'latitude': location.latitude,
        'longitude': location.longitude,
      };

      ///  Check if the phone number exists in the database
      DatabaseEvent event = await database
          .orderByChild('phone number')
          .equalTo(phonenumber)
          .once();

      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? existingUserData =
            event.snapshot.value as Map<dynamic, dynamic>?;
        if (existingUserData != null) {
          String? userId = existingUserData.keys.first;
          if (userId != null) {
            /// Update existing user location
            await database.child(userId).update({
              'latitude': location.latitude,
              'longitude': location.longitude,
            });
            print("User location updated");
          } else {
            print("Error: User key not found");
          }
        } else {
          print("Error: No user data found for the given phone number");
        }
      } else {
        /// Add new user to the database
        await database.push().set(driverData);
        print("User info has been saved");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }
}
