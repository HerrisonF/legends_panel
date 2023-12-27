import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/core/constants/string_constants.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/user_tier.dart';
import 'package:legends_panel/app/modules/current_game/data/repositories/participant_repository.dart';

class CurrentGameParticipantController {
  final ParticipantRepository _participantRepository = ParticipantRepository(
    logger: GetIt.I.get<Logger>(),
    httpServices: GetIt.I.get<HttpServices>(),
  );

  ValueNotifier<List<UserTier>> userTierList = ValueNotifier([]);
  ValueNotifier<UserTier> soloUserTier = ValueNotifier(UserTier());
  // ValueNotifier<CurrentGameSpectator> currentGameSpectator =
  //     ValueNotifier(CurrentGameSpectator());
  // CurrentGameParticipant currentGameParticipant = CurrentGameParticipant();
  //
  // getUserTier(CurrentGameParticipant participant, String region) async {
  //   this.currentGameParticipant = participant;
  //   userTierList.value = await _participantRepository.getUserTier(
  //       this.currentGameParticipant.summonerId, region);
  //   _getSoloRankedOnly(userTierList.value);
  // }

  _getSoloRankedOnly(List<UserTier> userTierList) {
    try {
      soloUserTier.value = userTierList
          .where((tier) => tier.queueType == StringConstants.rankedSolo)
          .first;
      soloUserTier.value.winRate = getUserWinRate();
    } catch (e) {
      soloUserTier.value.winRate = 0.toString();
    }
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
    // return _participantRepository.getChampionBadgeUrl(
    //     _masterController.getChampionById(championId).detail.id.toString());
    return "";
  }

  String getSpellUrl(String spellId) {
    // Spell spell = _masterController.getSpellById(spellId);
    // if (spell.name.isNotEmpty) {
    //   return _participantRepository.getSpellBadgeUrl(spell.id);
    // } else {
    //   return "";
    // }
    return "";
  }

  String getItemUrl(String itemId) {
    return _participantRepository.getItemUrl(itemId);
  }

  String getPositionUrl(String position) {
    return _participantRepository.getPositionUrl(
      position,
    );
  }

  getSpectator(String summonerId, String region) async {
    // currentGameSpectator.value =
    //     await _participantRepository.getSpectator(summonerId, region);
  }

  String getPerkStyleUrl() {
    // String perkName =
    //     _masterController.getPerkSubStyleIconName(currentGamePerk);

    return _participantRepository.getPerkUrl("");
  }

  String getFirsPerkUrl() {
    // String perkName =
    //     _masterController.getFirstPerkFromPerkStyle(currentGamePerk);
    return _participantRepository.getPerkUrl("");
  }
}