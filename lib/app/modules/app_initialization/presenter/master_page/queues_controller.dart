import 'package:flutter/material.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/lol_constants_model.dart';

class QueuesController {
  late LolConstantsModel lolConstantsModel;
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<bool> initialize() async {
    return await fetchLocalQueues();
  }

  Future<bool> fetchLocalQueues() async {
    startLoading();

    ///Buscar as queues localmente e colocar no modelo
    return false;
    stopLoading();
  }

  startLoading() {
    isLoading.value = true;
  }

  stopLoading() {
    isLoading.value = false;
  }

  String getQueueDescriptionWithoutGamesString({
    required int queueId,
  }) {
    return lolConstantsModel.getMapQueueById(queueId);
  }
}
