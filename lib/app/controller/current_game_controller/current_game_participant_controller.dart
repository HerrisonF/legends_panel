import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/constants/string_constants.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/layers/presentation/controllers/lol_version_controller.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_participant.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_perk.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_spectator.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_summoner_spell.dart';
import 'package:legends_panel/app/model/general/user_tier.dart';
import 'package:legends_panel/app/data/repository/profile_repository/participant_repository.dart';

class CurrentGameParticipantController extends MasterController {
  final ParticipantRepository _participantRepository = ParticipantRepository();
  final MasterController _masterController = GetIt.I<MasterController>();
  final LolVersionController _lolVersionController =
      GetIt.I<LolVersionController>();

  ValueNotifier<List<UserTier>> userTierList = ValueNotifier([]);
  ValueNotifier<UserTier> soloUserTier = ValueNotifier(UserTier());
  ValueNotifier<CurrentGameSpectator> currentGameSpectator = ValueNotifier(CurrentGameSpectator());
  CurrentGameParticipant currentGameParticipant = CurrentGameParticipant();

  getUserTier(CurrentGameParticipant participant, String region) async {
    this.currentGameParticipant = participant;
    userTierList.value = await _participantRepository.getUserTier(
        this.currentGameParticipant.summonerId, region);
    _getSoloRankedOnly(userTierList.value);
  }

  _getSoloRankedOnly(List<UserTier> userTierList) {
    try {
      soloUserTier.value = userTierList
          .where((tier) => tier.queueType == StringConstants.rankedSolo)
          .first;
      soloUserTier.value.winRate = getUserWinRate();
    } catch (e) {
      soloUserTier.value.winRate = 0.toString();
    }
    // saveSearchedUserTier();
  }

  // saveSearchedUserTier() {
  //   if (_masterController.userForCurrentGame.name ==
  //       this.currentGameParticipant.summonerName) {
  //     _masterController
  //         .addUserToFavoriteCurrentGameList(soloUserTier.value.tier);
  //   }
  // }

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
        _masterController.getChampionById(championId).detail.id.toString(),
        _lolVersionController.cachedLolVersion.getLatestVersion());
  }

  String getSpellUrl(String spellId) {
    Spell spell = _masterController.getSpellById(spellId);
    if (spell.name.isNotEmpty) {
      return _participantRepository.getSpellBadgeUrl(
          spell.id, _lolVersionController.cachedLolVersion.getLatestVersion());
    } else {
      return "";
    }
  }

  String getItemUrl(String itemId) {
    return _participantRepository.getItemUrl(
        itemId, _lolVersionController.cachedLolVersion.getLatestVersion());
  }

  String getPositionUrl(String position) {
    return _participantRepository.getPosition(
        position, _lolVersionController.cachedLolVersion.getLatestVersion());
  }

  getSpectator(String summonerId, String region) async {
    currentGameSpectator.value =
        await _participantRepository.getSpectator(summonerId, region);
  }

  String getPerkStyleUrl(CurrentGamePerk currentGamePerk) {
    String perkName =
        _masterController.getPerkSubStyleIconName(currentGamePerk);

    return _participantRepository.getPerkUrl(perkName);
  }

  String getFirsPerkUrl(CurrentGamePerk currentGamePerk) {
    String perkName =
        _masterController.getFirstPerkFromPerkStyle(currentGamePerk);
    return _participantRepository.getPerkUrl(perkName);
  }
}
