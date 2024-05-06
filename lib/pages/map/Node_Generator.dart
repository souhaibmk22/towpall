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
    final dburl = dotenv.env["dbURL"];
    final database =
        FirebaseDatabase.instanceFor(databaseURL: dburl, app: Firebase.app())
            .ref()
            .child("users");
    final user = <String, dynamic>{
      'phone number': phonenumber,
      'latitude': location.latitude,
      'longitude': location.longitude,
    };

    ///Testing if the current user number exist in the database or not ??
    DatabaseEvent event =
        await database.orderByChild('phone number').equalTo(phonenumber).once();

    ///if he already in the db we will update the location of this current user
    print(event.snapshot.value);
    if (event.snapshot.value != null) {
      Map<dynamic, dynamic>? userData =
          event.snapshot.value as Map<dynamic, dynamic>?;
      print(userData?.keys.first);
      if (userData != null) {
        String? userId = userData.keys.first;
        database.child(userId!).update({
          'latitude': location.latitude,
          'longitude': location.longitude,
        }).then((_) => print("User location updated"));
      } else {
        print("Error: User key not found");
      }
    } else {
      ///else we add it to the liste of users in the db
      database
          .push()
          .set(user)
          .then((_) => print("user info has been saved"))
          .catchError((error) => print("you got an error $error"));
    }
  }
}
