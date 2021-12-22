import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/model/general/match_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GeneralVisionController {

  late MatchDetail matchDetail;
  late Participant participant;

  RxList<Participant> blueTeam = RxList<Participant>();
  RxList<Participant> redTeam = RxList<Participant>();

  static const BLUE_TEAM = 100;

  startInitialData(MatchDetail matchDetail, Participant participant){
    this.participant = participant;
    this.matchDetail = matchDetail;
    detachParticipantsIntoTeams();
  }

  String getWinOrLoseHeaderText(BuildContext context){
    if(participant.win){
      if(participant.teamId == BLUE_TEAM){
        return "${AppLocalizations.of(context)!.gameVictoriousBlueTeam}";
      }else{
        return "${AppLocalizations.of(context)!.gameVictoriousRedTeam}";
      }
    }else{
      if(participant.teamId == BLUE_TEAM){
        return "${AppLocalizations.of(context)!.gameDefeatedBlueTeam}";
      }else{
        return "${AppLocalizations.of(context)!.gameDefeatedRedTeam}";
      }
    }
  }

  detachParticipantsIntoTeams() {
    for (int i = 0; i < matchDetail.matchInfo.participants.length; i++) {
      if (matchDetail.matchInfo.participants[i].teamId == BLUE_TEAM) {
        blueTeam.add(matchDetail.matchInfo.participants[i]);
      }else {
        redTeam.add(matchDetail.matchInfo.participants[i]);
      }
    }
  }

}