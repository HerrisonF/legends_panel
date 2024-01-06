import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:legends_panel/app/core/constants/string_constants.dart';
import 'package:legends_panel/app/core/general_controller/general_controller.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/match_detail.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/summoner_identification/summoner_profile_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/user_tier_entries/league_entry_model.dart';
import 'package:legends_panel/app/modules/profile/data/repositories/profile_repository.dart';
import 'package:legends_panel/app/modules/profile/domain/usecases/fetch_user_matches_ids_usecase.dart';
import 'package:legends_panel/app/modules/profile/domain/usecases/fetch_user_matches_usecase.dart';

class ProfileResultController {
  late SummonerProfileModel? summonerProfileModel;
  late final ProfileRepository profileRepository;
  late final GeneralController generalController;
  late final FetchUserMatchesIdsUsecase fetchUserMatchesIdsUsecase;
  late final FetchUserMatchesUsecase fetchUserMatchesUsecase;

  List<LeagueEntryModel> tempList = [];
  List<String> matchesIds = [];
  ValueNotifier<List<MatchDetail>> matches = ValueNotifier([]);
  ValueNotifier<bool> isLoadingNewMatches = ValueNotifier(false);

  ProfileResultController({
    required this.summonerProfileModel,
    required this.profileRepository,
    required this.generalController,
    required this.fetchUserMatchesIdsUsecase,
    required this.fetchUserMatchesUsecase,
  }) {
    getRankedSoloTier();
    fetchUserMatchesIdsUsecase(
      puuid: summonerProfileModel!.summonerIdentificationModel!.puuid,
      region: summonerProfileModel!.selectedRegion!,
      count: 10,
      start: 0,
    ).then((value) {
      value.fold((l) => id, (r) {
        matchesIds.addAll(r);
      });
      matchesIds.forEach((e) {
        fetchUserMatchesUsecase(
          matchId: e,
          region: summonerProfileModel!.selectedRegion!,
        ).then((value) {
          value.fold(
            (l) => id,
            (r) => matches.value.add(r),
          );
        });
      });
    });
  }

  getRankedSoloTier() {
    List<LeagueEntryModel> tempListLocal = summonerProfileModel!.leagueEntries!
        .where((element) => element.queueType == RankedConstants.rankedSolo)
        .toList();

    if (tempListLocal.isNotEmpty) {
      tempList.add(tempListLocal.first);
      return tempList.first.tier;
    }
  }

  String getUserProfileImage() {
    return profileRepository.getProfileImage(
      profileIconId: summonerProfileModel!.profileIconId.toString(),
      version: generalController.lolConstantsModel.getLatestLolVersion(),
    );
  }

  String getRankedSoloTierName() {
    if (tempList.isNotEmpty) {
      return tempList.first.tier;
    }
    return "";
  }

  int getLosses() {
    if (tempList.isNotEmpty) {
      return tempList.first.losses;
    }
    return 0;
  }

  int getWins() {
    if (tempList.isNotEmpty) {
      return tempList.first.wins;
    }
    return 0;
  }

  int getLeaguePoints() {
    if (tempList.isNotEmpty) {
      return tempList.first.leaguePoints;
    }
    return 0;
  }

  String getRankedSoloTierBadge() {
    if(tempList.isNotEmpty) {
      return profileRepository.getRankedTierBadge(tier: tempList.first.tier);
    }
    return "";
  }

// getSpellImage(int spellId) {
//   // return _currentGameParticipantController.getSpellUrl(
//   //   _getParticipantSpellId(spellId),
//   // );
// }

// String getItemUrl(String itemId){
//   return _currentGameParticipantController.getItemUrl(itemId);
// }
//
// String getPositionUrl(String position){
//   return _currentGameParticipantController.getPositionUrl(position);
// }

// String _getParticipantSpellId(int id) {
//   if (id == 1) {
//     return currentParticipant.value.summoner1Id.toString();
//   } else {
//     return currentParticipant.value.summoner2Id.toString();
//   }
// }

// String getChampionBadgeUrl() {
//   return _currentGameParticipantController.getChampionBadgeUrl(
//       currentParticipant.value.championId.toString()
//   );
// }
}
