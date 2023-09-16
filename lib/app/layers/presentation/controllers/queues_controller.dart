import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:legends_panel/app/layers/domain/entities/queue/queue_entity.dart';
import 'package:legends_panel/app/layers/domain/usecases/queue/get_queues_usecase.dart';

import '../../domain/entities/queue/queue_wrapper.dart';

class QueuesController {
  final GetQueuesUseCase _getQueuesUseCase;

  QueuesController(this._getQueuesUseCase);

  late QueueWrapper cachedQueues;
  ValueNotifier<QueueEntity> currentMapToShow = ValueNotifier(
    QueueEntity(
      queueId: 0,
      map: '',
      description: '',
      notes: '',
    ),
  );

  Future<bool> initialize() async {
    return await _getQueuesRemoteUseCase();
  }

  Future<bool> _getQueuesRemoteUseCase() async {
    Either<Exception, QueueWrapper> result = await _getQueuesUseCase();
    return result.fold(
      (error) => false,
      (success) {
        cachedQueues = success;
        return true;
      },
    );
  }

  getCurrentMapById(int queueId) {
    currentMapToShow.value = cachedQueues.getMapById(queueId);
  }

  String getQueueDescriptionWithoutGamesString() {
    return currentMapToShow.value.getQueueDescriptionWithoutGamesString();
  }
}
