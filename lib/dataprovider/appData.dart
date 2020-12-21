import 'package:car_rider_app/models/address.dart';
import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier {
  Address pickUpAddress;
  Address destinationAddress;

  void updatePickUpAddress(Address pickup) {
    pickUpAddress = pickup;
    notifyListeners();
  }

  void updateDestinationAddress(Address destination) {
    destinationAddress = destination;
    notifyListeners();
  }
}