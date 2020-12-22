import "package:car_rider_app/models/nearByDrivers.dart";

class FireHelper {
  static List<NearByDrivers> nearByDriverList = [];

  static void removeFromList(String key) {
    int index = nearByDriverList.indexWhere((element) => element.key == key);
    nearByDriverList.removeAt(index);
  }

  static void updateNearByLocation(NearByDrivers driver) {
    int index = nearByDriverList.indexWhere((element) => element.key == driver.key);
    nearByDriverList[index].longitude = driver.longitude;
    nearByDriverList[index].latitude = driver.latitude;
  }
}