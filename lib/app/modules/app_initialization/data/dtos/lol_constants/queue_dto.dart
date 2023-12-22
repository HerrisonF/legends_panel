class QueueDto {
  int queueId;
  String map;
  String description;
  String notes;

  QueueDto({
    required this.queueId,
    required this.map,
    required this.description,
    required this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'queueId': queueId,
      'map': map,
      'description': description,
      'notes': notes,
    };
  }

  factory QueueDto.fromJson(Map<String, dynamic> json) {
    return QueueDto(
      queueId: json['queueId'] ?? 0,
      map: json['map'] ?? '',
      description: json['description'] ?? '',
      notes: json['element'] ?? '',
    );
  }
}
