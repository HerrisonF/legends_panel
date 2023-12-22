class MapaDTO {
  int mapId;
  String mapName;
  String notes;

  MapaDTO({
    required this.mapId,
    required this.mapName,
    required this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'mapId': mapId,
      'mapName': mapName,
      'notes': notes,
    };
  }

  factory MapaDTO.fromJson(Map<String, dynamic> json) {
    return MapaDTO(
      mapId: json['mapId'] ?? 0,
      mapName: json['mapName'] ?? '',
      notes: json['element'] ?? '',
    );
  }
}
