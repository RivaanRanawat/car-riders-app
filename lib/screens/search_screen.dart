import 'package:car_rider_app/dataprovider/appData.dart';
import 'package:car_rider_app/helpers/requestHelpers.dart';
import 'package:car_rider_app/universal_variables.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var pickupController = TextEditingController();
  var destinationController = TextEditingController();

  var focusDestination = FocusNode();
  bool isFocused = false;

  void setFocus() {
    if (!isFocused) {
      FocusScope.of(context).requestFocus(focusDestination);
      isFocused = true;
    }
  }

  void searchPlace(String placeName) async {
    if (placeName.length > 1) {
      String url =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=1600+Amphitheatre&key=${UniversalVariables.mapKey}&sessiontoken=1234567890";
      var res = await RequestHelpers.getRequest(url);

      if (res == "failed") {
        return;
      }
      print(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    setFocus();
    String address =
        Provider.of<AppData>(context).pickUpAddress.placeName ?? "";
    pickupController.text = address;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 218,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, top: 48, right: 24, bottom: 20),
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Stack(
                    children: [
                      GestureDetector(
                        child: Icon(Icons.arrow_back),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Center(
                        child: Text(
                          "Set Destination",
                          style: TextStyle(
                              fontSize: 20, fontFamily: "Nunito-Bold"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18),
                  Row(
                    children: [
                      Image.asset("assets/images/pickicon.png",
                          height: 16, width: 16),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: UniversalVariables.colorLightGrayFair,
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextField(
                              controller: pickupController,
                              decoration: InputDecoration(
                                  hintText: "Pickup Location",
                                  fillColor:
                                      UniversalVariables.colorLightGrayFair,
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(
                                      left: 10, top: 8, bottom: 8)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Image.asset("assets/images/desticon.png",
                          height: 16, width: 16),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: UniversalVariables.colorLightGrayFair,
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextField(
                              onChanged: (val) {
                                searchPlace(val);
                              },
                              focusNode: focusDestination,
                              controller: destinationController,
                              decoration: InputDecoration(
                                  hintText: "Destination",
                                  fillColor:
                                      UniversalVariables.colorLightGrayFair,
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(
                                      left: 10, top: 8, bottom: 8)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
