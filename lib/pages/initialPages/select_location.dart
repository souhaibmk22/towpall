import 'package:carihio/pages/authentication/SignUp.dart';
import 'package:carihio/pages/map/maptesting.dart';
import 'package:carihio/pages/map/text.dart';
import 'package:carihio/pages/PhoneAuth_With_Firebase/phone_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../auth2/phon_sign_in.dart';
import 'package:location/location.dart' as loc;
import 'package:carihio/pages/map/text.dart';
import 'package:carihio/pages/map/Node_Generator.dart';
import 'package:carihio/pages/PhoneAuth_With_Firebase/simplephonelogin.dart';
import 'package:carihio/selectUserType.dart';
import 'package:carihio/pages/map/TowerGenerator.dart';

class selecte_location extends StatefulWidget {
  @override
  State<selecte_location> createState() => selecte_locationState();
}

class selecte_locationState extends State<selecte_location> {
  static Position? currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;
  String _yourlocation = "Your Location";
  String _textholder = "Set Location";
  static String currentAdress = "";
  bool _isLoading = false;
  bool _showButton = false;
  loc.Location _location = loc.Location();

  Future<Position> _getCurrentLocation() async {
    servicePermission = await _location.serviceEnabled();
    if (!servicePermission) {
      servicePermission = await _location.serviceEnabled();
      _yourlocation = 'turn on location';
      _isLoading = false;
    }
    if (servicePermission) {
      setState(() {
        _isLoading = true;
      });
    }

    print("Service disabled");
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  _getAdressFromCoordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentLocation!.latitude, currentLocation!.longitude);
      Placemark place = placemarks[0];
      print(place);
      setState(() {
        currentAdress = "${place.subLocality}, ${place.administrativeArea}";
      });
    } catch (e) {
      print("an error is here${e}");
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.148,
                  left: MediaQuery.of(context).size.width * 0.1),
              child: Text(
                'WELCOME',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = Color(0xffF39F5A),
                    ),
                    height: 1.1),
              )),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.175,
                left: MediaQuery.of(context).size.width * 0.1),
            child: Text(
              'SET YOUR LOCATION',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffF39F5A))),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.39,
              left: MediaQuery.of(context).size.width * 0.04,
              right: MediaQuery.of(context).size.width * 0.04,
              height: 180,
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.04,
                  left: MediaQuery.of(context).size.width * 0.04,
                  right: MediaQuery.of(context).size.width * 0.04,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.557), blurRadius: 4)
                    ]),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          child: Icon(
                            Icons.location_on_rounded,
                            size: 25,
                            color: Color(0xffFF833D),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Color(0xffFFE14D)),
                        ),
                        SizedBox(
                          width: 14.74,
                        ),
                        _isLoading
                            ? SpinKitThreeBounce(
                                color: Color(0xffF39F5A), //0xbd5036fa
                                size: 30,
                                duration: Duration(milliseconds: 800),
                              )
                            : Expanded(
                                child: Text(
                                '${_yourlocation}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700)),
                              )),
                      ],
                    ),
                    SizedBox(
                      height: 33,
                    ),
                    Center(
                        child: ElevatedButton(
                            onPressed: () async {
                              if (currentLocation == null) {
                                currentLocation = await _getCurrentLocation();
                                await _getAdressFromCoordinates();

                                setState(() {
                                  if (currentAdress.isNotEmpty) {
                                    _yourlocation = currentAdress;
                                    _textholder = "Next";
                                    //generation of new user node in the database
                                    print("APPENDING NEW NODE TO THE DATABASE");
                                    if (UserTypeSelectionPage.selectedType ==
                                        "driver") {
                                      NodeGenerator.init(
                                          AuthServic.firebaseAuth.currentUser
                                              ?.phoneNumber,
                                          LatLng(currentLocation!.latitude,
                                              currentLocation!.longitude));
                                      NodeGenerator.generate();
                                    } else {
                                      TowerGenerator tower = TowerGenerator(
                                          AuthServic.firebaseAuth.currentUser
                                              ?.phoneNumber,
                                          LatLng(currentLocation!.latitude,
                                              currentLocation!.longitude),
                                          true);
                                      tower.generate();
                                    }
                                  }
                                  ;
                                });
                              } else {
                                Navigator.pushReplacementNamed(
                                    context, "MapPage");
                                print(
                                    "${currentLocation!.longitude}, ${currentLocation!.longitude}");
                              }
                              ;
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.85,
                                    57),
                                backgroundColor: Color(0xffF39F5A)),
                            child: Text(
                              _textholder,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white)),
                            )))
                  ],
                ),
              )),
          Visibility(
              visible: _showButton,
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.75,
                    left: MediaQuery.of(context).size.width * 0.65,
                    right: MediaQuery.of(context).size.width * 0.08,
                    bottom: MediaQuery.of(context).size.height * 0.19),
                child: AnimatedOpacity(
                    opacity: _showButton ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xbd5036fa),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: () {
                        // Button action
                      },
                      child: Text(
                        'Next',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ),
                    )),
              ))
        ],
      ),
    );
  }
}
