import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/modules/profile/domain/models/match_detail_model.dart';
import 'package:legends_panel/app/modules/profile/data/repositories/general_vision_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GeneralVisionController {
  final GeneralVisionRepository _generalVisionRepository =
      GeneralVisionRepository(
        logger: GetIt.I<Logger>(),
      );

  late MatchDetailModel matchDetail;
  late ParticipantModel participant;

  ValueNotifier<bool> isLoadingTeamInfo = ValueNotifier(false);

  ValueNotifier<List<ParticipantModel>> blueTeam = ValueNotifier([]);
  ValueNotifier<List<ParticipantModel>> redTeam = ValueNotifier([]);

  static const BLUE_TEAM = 100;

  startInitialData(MatchDetailModel matchDetail, ParticipantModel participant) {
    blueTeam.value.clear();
    redTeam.value.clear();
    isLoadingTeamInfo.value = true;
    this.participant = participant;
    this.matchDetail = matchDetail;
    detachParticipantsIntoTeams();
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

  }

  detachParticipantsIntoTeams() {
    for (int i = 0; i < matchDetail.info!.participants.length; i++) {
      if (matchDetail.info!.participants[i].teamId == BLUE_TEAM) {
        blueTeam.value.add(matchDetail.info!.participants[i]);
      } else {
        redTeam.value.add(matchDetail.info!.participants[i]);
      }
    }
    isLoadingTeamInfo.value = false;
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
