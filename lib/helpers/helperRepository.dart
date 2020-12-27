import 'dart:math';

import 'package:car_rider_app/dataprovider/appData.dart';
import 'package:car_rider_app/helpers/requestHelpers.dart';
import 'package:car_rider_app/models/address.dart';
import 'package:car_rider_app/models/directionDetails.dart';
import 'package:car_rider_app/models/user.dart';
import 'package:connectivity/connectivity.dart';
import 'package:car_rider_app/universal_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import "package:http/http.dart" as http;
import "dart:convert";

class HelperRepository {
  static Future<String> findCordinatesAddress(
      Position position, context) async {
    String placeAddress = "";
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      return placeAddress;
    }

    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${UniversalVariables.mapKey}";
    var res = await RequestHelpers.getRequest(url);

    if (res != "failed") {
      placeAddress = res["results"][0]["formatted_address"];
      Address pickUpAddress = Address();
      pickUpAddress.lat = position.latitude;
      pickUpAddress.lng = position.longitude;
      pickUpAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false)
          .updatePickUpAddress(pickUpAddress);
    }
    return placeAddress;
  }

  static Future<DirectionDetails> getDirectionDetails(
      LatLng startPos, LatLng endPos) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${startPos.latitude},${startPos.longitude}&destination=${endPos.latitude},${endPos.longitude}&mode=driving&key=${UniversalVariables.mapKey}";

    var response = await RequestHelpers.getRequest(url);

    if (response == "failed") {
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails();

    // DURATION
    directionDetails.durationText =
        response["routes"][0]["legs"][0]["duration"]["text"];
    directionDetails.durationValue =
        response["routes"][0]["legs"][0]["duration"]["value"];

    // DISTANCE
    directionDetails.distanceText =
        response["routes"][0]["legs"][0]["distance"]["text"];
    directionDetails.distanceValue =
        response["routes"][0]["legs"][0]["distance"]["value"];

    //Encoded Points
    directionDetails.encodedPoints =
        response["routes"][0]["overview_polyline"]["points"];

    return directionDetails;
  }

  static int estimateFares(DirectionDetails details) {
    // Calculate fares:
    // BASE FARE(because rider sat in the vehicle) + DISTANCE FARE(amt for every km)+ TIME FARE(amt for every minute)
    // we will charge:
    // /km = ₹50
    // /minute = ₹10
    // base fare = ₹70

    double baseFare = 40;
    double distanceFare = (details.distanceValue / 1000) * 20;
    double timeFare = (details.durationValue / 60) * 5;

    double totalFare = baseFare + distanceFare + timeFare;

    return totalFare.truncate();
  }

  static void getCurrentUserInfo() async {
    currentFirebaseUser = await FirebaseAuth.instance.currentUser();
    String currentUid = currentFirebaseUser.uid;
    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child("users/$currentUid");
    userRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        currentUserInfo = User.fromSnapshot(snapshot);
        print(currentUserInfo.fullName);
      }
    });
  }

  static double generateRandomNumber(int max) {
    var randomGenerator = Random();
    int radInt = randomGenerator.nextInt(max);
    return radInt.toDouble();
  }

  static sendNotification(String token, context, String ride_id) async {
    var destination =
        Provider.of<AppData>(context, listen: false).destinationAddress;

    Map<String, String> headerMap = {
      'Content-Type': 'application/json',
      'Authorization': serverKey,
    };

    Map notificationMap = {
      'title': 'NEW TRIP REQUEST',
      'body': 'Destination, ${destination.placeName}'
    };

    Map dataMap = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'ride_id': ride_id,
    };

    Map bodyMap = {
      'notification': notificationMap,
      'data': dataMap,
      'priority': 'high',
      'to': token
    };

    var response = await http.post('https://fcm.googleapis.com/fcm/send',
        headers: headerMap, body: jsonEncode(bodyMap));

    print(response.body);
  }
}
