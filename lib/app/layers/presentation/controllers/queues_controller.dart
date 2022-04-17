import 'package:get/get.dart';
import 'package:legends_panel/app/layers/domain/entities/queue/queue_entity.dart';
import 'package:legends_panel/app/layers/domain/usecases/queue/get_queues_usecase.dart';

import '../../data/dtos/queue/queue_wrapper_dto.dart';

class QueuesController {
  final GetQueuesUseCase _getQueuesUseCase;

  QueuesController(this._getQueuesUseCase);

  late QueueWrapperDto cachedQueues;
  Rx<QueueEntity> currentMapToShow = QueueEntity(queueId: 0, map: '', description: '', notes: '').obs;

  initialize() {
    _getQueuesRemoteUseCase();
  }

  _getQueuesRemoteUseCase() async {
    var result = await _getQueuesUseCase();
    result.fold(
      (l) => null,
      (r) => cachedQueues = r,
    );
  }

  getCurrentMapById(int queueId){
    currentMapToShow.value = cachedQueues.getMapById(queueId);
  }

  String getQueueDescriptionWithoutGamesString(){
    return currentMapToShow.value.getQueueDescriptionWithoutGamesString();
  }
}
