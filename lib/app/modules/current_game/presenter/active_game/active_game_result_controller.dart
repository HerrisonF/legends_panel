import 'package:flutter/material.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_info_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_participant_model.dart';

class ActiveGameResultController {
  String region = "";

  late final ActiveGameInfoModel activeGameInfoModel;

  List<ActiveGameParticipantModel> blueTeam = [];
  List<ActiveGameParticipantModel> redTeam = [];
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  ActiveGameResultController({
    required this.activeGameInfoModel,
  }){
    startLoading();
    detachTeams();
    stopLoading();
  }

  startLoading(){
    isLoading.value = true;
  }

  stopLoading(){
    isLoading.value = false;
  }

  detachTeams() {
    const BLUE_TEAM = 100;

    for(ActiveGameParticipantModel participantModel in activeGameInfoModel.activeGameParticipants) {
      if (participantModel.teamId == BLUE_TEAM) {
        blueTeam.add(participantModel);
      } else {
        redTeam.add(participantModel);
      }
    }
  }

  int getCurrentGameMinutes() {
    return activeGameInfoModel.gameLength;
  }
}
