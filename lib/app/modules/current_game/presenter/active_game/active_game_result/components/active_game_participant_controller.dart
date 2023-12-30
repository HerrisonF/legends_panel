import 'package:legends_panel/app/core/constants/string_constants.dart';
import 'package:legends_panel/app/core/general_controller/general_controller.dart';
import 'package:legends_panel/app/modules/current_game/data/repositories/active_game_result_repository/active_game_result_repository.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_participant_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/user_tier_entries/league_entry_model.dart';

class ActiveGameParticipantController {
  late ActiveGameParticipantModel activeGameParticipantModel;
  late GeneralController generalController;
  late ActiveGameResultRepository activeGameResultRepository;
  List<LeagueEntryModel> tempList = [];

  ActiveGameParticipantController({
    required this.activeGameParticipantModel,
    required this.generalController,
    required this.activeGameResultRepository,
  }) {
    tempList.addAll(activeGameParticipantModel.leagueEntryModel!
        .where((element) => element.queueType == RankedConstants.rankedSolo)
        .toList());
  }

  /// Guarda em cache para não correr a lista o tempo inteiro.

  String getUserWinRate() {
    return ((tempList.first.wins /
                (tempList.first.wins + tempList.first.losses)) *
            100)
        .toStringAsFixed(0);
  }

  String getPlaySum(){
    return (tempList.first.wins + tempList.first.losses).toString();
  }

  String getRankedSoloTierNameAndRank() {
    List<LeagueEntryModel> tempListLocal = activeGameParticipantModel
        .leagueEntryModel!
        .where((element) => element.queueType == RankedConstants.rankedSolo)
        .toList();

    if (tempListLocal.isNotEmpty) {
      tempList.add(tempListLocal.first);
      return tempList.first.tier + " " + tempList.first.rank;
    }
    return "UNRANKED";
  }

  String getRankedSoloLeaguePoints() {
    return "( ${tempList.first.leaguePoints.toString()} LP )";
  }

  String getTierMiniEmblem() {
    return activeGameResultRepository.getTierMiniEmblemUrl(
        tier: tempList.first.tier);
  }

  String getUnrankedEmblemUrl() {
    return activeGameResultRepository.getUnrankedTierMiniEmblemUrl();
  }
}
