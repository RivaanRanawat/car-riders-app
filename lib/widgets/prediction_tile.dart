import 'package:car_rider_app/dataprovider/appData.dart';
import 'package:car_rider_app/helpers/requestHelpers.dart';
import 'package:car_rider_app/models/address.dart';
import 'package:car_rider_app/models/prediction.dart';
import 'package:car_rider_app/universal_variables.dart';
import 'package:car_rider_app/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class PredictionTile extends StatelessWidget {
  final Prediction prediction;
  PredictionTile({this.prediction});

  void getPlaceDetails(String placeId, context) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          ProgressDialog(status: "Please wait.."),
    );
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=${UniversalVariables.mapKey}";
    var res = await RequestHelpers.getRequest(url);

    Navigator.of(context).pop();

    if (res == "failed") {
      return;
    }

    if (res["status"] == "OK") {
      Address placeResult = Address();
      placeResult.placeName = res["result"]["name"];
      placeResult.placeId = placeId;
      placeResult.lat = res["result"]["geometry"]["location"]["lat"];
      placeResult.lat = res["result"]["geometry"]["location"]["lng"];

      Provider.of<AppData>(context, listen: false)
          .updateDestinationAddress(placeResult);
      print(placeResult.placeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        getPlaceDetails(prediction.placeId, context);
      },
      padding: EdgeInsets.all(0),
      child: Container(
        child: Column(
          children: [
            SizedBox(height: 8),
            Row(
              children: [
                Icon(OMIcons.locationOn,
                    color: UniversalVariables.colorDimText),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prediction.primaryText,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        prediction.secondaryText,
                        style: TextStyle(
                            fontSize: 12,
                            color: UniversalVariables.colorDimText),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
