import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_spectator.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_summoner_spell.dart';
import 'package:legends_panel/app/model/general/champion.dart';
import 'package:legends_panel/app/model/general/user_tier.dart';
import 'package:legends_panel/app/data/repository/profile_repository/participant_repository.dart';

class CurrentGameParticipantController extends MasterController {

  final ParticipantRepository _participantRepository = ParticipantRepository();
  final MasterController _masterController = Get.find<MasterController>();

  RxList<UserTier> userTierList = RxList<UserTier>();
  Rx<UserTier> soloUserTier = UserTier().obs;
  Rx<CurrentGameSpectator> currentGameSpectator = CurrentGameSpectator().obs;

  getUserTier(String id) async {
    userTierList.value = await _participantRepository.getUserTier(id);
    _getSoloRankedOnly(userTierList);
  }

  _getSoloRankedOnly(RxList<UserTier> userTierList) {
    soloUserTier.value =
        userTierList.where((tier) => tier.queueType == 'RANKED_SOLO_5x5').first;
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
    Champion champion = _masterController.getChampionById(championId);
    return _participantRepository.getChampionBadgeUrl(
        champion.detail.id, _masterController.lolVersion);
  }

  String getSpellUrl(String spellId) {
    Spell spell = _masterController.getSpellById(spellId);
    return _participantRepository.getSpellBadgeUrl(
        spell.id, _masterController.lolVersion);
  }

  String getItemUrl(String itemId){
    return _participantRepository.getItemUrl(itemId, _masterController.lolVersion);
  }

  String getPositionUrl(String position){
    return _participantRepository.getPosition(position, _masterController.lolVersion);
  }

  getSpectator(String summonerId) async {
    currentGameSpectator.value =
        await _participantRepository.getSpectator(summonerId);
  }
}
