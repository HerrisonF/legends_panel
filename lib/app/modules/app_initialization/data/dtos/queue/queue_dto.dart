import 'package:legends_panel/app/modules/app_initialization/domain/models/queue/queue_entity.dart';

class QueueDto extends QueueEntity {

  QueueDto({
    required int queueId,
    required String map,
    required String description,
    required String notes,
  }) : super(
          queueId: queueId,
          map: map,
          description: description,
          notes: notes,
        );

  toJson() => {
        'queueId': queueId,
        'map': map,
        'description': description,
        'notes': notes,
      };

  static fromJson(Map<String, dynamic> json) {
    return QueueDto(
      queueId: json['queueId'] ?? '',
      map: json['map'] ?? '',
      description: json['description'] ?? '',
      notes: json['element'] ?? '',
    );
  }
}
