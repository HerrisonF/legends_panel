import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/util_controller/util_controller.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_banned_champion.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_participant.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_spectator.dart';
import 'package:legends_panel/app/model/general/map_mode.dart';

class CurrentGameResultController extends UtilController {
  final MasterController _masterController = Get.find<MasterController>();
  String region = "";

  CurrentGameSpectator currentGameSpectator = CurrentGameSpectator();
  Rx<MapMode> currentMapToShow = MapMode().obs;
  RxList<CurrentGameParticipant> blueTeam = RxList<CurrentGameParticipant>();
  RxList<CurrentGameParticipant> redTeam = RxList<CurrentGameParticipant>();

  static const BLUE_TEAM = 100;

  startController(CurrentGameSpectator currentGameSpectator, String region) {
    this.region = _masterController.storedRegion.getKeyFromRegion(region)!;
    _clearOldCurrentGameSearch();
    setCurrentGameSpectator(currentGameSpectator);
    detachParticipantsIntoTeams();
    getMapById(currentGameSpectator.gameQueueConfigId.toString());
  }

  setCurrentGameSpectator(CurrentGameSpectator spectator) {
    this.currentGameSpectator = spectator;
  }

  _clearOldCurrentGameSearch() {
    blueTeam.clear();
    redTeam.clear();
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
        blueTeam.add(currentGameParticipant);
      }else {
        redTeam.add(currentGameParticipant);
      }
    }
  }

  bool isPlayingMapWithBans() => currentGameSpectator.bannedChampions.length > 0;

  int getCurrentGameMinutes() {
    return currentGameSpectator.gameLength;
  }

  getMapById(String queueId) {
    this.currentMapToShow.value = _masterController.getMapById(queueId);
  }

  String getCurrentMapDescription(){
    String replacedText = currentMapToShow.value.description.replaceAll("games", "");
    return replacedText;
  }
}
