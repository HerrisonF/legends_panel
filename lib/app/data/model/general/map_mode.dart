class MapMode {
  dynamic mapId = 1;
  String mapName = "";
  String notes = "";

  MapMode();

  MapMode.fromJson(Map<String, dynamic> json){
    mapId = json['mapId']??1;
    mapName = json['mapName']??"";
    notes = json['notes']??"";
  }

  @override
  String toString() {
    return 'MapMode{mapId: $mapId, mapName: $mapName, notes: $notes}';
  }
}