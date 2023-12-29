import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/core/constants/string_constants.dart';
import 'package:legends_panel/app/core/general_controller/general_controller.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/champion_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/lol_constants_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/user_tier.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_participant_model.dart';

class ActiveGameParticipantController {
  ValueNotifier<List<UserTier>> userTierList = ValueNotifier([]);
  ValueNotifier<UserTier> soloUserTier = ValueNotifier(UserTier());

  late ActiveGameParticipantModel activeGameParticipantModel;
  late GeneralController generalController;

  ActiveGameParticipantController({
    required this.activeGameParticipantModel,
    required this.generalController,
  });

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

  // _getSoloRankedOnly(List<UserTier> userTierList) {
  //   try {
  //     soloUserTier.value = userTierList
  //         .where((tier) => tier.queueType == StringConstants.rankedSolo)
  //         .first;
  //     soloUserTier.value.winRate = getUserWinRate();
  //   } catch (e) {
  //     soloUserTier.value.winRate = 0.toString();
  //   }
  // }
  //
  // String getUserTierImage(String tier) {
  //   return activeGameParticipantRepository.getUserTierImage(tier);
  // }

  // String getUserWinRate() {
  //   return ((soloUserTier.value.wins /
  //               (soloUserTier.value.wins + soloUserTier.value.losses)) *
  //           100)
  //       .toStringAsFixed(0);
  // }

  // String getItemUrl(String itemId) {
  //   return activeGameParticipantRepository.getItemUrl(itemId);
  // }
  //
  // String getPositionUrl(String position) {
  //   return activeGameParticipantRepository.getPositionUrl(
  //     position,
  //   );
  // }

  getSpectator(String summonerId, String region) async {
    // currentGameSpectator.value =
    //     await _participantRepository.getSpectator(summonerId, region);
  }
}
