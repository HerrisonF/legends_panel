import 'package:legends_panel/app/layers/data/dtos/queue/queue_dto.dart';

class QueueWrapper {
  List<QueueDto> queues;

  QueueWrapper({required this.queues});

  bool hasQueues() {
    return queues.isNotEmpty;
  }

  QueueDto getMapById(int queueId) {
    QueueDto queueDto = _getEmptyObject();
    if (hasQueues()) {
      return queues.firstWhere((map) => map.queueId == queueId);
    } else {
      return queueDto;
    }
  }

  QueueDto _getEmptyObject() {
    return QueueDto(
      queueId: 0,
      map: '',
      description: '',
      notes: '',
    );
  }
}
