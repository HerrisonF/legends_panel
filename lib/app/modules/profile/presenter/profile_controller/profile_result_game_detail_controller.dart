import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/match_detail.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_page/current_game_participant_controller.dart';

class ProfileResultGameDetailController {
  final CurrentGameParticipantController _currentGameParticipantController =
  GetIt.I<CurrentGameParticipantController>();

  ValueNotifier<MatchDetail> matchDetail = ValueNotifier(MatchDetail());
  ValueNotifier<Participant> currentParticipant = ValueNotifier(Participant());

  startProfileResultGame(MatchDetail matchDetail) async {
    this.matchDetail.value = matchDetail;

    //getParticipantById(_masterController.userForProfile.id);
  }

  getParticipantById(String summonerId) {
    if (matchDetail.value.matchInfo.participants.length > 0) {
      var list = matchDetail.value.matchInfo.participants.where((element) => element.summonerId == summonerId);
      if(list.length > 0){
        this.currentParticipant.value = list.first;
        currentParticipant.notifyListeners();
      }
    }
  }

  getSpellImage(int spellId) {
    return _currentGameParticipantController.getSpellUrl(
      _getParticipantSpellId(spellId),
    );
  }

  String getItemUrl(String itemId){
    return _currentGameParticipantController.getItemUrl(itemId);
  }

  String getPositionUrl(String position){
    return _currentGameParticipantController.getPositionUrl(position);
  }


  String _getParticipantSpellId(int id) {
    if (id == 1) {
      return currentParticipant.value.summoner1Id.toString();
    } else {
      return currentParticipant.value.summoner2Id.toString();
    }
  }

  String getChampionBadgeUrl() {
    return _currentGameParticipantController.getChampionBadgeUrl(
        currentParticipant.value.championId.toString()
    );
  }
}