import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/layers/presentation/controllers/queues_controller.dart';
import 'package:legends_panel/app/layers/presentation/util_controllers/util_controller.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_banned_champion.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_participant.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_spectator.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/master_page/master_controller/master_controller.dart';

class CurrentGameResultController extends UtilController {
  final MasterController _masterController = GetIt.I<MasterController>();
  final QueuesController _queuesController = GetIt.I<QueuesController>();
  String region = "";

  CurrentGameSpectator currentGameSpectator = CurrentGameSpectator();
  ValueNotifier<List<CurrentGameParticipant>> blueTeam = ValueNotifier([]);
  ValueNotifier<List<CurrentGameParticipant>> redTeam = ValueNotifier([]);

  static const BLUE_TEAM = 100;

  startController(CurrentGameSpectator currentGameSpectator, String region) {
    this.region = _masterController.storedRegion.getKeyFromRegion(region)!;
    _clearOldCurrentGameSearch();
    setCurrentGameSpectator(currentGameSpectator);
    detachParticipantsIntoTeams();
    _queuesController.getCurrentMapById(currentGameSpectator.gameQueueConfigId);
  }

  setCurrentGameSpectator(CurrentGameSpectator spectator) {
    this.currentGameSpectator = spectator;
  }

  _clearOldCurrentGameSearch() {
    blueTeam.value.clear();
    redTeam.value.clear();
  }

  detachParticipantsIntoTeams() {
    for (int i = 0; i < currentGameSpectator.currentGameParticipants.length; i++) {
      CurrentGameParticipant currentGameParticipant =
          currentGameSpectator.currentGameParticipants[i];
      if(isPlayingMapWithBans()){
        currentGameParticipant.currentGameBannedChampion = currentGameSpectator.bannedChampions[i];
      }else{
        currentGameParticipant.currentGameBannedChampion = CurrentGameBannedChampion();
      }

      if (currentGameParticipant.teamId == BLUE_TEAM) {
        blueTeam.value.add(currentGameParticipant);
      }else {
        redTeam.value.add(currentGameParticipant);
      }
    }
  }

  bool isPlayingMapWithBans() => currentGameSpectator.bannedChampions.length > 0;

  int getCurrentGameMinutes() {
    return currentGameSpectator.gameLength;
  }

  String getCurrentMapDescription(){
    return _queuesController.getQueueDescriptionWithoutGamesString();
  }
}
