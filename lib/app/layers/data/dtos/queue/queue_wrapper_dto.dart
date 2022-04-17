import 'package:legends_panel/app/layers/data/dtos/queue/queue_dto.dart';
import 'package:legends_panel/app/layers/domain/entities/queue/queue_wrapper.dart';

class QueueWrapperDto extends QueueWrapper {

  QueueWrapperDto({required List<QueueDto> queues}) : super(queues: queues);

  toJson() => {
    'queues' : queues.map((e) => e.toString()).toList()
  };

  static fromJson(dynamic map){
    List<QueueDto> queues = [];
    map.forEach((element){
      queues.add(QueueDto.fromJson(element));
    });
    return QueueWrapperDto(queues: queues);
  }
}