import 'package:get/get.dart';
import 'package:legends_panel/app/constants/string_constants.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_perk.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_spectator.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_summoner_spell.dart';
import 'package:legends_panel/app/model/general/user_tier.dart';
import 'package:legends_panel/app/data/repository/profile_repository/participant_repository.dart';

class CurrentGameParticipantController extends MasterController {
  final ParticipantRepository _participantRepository = ParticipantRepository();
  final MasterController _masterController = Get.find<MasterController>();

  RxList<UserTier> userTierList = RxList<UserTier>();
  Rx<UserTier> soloUserTier = UserTier().obs;
  Rx<CurrentGameSpectator> currentGameSpectator = CurrentGameSpectator().obs;

  getUserTier(String id, String region) async {
    userTierList.value = await _participantRepository.getUserTier(id, region);
    _getSoloRankedOnly(userTierList);
  }

  _getSoloRankedOnly(RxList<UserTier> userTierList) {
    soloUserTier.value = userTierList
        .where((tier) => tier.queueType == StringConstants.rankedSolo)
        .first;
    soloUserTier.value.winRate = getUserWinRate();
  }

  String getUserTierImage(String tier) {
    return _participantRepository.getUserTierImage(tier);
  }

  String getUserWinRate() {
    return ((soloUserTier.value.wins /
                (soloUserTier.value.wins + soloUserTier.value.losses)) *
            100)
        .toStringAsFixed(0);
  }

  String getChampionBadgeUrl(String championId) {
    return _participantRepository.getChampionBadgeUrl(
        _masterController.getChampionById(championId),
        _masterController.lolVersion.actualVersion);
  }

  String getSpellUrl(String spellId) {
    Spell spell = _masterController.getSpellById(spellId);
    if (spell.name.isNotEmpty) {
      return _participantRepository.getSpellBadgeUrl(
          spell.id, _masterController.lolVersion.actualVersion);
    } else {
      return "";
    }
  }

  String getItemUrl(String itemId) {
    return _participantRepository.getItemUrl(
        itemId, _masterController.lolVersion.actualVersion);
  }

  String getPositionUrl(String position) {
    return _participantRepository.getPosition(
        position, _masterController.lolVersion.actualVersion);
  }

  getSpectator(String summonerId, String region) async {
    currentGameSpectator.value =
        await _participantRepository.getSpectator(summonerId, region);
  }

  String getPerkStyleUrl(CurrentGamePerk currentGamePerk){
    String perkName = _masterController.getPerkStyle(currentGamePerk);

    return _participantRepository.getPerkUrl(perkName);
  }

  String getFirsPerkUrl(CurrentGamePerk currentGamePerk){
    String perkName = _masterController.getFirstPerkFromPerkStyle(currentGamePerk);
    return _participantRepository.getPerkUrl(perkName);
  }
}
