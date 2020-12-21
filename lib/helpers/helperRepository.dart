import 'package:car_rider_app/dataprovider/appData.dart';
import 'package:car_rider_app/helpers/requestHelpers.dart';
import 'package:car_rider_app/models/address.dart';
import 'package:connectivity/connectivity.dart';
import 'package:car_rider_app/universal_variables.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class HelperRepository {
  static Future<String> findCordinatesAddress(Position position, context) async {
    String placeAddress = "";
    var connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult!=ConnectivityResult.mobile && connectivityResult!=ConnectivityResult.wifi) {
      return placeAddress;
    }

    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${UniversalVariables.mapKey}";
    var res = await RequestHelpers.getRequest(url);

    if(res != "failed") {
      placeAddress = res["results"][0]["formatted_address"];
      Address pickUpAddress = Address();
      pickUpAddress.lat = position.latitude;
      pickUpAddress.lng = position.longitude;
      pickUpAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false).updatePickUpAddress(pickUpAddress);
    }
    return placeAddress;
  }
}