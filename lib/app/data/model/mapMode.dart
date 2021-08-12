class MapMode {
  dynamic mapId = 1;
  String mapName = "";
  String notes = "";

  MapMode({this.mapId = 1, this.mapName = "", this.notes = ""});

  MapMode.fromJson(Map<String, dynamic> json){
    mapId = json['mapId'];
    mapName = json['mapName'];
    notes = json['notes'];
  }
}