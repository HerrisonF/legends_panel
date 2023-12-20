import 'package:legends_panel/app/modules/app_initialization/data/dtos/queue/queue_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/queue/queue_wrapper.dart';

class QueueWrapperDto extends QueueWrapper {

  QueueWrapperDto({required List<QueueDto> queues}) : super(queues: queues);

  toJson() => {
    'queues' : queues.map((e) => e.toJson()).toList()
  };

  static fromJson(dynamic map){
    List<QueueDto> queues = [];
    map.forEach((element){
      queues.add(QueueDto.fromJson(element));
    });
    return QueueWrapperDto(queues: queues);
  }

  static fromLocalJson(dynamic map){
    List<QueueDto> queues = [];
    map["queues"].forEach((element){
      queues.add(QueueDto.fromJson(element));
    });
    return QueueWrapperDto(queues: queues);
  }
}