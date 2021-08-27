import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/result_controllers/current_game_result_controller/current_game_participant_controller.dart';
import 'package:legends_panel/app/data/model/general/match_detail.dart';
import 'package:legends_panel/app/data/repository/profile_repository/profile_resutlt_game_detail_repository.dart';

class ProfileResultGameDetailController {
  final ProfileResultGameDetailRepository _profileResultGameDetailRepository =
      ProfileResultGameDetailRepository();
  final MasterController _masterController = Get.find<MasterController>();
  final CurrentGameParticipantController _currentGameParticipantController =
      Get.put(CurrentGameParticipantController());

  Rx<MatchDetail> matchDetail = MatchDetail().obs;
  Rx<ParticipantIdentitie> participantIdentitie = ParticipantIdentitie().obs;
  Rx<Participant> participant = Participant().obs;

  startProfileResultGame(String gameId) async {
    matchDetail.value =
        await _profileResultGameDetailRepository.getMatchDetail(gameId);
    getParticipantById(
        _masterController.userProfile.value.accountId.toString());
  }

  getParticipantById(String accountId) {
    if (matchDetail.value.participantIdentities.length > 0) {
      participantIdentitie.value = matchDetail.value.participantIdentities
          .where((participant) =>
              participant.player.accountId.toString() == accountId)
          .first;
      participant.value = matchDetail.value.participants
          .where((participantEl) =>
              participantEl.participantId.toString() ==
              participantIdentitie.value.participantId.toString())
          .first;
    }
  }

  String getSpellImage(int spellId) {
    return _currentGameParticipantController.getSpellUrl(
      _getParticipantSpellId(spellId),
    );
  }

  String _getParticipantSpellId(int id) {
    if (id == 1) {
      return participant.value.spell1d.toString();
    } else {
      return participant.value.spell2d.toString();
    }
  }

  String getChampionBadgeUrl(String championId) {
    return _currentGameParticipantController.getChampionBadgeUrl(
      championId,
    );
  }
}
