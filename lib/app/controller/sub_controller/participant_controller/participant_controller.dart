import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/data/model/champion.dart';
import 'package:legends_panel/app/data/model/spectator/spectator.dart';
import 'package:legends_panel/app/data/model/spectator/summoner_spell.dart';
import 'package:legends_panel/app/data/model/userTier.dart';
import 'package:legends_panel/app/data/repository/participant_repository.dart';

class ParticipantController extends MasterController{

  ParticipantRepository _participantRepository = ParticipantRepository();
  MasterController _masterController = Get.find<MasterController>();

  RxList<UserTier> userTierList = RxList<UserTier>();
  Rx<UserTier> soloUserTier = UserTier().obs;
  Rx<Spectator> spectator = Spectator().obs;

  getUserTier(String id) async {
    userTierList.value = await _participantRepository.getUserTier(id);
    _getSoloRankedOnly(userTierList);
  }

  _getSoloRankedOnly(RxList<UserTier> userTierList){
    soloUserTier.value = userTierList.where((tier) => tier.queueType == 'RANKED_SOLO_5x5').first;
    soloUserTier.value.winRate = getUserWinRate();
  }

  String getUserTierImage(String tier){
    return _participantRepository.getUserTierImage(tier);
  }

  String getUserWinRate() {
    return ((soloUserTier.value.wins / (soloUserTier.value.wins + soloUserTier.value.losses)) * 100).toStringAsFixed(0);
  }

  String getChampionBadgeUrl(String championId){
    Champion champion = _masterController.getChampionById(championId);
    return _participantRepository.getChampionBadgeUrl(champion.detail.id, _masterController.lolVersion.value);
  }

  String getSpellUrl(String spellId){
    Spell spell = _masterController.getSpellById(spellId);
    return _participantRepository.getSpellBadgeUrl(spell.id, _masterController.lolVersion.value);
  }

  getSpectator(String summonerId) async {
    spectator.value = await _participantRepository.getSpectator(summonerId);
  }
}