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
  RxList<CurrentGameBannedChampion> blueTeamBannedChamp =
      RxList<CurrentGameBannedChampion>();
  RxList<CurrentGameBannedChampion> redTeamBannedChamp =
      RxList<CurrentGameBannedChampion>();

  startController(CurrentGameSpectator currentGameSpectator, String region) {
    this.region = region;
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

      if (currentGameParticipant.teamId == 100) {
        blueTeam.add(currentGameParticipant);
      } else {
        redTeam.add(currentGameParticipant);
      }

      if (currentGameSpectator.bannedChampions.length > 0) {
        CurrentGameBannedChampion currentGameBannedChampion =
            currentGameSpectator.bannedChampions[i];
        if (currentGameParticipant.teamId == 100) {
          blueTeamBannedChamp.add(currentGameBannedChampion);
        } else {
          redTeamBannedChamp.add(currentGameBannedChampion);
        }
      }
    }
  }

  String getCurrentGameMinutes() {
    if (getConvertedTimeInMinutes(currentGameSpectator.gameLength) == "00") {
      return "01";
    } else {
      return getConvertedTimeInMinutes(currentGameSpectator.gameLength);
    }
  }

  getMapById(String mapId) {
    this.currentMapToShow.value = _masterController.getMapById(mapId);
  }
}
