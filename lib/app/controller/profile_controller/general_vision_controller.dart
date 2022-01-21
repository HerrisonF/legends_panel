import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/data_analysis_controller/data_analysis_controller.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/data/repository/general_vision_repository/general_vision_repository.dart';
import 'package:legends_panel/app/model/general/map_mode.dart';
import 'package:legends_panel/app/model/general/match_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GeneralVisionController {
  final GeneralVisionRepository _generalVisionRepository =
      GeneralVisionRepository();

  late MatchDetail matchDetail;
  late Participant participant;

  Rx<bool> isLoadingTeamInfo = false.obs;
  Rx<MapMode> currentMapToShow = MapMode().obs;

  RxList<Participant> blueTeam = RxList<Participant>();
  RxList<Participant> redTeam = RxList<Participant>();

  final MasterController _masterController = Get.find<MasterController>();
  final DataAnalysisController dataAnalysisController =
      DataAnalysisController();

  static const BLUE_TEAM = 100;

  startInitialData(MatchDetail matchDetail, Participant participant) {
    blueTeam.clear();
    redTeam.clear();
    getMapById(matchDetail.matchInfo.queueId.toString());
    isLoadingTeamInfo(true);
    this.participant = participant;
    this.matchDetail = matchDetail;
    detachParticipantsIntoTeams();
    dataAnalysisController.getGameTimeLine(
      matchDetail.matchInfo.gameId.toString(),
      _masterController.storedRegion.getKeyFromRegion(_masterController.storedRegion.lastStoredProfileRegion.toString())!,
      participant,
    );
  }

  String getWinOrLoseHeaderText(BuildContext context) {
    if (participant.win) {
      if (participant.teamId == BLUE_TEAM) {
        return "${AppLocalizations.of(context)!.gameVictoriousBlueTeam}";
      } else {
        return "${AppLocalizations.of(context)!.gameVictoriousRedTeam}";
      }
    } else {
      if (participant.teamId == BLUE_TEAM) {
        return "${AppLocalizations.of(context)!.gameDefeatedBlueTeam}";
      } else {
        return "${AppLocalizations.of(context)!.gameDefeatedRedTeam}";
      }
    }
  }

  getMapById(String queueId) {
    this.currentMapToShow.value = _masterController.getMapById(queueId);
  }

  detachParticipantsIntoTeams() {
    for (int i = 0; i < matchDetail.matchInfo.participants.length; i++) {
      if (matchDetail.matchInfo.participants[i].teamId == BLUE_TEAM) {
        blueTeam.add(matchDetail.matchInfo.participants[i]);
      } else {
        redTeam.add(matchDetail.matchInfo.participants[i]);
      }
    }
    isLoadingTeamInfo(false);
  }

  String getBaronIcon() {
    return _generalVisionRepository.getBaronIcon();
  }

  String getDragonIcon() {
    return _generalVisionRepository.getDragonIcon();
  }

  String getTowerIcon() {
    return _generalVisionRepository.getTowerIcon();
  }

  String getKillIcon() {
    return _generalVisionRepository.getKillIcon();
  }

  String getPerkStyleUrl(String perkStyle) {
    return _generalVisionRepository.getPerkStyleUrl(perkStyle);
  }

  String getPerkUrl(String perk) {
    return _generalVisionRepository.getPerkUrl(perk);
  }

  String getMinionUrl() {
    return _generalVisionRepository.getMinionUrl();
  }

  String getGoldIconUrl() {
    return _generalVisionRepository.getGoldIconUrl();
  }

  String getHeraldIcon() {
    return _generalVisionRepository.getHeraldIcon();
  }

  String getCriticIcon() {
    return _generalVisionRepository.getCriticIcon();
  }
}
