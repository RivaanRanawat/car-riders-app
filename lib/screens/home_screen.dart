import 'dart:async';
import 'package:car_rider_app/universal_variables.dart';
import 'package:car_rider_app/widgets/reusable_divider.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              mapController = controller;
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 15,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text("Glad to see you!", style: TextStyle(fontSize: 10,)),
                    Text("Where do you wanna go?", style: TextStyle(fontSize: 18,fontFamily: "Bolt-Semibold"),),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 0.5,
                            spreadRadius: 0.5,
                            offset: Offset(
                              0.7,
                              0.7
                            ),
                          )
                        ]
                      ),
                      // SEARCH PANEL
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.blueAccent),
                            SizedBox(width: 10),
                            Text("Search Destination"),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 22),
                    // HOME ADDRESS
                    Row(
                      children: [
                        Icon(OMIcons.home, color: UniversalVariables.colorDimText),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add Home", style: TextStyle(fontFamily: "Bolt-Regular"),),
                            SizedBox(height: 3),
                            Text("Your Address", style: TextStyle(fontFamily: "Bolt-Regular" ,fontSize: 11, color: UniversalVariables.colorDimText))
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    ReusableDivider(),
                    SizedBox(height: 16),
                    // WORK ADDRESS
                    Row(
                      children: [
                        Icon(OMIcons.workOutline, color: UniversalVariables.colorDimText),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add Work", style: TextStyle(fontFamily: "Bolt-Regular"),),
                            SizedBox(height: 3),
                            Text("Your Work Address", style: TextStyle(fontFamily: "Bolt-Regular" ,fontSize: 11, color: UniversalVariables.colorDimText))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
