import 'dart:async';
import 'dart:ui' as ui;
import 'package:carihio/pages/PhoneAuth_With_Firebase/simplephonelogin.dart';
import 'package:carihio/pages/map/appConst.dart';
import 'package:carihio/pages/map/markerWidget.dart';
import 'package:carihio/pages/PhoneAuth_With_Firebase/phone_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:carihio/pages/initialPages/select_location.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:widget_to_marker/widget_to_marker.dart';
import 'containers.dart';
import 'draggablesheet.dart';
import 'dart:math';
import 'package:carihio/selectUserType.dart';
import 'DIsplayNearestTowers.dart';

class MapPage extends StatefulWidget {
  static Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Map<String, dynamic>> nearestTowers = [];
  int counter = 0;
  TowerData tower = TowerData();
  late GoogleMapController googleMapController;
  final usersRef = FirebaseDatabase.instanceFor(
          databaseURL: AppConstants.dburl, app: Firebase.app())
      .ref();
  static late BitmapDescriptor endmarker;
  final TextEditingController DestinationController = TextEditingController();
  Uint8List? marketimages;

  List<String> images = [
    'images/CarMarker.png',
    'images/TM1.png',
    'images/TM2.png',
    'images/TM3.png',
  ];
  TextEditingController TextSuggestionController = TextEditingController();
  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (AppConstants.controller.isCompleted) {
      AppConstants.controller = Completer();
    }
    initgoogleMapController();
    fetchUserCoordinates();
    DraggableSheet.controller.addListener(onChanged);
    print(
        "----------------------------------------AMIIIIIIIIIIIIIIIIIIIIIIIIIIIIIINE------------");
  }

  Future<void> initgoogleMapController() async {
    googleMapController = await AppConstants.controller.future;
  }

  Future<void> fetchUserCoordinates() async {
    print(
        '===============================${AppConstants.markers.length}===========================');

    /// we must verify if the user is a simple driver or a tower if he is a driver i will display to him all the towers location on the map :
    if (UserTypeSelectionPage.selectedType == "driver") {
      /// displaying the nearest towers on to the driver
      addMarkerToMap(AppConstants.myLocation.latitude,
          AppConstants.myLocation.longitude, PhoneSignIn.phone);
      Position position = await tower.latLngToPosition(AppConstants.myLocation);
      nearestTowers = await tower.getNearestTowers(position, 10000);
      counter = nearestTowers.length;
      AppConstants.markers.clear();
      if (nearestTowers.isNotEmpty) {
        nearestTowers.forEach((tower) {
          addMarkerToMap(tower["latitude"], tower["longitude"], tower["name"]);
        });
        towerinitiat();
      }
    }
  }

  Future<void> addMarkerToMap(
      double? latitude, double? longitude, String? name) async {
    Uint8List carMarker = await MapPage.getImages('images/TM1.png', 100);
    LatLng position = LatLng(latitude!, longitude!);
    Marker marker = Marker(
        markerId: MarkerId('user_marker ${AppConstants.markers.length + 1}'),
        position: position,
        icon: BitmapDescriptor.fromBytes(carMarker),
        infoWindow: InfoWindow(title: name));
    setState(() {
      AppConstants.markers.add(marker);
    });
    print(
        '=============================${AppConstants.markers.length}============================');
  }

  Future<void> goToTheLake() async {
    try {
      final CameraPosition kLake = CameraPosition(
        target: LatLng(AppConstants.myLocation.latitude,
            AppConstants.myLocation.longitude),
        zoom: 13,
      );

      final GoogleMapController mapController =
          await AppConstants.controller.future;
      await mapController.animateCamera(CameraUpdate.newCameraPosition(kLake));
      mapController.dispose();
    } catch (e) {
      print('Error while animating camera: $e');
      // Handle the exception (e.g., show an error message to the user)
    }
  }

  void onChanged() {
    final currentSize = DraggableSheet.controller.size;
    if (currentSize <= 0.05) {
      collapse();
    }
  }

  void collapse() => animateSheet(getSheet.snapSizes!.first);

  void anchor() => animateSheet(getSheet.snapSizes!.last);

  void expant() => animateSheet(getSheet.maxChildSize);

  void hide() => animateSheet(getSheet.maxChildSize);

  void animateSheet(double size) {
    DraggableSheet.controller.animateTo(size,
        duration: const Duration(microseconds: 100), curve: Curves.bounceIn);
  }

  DraggableScrollableSheet get getSheet =>
      (DraggableSheetState.getsheetKey().currentWidget
          as DraggableScrollableSheet);

  void initendmarker() async {
    endmarker = await MarkerWidget(output: "resault").toBitmapDescriptor(
        logicalSize: ui.Size(80, 80), imageSize: Size(250, 250));
  }

  void towerinitiat() {
    AddTower.towers.clear();
    nearestTowers.forEach((tower) {
      print(tower);
      print(tower["name"]);
      AddTower.add(tower["name"], "images/TM1.png", 1, tower["latitude"],
          tower["longitude"], tower["phone number"]);
      print(tower["name"]);
    });
  }

  double calculateZoomLevel(
      LatLngBounds bounds, double screenWidth, int distance) {
    const double MAX_ZOOM = 21; // Maximum allowed zoom level

    // Calculate the map's horizontal span in meters
    double metersPerPixel =
        (bounds.northeast.latitude - bounds.southwest.latitude) / screenWidth;
    double mapWidthInMeters = distance * 2;

    // Calculate the zoom level based on the map's width and maximum zoom level
    double zoom =
        (log(mapWidthInMeters * 360.0 / (256 * metersPerPixel)) * ln10) / ln2;
    // Clamp the zoom level to the maximum allowed zoom
    return zoom > MAX_ZOOM ? MAX_ZOOM : zoom;
  }

  Future<void> _moveToPrediction(String prediction) async {
    final List<Location> location = await locationFromAddress(prediction);
    GoogleMapController googleMapController =
        await AppConstants.controller.future;
    await googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(location.last.latitude, location.last.longitude),
            zoom: 15)));
    googleMapController.dispose();
    setState(() async {
      _drawPolyline(location);
      AppConstants.markers.add(Marker(
          markerId: MarkerId("sourceMarker"),
          icon: BitmapDescriptor.fromBytes(
              await MapPage.getImages('images/destination.png', 100)),
          position: LatLng(AppConstants.myLocation.latitude,
              AppConstants.myLocation.longitude)));
      _drawPolyline(location);
    });
  }

  Future<void> _drawPolyline(List<Location> location) async {
    TravelMode travelMode = TravelMode.driving;
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult resault = await polylinePoints.getRouteBetweenCoordinates(
        AppConstants.apiKey,
        PointLatLng(AppConstants.myLocation.latitude,
            AppConstants.myLocation.longitude),
        PointLatLng(location.last.latitude, location.last.longitude),
        travelMode: travelMode);
    if (resault.points.isNotEmpty) {}
    setState(() {
      List<LatLng> locations = [
        LatLng(AppConstants.myLocation.latitude,
            AppConstants.myLocation.longitude),
        LatLng(location.last.latitude, location.last.longitude)
      ];
      adjustZoomLevel(
          resault.distanceValue,
          LatLng(AppConstants.myLocation.latitude,
              AppConstants.myLocation.longitude),
          LatLng(location.last.latitude, location.last.longitude),
          locations);
      polylineCoordinates.clear();
      _displayDistanceMarker(resault.distance!, location);
      resault.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    });
  }

  LatLngBounds calculateBoundsFromLatLngList(List<LatLng> points) {
    double minLat = double.infinity;
    double maxLat = -double.infinity;
    double minLng = double.infinity;
    double maxLng = -double.infinity;

    for (LatLng point in points) {
      minLat = min(minLat, point.latitude);
      maxLat = max(maxLat, point.latitude);
      minLng = min(minLng, point.longitude);
      maxLng = max(maxLng, point.longitude);
    }

    LatLng southwest = LatLng(minLat, minLng);
    LatLng northeast = LatLng(maxLat, maxLng);

    return LatLngBounds(southwest: southwest, northeast: northeast);
  }

  Future<void> adjustZoomLevel(int? distance, LatLng source, LatLng distination,
      List<LatLng> locations) async {
    GoogleMapController googleMapController =
        await AppConstants.controller.future;
    if (distance! > 0) {
      LatLng midpoint = LatLng((source.latitude + distination.latitude) / 2,
          (source.longitude + distination.longitude) / 2);
      LatLngBounds bounds = calculateBoundsFromLatLngList(locations);
      double screenWidth = MediaQuery.of(context).size.width;
      print("========================$distance==============================");
      double zoomLevel = calculateZoomLevel(bounds, screenWidth, distance);
      print(
          ":::::::::::::::::::::::::::::::::::::::::::::::::::::$zoomLevel=====================================");

      await googleMapController
          .animateCamera(CameraUpdate.newLatLngBounds(bounds, 90));
      googleMapController.dispose();
    }
  }

  Future<void> _displayDistanceMarker(
      String resault, List<Location> location) async {
    endmarker = await MarkerWidget(output: resault).toBitmapDescriptor(
        logicalSize: Size(MediaQuery.of(context).size.width * 0.24,
            MediaQuery.of(context).size.height * 0.24),
        imageSize: Size(250, 250));
    AppConstants.markers.add(Marker(
      markerId: MarkerId("destinationMarker"),
      icon: endmarker,
      position: LatLng(location.last.latitude, location.last.longitude),
    ));
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(
              AppConstants.myLocation.latitude,
              AppConstants.myLocation.longitude,
            ),
            zoom: 5),
        mapType: MapType.normal,
        cloudMapId: AppConstants.mapid,
        onMapCreated: (GoogleMapController controller) {
          if (!AppConstants.controller.isCompleted) {
            AppConstants.controller.complete(controller);
          } else {
            googleMapController = controller;
          }
        },
        markers: AppConstants.markers,
        polylines: {
          Polyline(
              polylineId: PolylineId("destination"),
              color: Color(0xffF39F5A),
              width: 4,
              endCap: Cap.roundCap,
              points: polylineCoordinates)
        },
      ),
      Positioned(
          top: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          left: MediaQuery.of(context).size.width * 0.02,
          child: Row(children: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            icon: Icon(
                              Icons.account_circle,
                              size: 43,
                              color: Color(0Xc302394A),
                              shadows: [
                                BoxShadow(
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 5)
                              ],
                            ),
                            title: Text(
                              "Log out",
                              style: GoogleFonts.poppins(
                                  textStyle:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                            content: Container(
                                height: 120,
                                child: Column(
                                  children: [
                                    Text(
                                      "Do you want to log out ?",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                backgroundColor:
                                                    Color(0xffF39F5A)),
                                            onPressed: () async {
                                              await AuthServic.logout();
                                              Navigator.pushReplacementNamed(
                                                  context, "phonesignein");
                                              selecte_locationState
                                                  .currentLocation = null;
                                            },
                                            child: Text(
                                              "Yes",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            )),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                backgroundColor:
                                                    Color(0xffF39F5A)),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "No",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ))
                                      ],
                                    )
                                  ],
                                )),
                          ));
                },
                icon: Icon(
                  Icons.account_circle,
                  color: Color(0Xc302394A),
                  size: 47,
                  shadows: [
                    BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 5)
                  ],
                )),
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 10)
                        ]),
                    child: GooglePlaceAutoCompleteTextField(
                      textEditingController: TextSuggestionController,
                      googleAPIKey: AppConstants.apiKey,
                      textStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      inputDecoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'add destination',
                          hintStyle: TextStyle(
                              fontSize: 14, fontWeight: ui.FontWeight.w700)),
                      isLatLngRequired: false,
                      debounceTime: 300,
                      countries: ["dz"],
                      itemClick: (Prediction prediction) async {
                        TextSuggestionController.text = prediction.description!;
                        TextSuggestionController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: prediction.description!.length));
                        setState(() {
                          _moveToPrediction(prediction.description!);
                        });
                      },
                      itemBuilder: (context, index, Prediction prediction) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(
                                width: 7,
                              ),
                              Expanded(
                                  child: Text(
                                "${prediction.description ?? ""}",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500)),
                              ))
                            ],
                          ),
                        );
                      },
                    )))
          ])),
      Positioned(
          right: MediaQuery.of(context).size.width * 0.001,
          top: MediaQuery.of(context).size.height * 0.5,
          child: ElevatedButton(
            onPressed: () async {
              await goToTheLake();
              print(
                  "==================why it dosn't goes to lake=================");
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffffa153),
                shape: CircleBorder(),
                minimumSize: ui.Size(50, 50)),
            child: Icon(
              Icons.my_location_outlined,
              color: Colors.white,
            ),
          )),
      SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          child: DraggableSheet(
            child: Center(
              child: Column(children: [
                SizedBox(
                  height: 6,
                ),
                Container(
                  width: 60,
                  height: 6,
                  decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(5)),
                ),
                SizedBox(
                  height: 9,
                ),
                Text(
                  'Choose a tower or swipe up for more',
                  style:
                      GoogleFonts.poppins(textStyle: TextStyle(fontSize: 13)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 150,
                    child: ListView.separated(
                        separatorBuilder: (BuildContextcontext, intindex) {
                          return SizedBox(width: 10);
                        },
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: AddTower.towers.length,
                        itemBuilder: (BuildContextcontext, int index) {
                          return SizedBox(
                              height: 100, child: AddTower.towers[index]);
                        })),
                SizedBox(
                  height: 50,
                )
              ]),
            ),
          ))
    ]));
  }

  void dispose() {
    if (AppConstants.controller.isCompleted) {
      googleMapController.dispose();
      AppConstants.controller = Completer();
    }
    AppConstants.markers.clear();
    super.dispose();
  }

  void deactivate() {
    super.deactivate();
  }
}
