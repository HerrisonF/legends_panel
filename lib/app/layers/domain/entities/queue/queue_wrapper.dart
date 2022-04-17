import 'package:legends_panel/app/layers/domain/entities/queue/queue_entity.dart';

class QueueWrapper {
  List<QueueEntity> queues;

  QueueWrapper({required this.queues});

  bool hasQueues() {
    return queues.isNotEmpty;
  }

  QueueEntity getMapById(int queueId) {
    QueueEntity queueEntity = _getEmptyObject();
    if (hasQueues()) {
      return queues.firstWhere((map) => map.queueId == queueId);
    } else {
      return queueEntity;
    }
  }

  QueueEntity _getEmptyObject() {
    return QueueEntity(
      queueId: 0,
      map: '',
      description: '',
      notes: '',
    );
  }
}
