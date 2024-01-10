import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:legends_panel/app/core/constants/string_constants.dart';
import 'package:legends_panel/app/core/general_controller/general_controller.dart';
import 'package:legends_panel/app/modules/profile/domain/models/match_detail_model.dart';
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
  int ultimoValorPesquisado = 0;
  int quantidadePorPesquisa = 10;

  List<LeagueEntryModel> tempList = [];
  List<String> matchesIds = [];
  ValueNotifier<List<MatchDetailModel>> matches = ValueNotifier([]);
  ValueNotifier<bool> isLoadingNewMatches = ValueNotifier(false);

  ProfileResultController({
    required this.summonerProfileModel,
    required this.profileRepository,
    required this.generalController,
    required this.fetchUserMatchesIdsUsecase,
    required this.fetchUserMatchesUsecase,
  }) {
    getRankedSoloTier();
    loadMoreMatches();
  }

  /// O inicio é o último ponto carregado da lista.
  void loadMoreMatches() {
    if(!isLoadingNewMatches.value) {
      startLoadingMatches();
      fetchUserMatchesIdsUsecase(
        puuid: summonerProfileModel!.summonerIdentificationModel!.puuid,
        region: summonerProfileModel!.selectedRegion!,
        count: quantidadePorPesquisa,
        start: ultimoValorPesquisado,
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
                  (l) {
                    stopLoadingMatches();
                  },
                  (r) {
                matches.value.add(r);
                ultimoValorPesquisado += quantidadePorPesquisa;
                stopLoadingMatches();
                matches.notifyListeners();
              },
            );
          });
        });
      });
    }
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
    if (tempList.isNotEmpty) {
      return profileRepository.getRankedTierBadge(tier: tempList.first.tier);
    }
    return "";
  }

  startLoadingMatches(){
    isLoadingNewMatches.value = true;
  }

  stopLoadingMatches(){
    isLoadingNewMatches.value = false;
  }
}
