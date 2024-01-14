import 'package:flutter/material.dart';
import 'package:legends_panel/app/modules/profile/data/repositories/match_detail_repository.dart';
import 'package:legends_panel/app/modules/profile/domain/models/match_detail_model.dart';

class MatchDetailComponentController {
  late MatchDetailRepository matchDetailRepository;
  late MatchDetailModel matchDetail;

  ValueNotifier<bool> isLoadingTeamInfo = ValueNotifier(false);

  ValueNotifier<List<ParticipantModel>> blueTeam = ValueNotifier([]);
  ValueNotifier<List<ParticipantModel>> redTeam = ValueNotifier([]);

  static const BLUE_TEAM = 100;

  MatchDetailComponentController({
    required this.matchDetailRepository,
    required this.matchDetail,
  }){
    matchDetail.info!.doPlacar();
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
    return matchDetailRepository.getBaronIcon();
  }

  String getDragonIcon() {
    return matchDetailRepository.getDragonIcon();
  }

  String getTowerIcon() {
    return matchDetailRepository.getTowerIcon();
  }

  String getInhibitorIcon(){
    return matchDetailRepository.getInhibitorIcon();
  }

  String getKillIcon() {
    return matchDetailRepository.getKillIcon();
  }

  String getMinionUrl() {
    return matchDetailRepository.getMinionUrl();
  }

  String getGoldIconUrl() {
    return matchDetailRepository.getGoldIconUrl();
  }

  String getHeraldIcon() {
    return matchDetailRepository.getHeraldIcon();
  }

  String getCriticIcon() {
    return matchDetailRepository.getCriticIcon();
  }
}
