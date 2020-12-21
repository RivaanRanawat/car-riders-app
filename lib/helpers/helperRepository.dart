import 'package:car_rider_app/helpers/requestHelpers.dart';
import 'package:connectivity/connectivity.dart';
import 'package:car_rider_app/universal_variables.dart';
import 'package:geolocator/geolocator.dart';

class HelperRepository {
  static Future<String> findCordinatesAddress(Position position) async {
    String address = "";
    var connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult!=ConnectivityResult.mobile && connectivityResult!=ConnectivityResult.wifi) {
      return address;
    }

    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${UniversalVariables.mapKey}";
    var res = await RequestHelpers.getRequest(url);

    if(res != "failed") {
      address = res["results"][0]["formatted_address"];
    }
    return address;
  }
}