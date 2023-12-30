import 'package:legends_panel/app/core/constants/string_constants.dart';
import 'package:legends_panel/app/core/general_controller/general_controller.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_participant_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/user_tier_entries/league_entry_model.dart';

class ActiveGameParticipantController {
  late ActiveGameParticipantModel activeGameParticipantModel;
  late GeneralController generalController;

  ActiveGameParticipantController({
    required this.activeGameParticipantModel,
    required this.generalController,
  });

  /// Guarda em cache para não correr a lista o tempo inteiro.
  List<LeagueEntryModel> tempList = [];

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

  String getRankedSoloTierNameAndRank() {
    List<LeagueEntryModel> tempListLocal = activeGameParticipantModel
        .leagueEntryModel!
        .where((element) => element.queueType == RankedConstants.rankedSolo)
        .toList();

    if (tempListLocal.isNotEmpty) {
      tempList.add(tempListLocal.first);
      return tempList.first.tier + tempList.first.rank;
    }
    return "UNRANKED";
  }

  String getRankedSoloLeaguePoints() {
   return tempList.first.leaguePoints.toString();
  }
}
