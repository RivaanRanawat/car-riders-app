class Prediction {
  String placeId;
  String primaryText;
  String secondaryText;

  Prediction({this.placeId, this.primaryText, this.secondaryText});

  Prediction.fromJson(Map<String, dynamic> json) {
    placeId = json["place_id"];
    primaryText = json["structured_formatting"]["main_text"];
    secondaryText = json["structured_formatting"]["secondary_text"];
  }
}