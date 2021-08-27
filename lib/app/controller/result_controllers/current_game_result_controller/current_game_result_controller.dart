import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/util_controller/util_controller.dart';
import 'package:legends_panel/app/data/model/current_game_spectator/current_game_banned_champion.dart';
import 'package:legends_panel/app/data/model/current_game_spectator/current_game_participant.dart';
import 'package:legends_panel/app/data/model/current_game_spectator/current_game_spectator.dart';
import 'package:legends_panel/app/data/model/general/map_mode.dart';

class CurrentGameResultController extends UtilController {
  final MasterController _masterController = Get.find<MasterController>();

  CurrentGameSpectator currentGameSpectator = CurrentGameSpectator();
  Rx<MapMode> mapMode = MapMode().obs;
  RxList<CurrentGameParticipant> blueTeam = RxList<CurrentGameParticipant>();
  RxList<CurrentGameParticipant> redTeam = RxList<CurrentGameParticipant>();
  RxList<CurrentGameBannedChampion> blueTeamBannedChamp =
      RxList<CurrentGameBannedChampion>();
  RxList<CurrentGameBannedChampion> redTeamBannedChamp =
      RxList<CurrentGameBannedChampion>();

  startController(CurrentGameSpectator currentGameSpectator) {
    _clearOldSearch();
    setCurrentGameSpectator(currentGameSpectator);
    detachParticipantsIntoTeams();
    getMapById(currentGameSpectator.mapId.toString());
  }

  setCurrentGameSpectator(CurrentGameSpectator spectator) {
    this.currentGameSpectator = spectator;
  }

  _clearOldSearch() {
    blueTeam.clear();
    redTeam.clear();
    blueTeamBannedChamp.clear();
    redTeamBannedChamp.clear();
  }

  detachParticipantsIntoTeams() {
    for (int i = 0; i < 10; i++) {
      CurrentGameParticipant currentGameParticipant =
          currentGameSpectator.currentGameParticipants[i];
      CurrentGameBannedChampion currentGameBannedChampion =
          currentGameSpectator.bannedChampions[i];
      if (currentGameParticipant.teamId == 100) {
        blueTeam.add(currentGameParticipant);
        blueTeamBannedChamp.add(currentGameBannedChampion);
      } else {
        redTeam.add(currentGameParticipant);
        redTeamBannedChamp.add(currentGameBannedChampion);
      }
    }
  }

  String getCurrentGameMinutes() {
    return getConvertedTimeInMinutes(currentGameSpectator.gameLength);
  }

  getMapById(String mapId) {
    this.mapMode.value = _masterController.getMapById(mapId);
  }
}
