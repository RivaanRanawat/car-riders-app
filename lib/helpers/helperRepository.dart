import 'package:car_rider_app/dataprovider/appData.dart';
import 'package:car_rider_app/helpers/requestHelpers.dart';
import 'package:car_rider_app/models/address.dart';
import 'package:car_rider_app/models/directionDetails.dart';
import 'package:connectivity/connectivity.dart';
import 'package:car_rider_app/universal_variables.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

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

  static Future<DirectionDetails> getDirectionDetails(LatLng startPos, LatLng endPos) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${startPos.latitude},${startPos.longitude}&destination=${endPos.latitude},${endPos.longitude}&mode=driving&key=${UniversalVariables.mapKey}";
    
    var response = await RequestHelpers.getRequest(url);

    if(response == "failed") {
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails();

    // DURATION
    directionDetails.durationText = response["routes"][0]["legs"][0]["duration"]["text"];
    directionDetails.durationValue = response["routes"][0]["legs"][0]["duration"]["value"];

    // DISTANCE
    directionDetails.distanceText = response["routes"][0]["legs"][0]["distance"]["text"];
    directionDetails.distanceValue = response["routes"][0]["legs"][0]["distance"]["value"];

    //Encoded Points
    directionDetails.encodedPoints = response["routes"][0]["overview_polyline"]["points"];

    return directionDetails;
  }
}
