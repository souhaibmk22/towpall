import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:carihio/pages/map/markerWidget.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carihio/pages/map/appConst.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'containers.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:widget_to_marker/widget_to_marker.dart';
import 'draggablesheet.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late BitmapDescriptor endmarker;
  late double _panelHeight = 440; // Initial height of the panel
  bool _isPanelExpanded = false;
  final double _draggableAreaHeight = 50.0;
  final TextEditingController DestinationController = TextEditingController();
  static CameraPosition _kLake = CameraPosition(
      target: LatLng(
          AppConstants.myLocation.latitude, AppConstants.myLocation.longitude),
      zoom: 13);
  Uint8List? marketimages;
  List<String> images = [
    'images/CarMarker.png',
    'images/TM1.png',
    'images/TM2.png',
    'images/TM3.png',
  ];
  TextEditingController TextSuggestionController = TextEditingController();
  List<LatLng> polylineCoordinates = [];
  late Set<Marker> _markers = {};

  initMarkers() async {
    _markers = {};
    _markers.add(Marker(
        markerId: MarkerId("first"),
        position: const LatLng(31.327664623766296, 34.348287509514314)));
  }

  final List<LatLng> _latLen = <LatLng>[
    LatLng(AppConstants.myLocation.latitude, AppConstants.myLocation.longitude),
    LatLng(AppConstants.Tm1position.target.latitude,
        AppConstants.Tm1position.target.longitude),
    LatLng(AppConstants.Tm2position.target.latitude,
        AppConstants.Tm2position.target.longitude),
    LatLng(AppConstants.Tm3position.target.latitude,
        AppConstants.Tm3position.target.longitude)
  ];

  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await AppConstants.controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initialize loadData method
    loadData();
    initendmarker();
    towerinitiat();
    DraggableSheet.controller.addListener(onChanged);
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
      (DraggableSheet.sheeto.currentWidget as DraggableScrollableSheet);

  initendmarker() async {
    endmarker = await MarkerWidget(output: "resault").toBitmapDescriptor(
        logicalSize: ui.Size(80, 80), imageSize: Size(250, 250));
  }

  loadData() async {
    for (int i = 0; i < images.length; i++) {
      Uint8List markIcons = await getImages(images[i], 200);
      if (i > 0) {
        markIcons = await getImages(images[i], 100);
      }
      // makers added according to index
      _markers.add(Marker(
        // given marker id
        markerId: MarkerId(i.toString()),
        // given marker icon
        icon: BitmapDescriptor.fromBytes(markIcons),
        // given position
        position: _latLen[i],
        infoWindow: InfoWindow(
          // given title for marker
          title: 'Tower ' + i.toString(),
        ),
      ));
      setState(() {});
    }
  }

  towerinitiat() {
    for (int i = 0; i < 3; i++) {
      AddTower.add("Tower ${i + 1}", AppConstants.imagePath[i], i);
    }
  }

  Future<void> _moveToPrediction(String prediction) async {
    final GoogleMapController controller = await AppConstants.controller.future;
    final List<Location> location = await locationFromAddress(prediction);
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(location.last.latitude, location.last.longitude),
            zoom: 15)));
    setState(() async {
      _drawPolyline(location);
      _markers.add(Marker(
          markerId: MarkerId("sourceMarker"),
          icon: BitmapDescriptor.fromBytes(
              await getImages('images/destination.png', 100)),
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
    if (resault.points.isNotEmpty) {
      polylineCoordinates.clear();
      _displayDistanceMarker(resault.distance!, location);
      resault.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {});
  }

  Future<void> _displayDistanceMarker(
      String resault, List<Location> location) async {
    endmarker = await MarkerWidget(output: resault).toBitmapDescriptor(
        logicalSize: Size(MediaQuery.of(context).size.width * 0.24,
            MediaQuery.of(context).size.height * 0.24),
        imageSize: Size(250, 250));
    _markers.add(Marker(
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
          AppConstants.controller.complete(controller);
        },
        markers: _markers,
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
          left: MediaQuery.of(context).size.width * 0.05,
          height: 55,
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
                  textStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                inputDecoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'add destination',
                  hintStyle: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
                isLatLngRequired: false,
                debounceTime: 300,
                countries: ["dz"],
                itemClick: (Prediction prediction) async {
                  TextSuggestionController.text = prediction.description!;
                  TextSuggestionController.selection =
                      TextSelection.fromPosition(
                          TextPosition(offset: prediction.description!.length));
                  _moveToPrediction(prediction.description!);

                  //await controller.animateCamera(CameraUpdate.newCameraPosition(
                  //CameraPosition(
                  //target: LatLng(prediction.lat as double,
                  //prediction.lng as double))));
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
                                  fontSize: 13, fontWeight: FontWeight.w500)),
                        ))
                      ],
                    ),
                  );
                },
              ))),
      Positioned(
          right: MediaQuery.of(context).size.width * 0.001,
          top: MediaQuery.of(context).size.height * 0.5,
          child: ElevatedButton(
            onPressed: _goToTheLake,
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
                    height: 110,
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
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffffa153),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              minimumSize: Size(270, 45)),
                          child: Text(
                            "Request Now",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: ui.FontWeight.w700)),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(
                                  252, 219, 197, 0.9764705882352941),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {},
                          child: Icon(
                            Icons.calendar_month_sharp,
                            color: Color.fromRGBO(243, 159, 90, 1),
                            size: 30,
                          ))
                    ]),
              ]),
            ),
          ))
    ]));
  }
}
