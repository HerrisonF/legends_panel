import 'package:flutter/material.dart';
import 'package:legends_panel/app/core/general_controller/general_controller.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_banned_champion_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_info_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_participant_model.dart';

class ActiveGameResultController {

  late final ActiveGameInfoModel activeGameInfoModel;
  late final GeneralController generalController;

  List<ActiveGameParticipantModel> blueTeam = [];
  List<ActiveGameParticipantModel> redTeam = [];
  List<ActiveGameBannedChampionModel> bansReadTeam = [];
  List<ActiveGameBannedChampionModel> bansBlueTeam = [];
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  static const BLUE_TEAM = 100;

  ActiveGameResultController({
    required this.activeGameInfoModel,
    required this.generalController,
  }){
    startLoading();
    detachTeams();
    detachChampionBanTeams();
    stopLoading();
  }

  startLoading(){
    isLoading.value = true;
  }

  stopLoading(){
    isLoading.value = false;
  }

  detachTeams() {

    for(ActiveGameParticipantModel participantModel in activeGameInfoModel.activeGameParticipants) {
      if (participantModel.teamId == BLUE_TEAM) {
        blueTeam.add(participantModel);
      } else {
        redTeam.add(participantModel);
      }
    }
  }

  detachChampionBanTeams(){
    const BLUE_TEAM = 100;
    for(ActiveGameBannedChampionModel bannedChampion in activeGameInfoModel.activeGameBannedChampions) {
      if (bannedChampion.teamId == BLUE_TEAM) {
        bansBlueTeam.add(bannedChampion);
      } else {
        bansReadTeam.add(bannedChampion);
      }
    }
  }

  int getCurrentGameMinutes() {
    return activeGameInfoModel.gameLength;
  }
}
