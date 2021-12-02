import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/result_controllers/current_game_result_controller/current_game_participant_controller.dart';
import 'package:legends_panel/app/model/general/match_detail.dart';

class ProfileResultGameDetailController {
  final MasterController _masterController = Get.find<MasterController>();
  final CurrentGameParticipantController _currentGameParticipantController =
      Get.put(CurrentGameParticipantController());

  Rx<MatchDetail> matchDetail = MatchDetail().obs;
  Rx<Participant> currentParticipant = Participant().obs;

  startProfileResultGame(MatchDetail matchDetail) async {
    this.matchDetail.value = matchDetail;

    getParticipantById(_masterController.userForProfile.value.name);
  }

  getParticipantById(String summonerName) {
    if (matchDetail.value.matchInfo.participants.length > 0) {
      for (Participant elementParticipant
          in matchDetail.value.matchInfo.participants) {
        if (elementParticipant.summonerName == summonerName) {
          this.currentParticipant.value = elementParticipant;
          break;
        }
      }
    }
  }

  String getSpellImage(int spellId) {
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
