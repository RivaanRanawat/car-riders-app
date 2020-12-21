import 'dart:async';
import 'package:car_rider_app/dataprovider/appData.dart';
import 'package:car_rider_app/helpers/helperRepository.dart';
import 'package:car_rider_app/screens/search_screen.dart';
import 'package:car_rider_app/styles.dart';
import 'package:car_rider_app/universal_variables.dart';
import 'package:car_rider_app/widgets/reusable_divider.dart';
import "package:flutter/material.dart";
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  double searchSheetHeight = 300;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  double mapPadding = 0.0;
  var geoLocator = Geolocator();
  Position currentPos;

  void setPositionLocator() async {
    Position position = await geoLocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPos = position;

    LatLng pos = LatLng(position.latitude, position.longitude);
    String address =
        await HelperRepository.findCordinatesAddress(position, context);
    print("Address " + address);
    CameraPosition cp = new CameraPosition(target: pos, zoom: 14);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
    print(position);
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
        width: 250,
        color: Colors.white,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.all(0),
            children: [
              Container(
                height: 160,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/user_icon.png",
                        height: 60,
                        width: 60,
                      ),
                      SizedBox(width: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Rivaan Ranawat",
                            style: TextStyle(
                                fontSize: 20, fontFamily: "Bolt-Bold"),
                          ),
                          SizedBox(height: 5),
                          Text("View Profile"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ReusableDivider(),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(OMIcons.cardGiftcard),
                title: Text(
                  "Free Rides",
                  style: kDrawerItemStyle,
                ),
              ),
              ListTile(
                leading: Icon(OMIcons.creditCard),
                title: Text(
                  "Payments",
                  style: kDrawerItemStyle,
                ),
              ),
              ListTile(
                leading: Icon(OMIcons.history),
                title: Text(
                  "Trip History",
                  style: kDrawerItemStyle,
                ),
              ),
              ListTile(
                leading: Icon(OMIcons.contactSupport),
                title: Text(
                  "Support",
                  style: kDrawerItemStyle,
                ),
              ),
              ListTile(
                leading: Icon(OMIcons.info),
                title: Text(
                  "About",
                  style: kDrawerItemStyle,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: mapPadding),
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              mapController = controller;

              setState(() {
                mapPadding = 270;
              });

              setPositionLocator();
            },
          ),
          // Drawer Button
          Positioned(
            top: 44,
            left: 22,
            child: GestureDetector(
              onTap: () {
                scaffoldKey.currentState.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7)),
                    ]),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Icon(Icons.menu, color: Colors.black),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.38,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text("Glad to see you!",
                        style: TextStyle(
                          fontSize: 10,
                        )),
                    Text(
                      "Where do you wanna go?",
                      style:
                          TextStyle(fontSize: 18, fontFamily: "Bolt-Semibold"),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => SearchScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 0.5,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7),
                              )
                            ]),
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
                    ),

                    SizedBox(height: 22),
                    // HOME ADDRESS
                    Row(
                      children: [
                        Icon(OMIcons.home,
                            color: UniversalVariables.colorDimText),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                (Provider.of<AppData>(context)
                                            .pickUpAddress !=
                                        null)
                                    ? Provider.of<AppData>(context)
                                        .pickUpAddress
                                        .placeName
                                    : "Add Home",
                                style: TextStyle(fontFamily: "Bolt-Regular"),
                              ),
                            ),
                            SizedBox(height: 3),
                            Text("Your Address",
                                style: TextStyle(
                                    fontFamily: "Bolt-Regular",
                                    fontSize: 11,
                                    color: UniversalVariables.colorDimText))
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
                        Icon(OMIcons.workOutline,
                            color: UniversalVariables.colorDimText),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add Work",
                              style: TextStyle(fontFamily: "Bolt-Regular"),
                            ),
                            SizedBox(height: 3),
                            Text("Your Work Address",
                                style: TextStyle(
                                    fontFamily: "Bolt-Regular",
                                    fontSize: 11,
                                    color: UniversalVariables.colorDimText))
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
