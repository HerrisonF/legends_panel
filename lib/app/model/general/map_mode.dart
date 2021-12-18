class MapMode {
  dynamic queueId = 1;
  String map = "";
  String description = "";
  String notes = "";

  MapMode();

  MapMode.fromJson(Map<String, dynamic> json){
    queueId = json['queueId']??1;
    map = json['map']??"";
    description = json['description']??"";
    notes = json['notes']??"";
  }

  Map<String, dynamic> toJson() => {
    'mapId': queueId,
    'mapName': map,
    'description': description,
    'notes': notes,
  };

  @override
  String toString() {
    return 'MapMode{mapId: $queueId, map: $map, description: $description, notes: $notes}';
  }

}