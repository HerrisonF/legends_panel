import 'package:flutter/material.dart';
import 'package:legends_panel/app/core/general_controller/general_controller.dart';
import 'package:legends_panel/app/modules/profile/domain/models/champion_mastery_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/champion_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/summoner_identification/fetch_puuid_and_summonerID_from_riot_usecase.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/summoner_identification/fetch_summoner_profile_by_puuid_usecase.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/user_tier/fetch_user_tier_by_summoner_id.dart';
import 'package:legends_panel/app/modules/profile/domain/usecases/fetch_user_champion_masteries_usecase.dart';

class ProfileController {
  ValueNotifier<bool> isLoadingProfile = ValueNotifier(false);
  ValueNotifier<bool> isProfileFound = ValueNotifier(false);
  ValueNotifier<bool> isShowingMessageUserNotExist = ValueNotifier(false);
  ValueNotifier<bool> lockNewLoadings = ValueNotifier(false);
  ValueNotifier<bool> isLoadingNewMatches = ValueNotifier(false);

  ValueNotifier<String> selectedRegion = ValueNotifier('EUN1');

  Function goToProfileResultCallback;

  late final FetchPUUIDAndSummonerIDFromRiotUsecase
      fetchPUUIDAndSummonerIDFromRiotUsecase;
  late final FetchSummonerProfileByPUUIDUsecase
      fetchSummonerProfileByPUUIDUsecase;
  late final FetchUserTierBySummonerIdUsecase fetchUserTierBySummonerIdUsecase;
  late final FetchUserChampionMasteriesUsecase
      fetchUserChampionMasteriesUsecase;
  late final GeneralController generalController;

  ProfileController({
    required this.fetchPUUIDAndSummonerIDFromRiotUsecase,
    required this.fetchSummonerProfileByPUUIDUsecase,
    required this.fetchUserTierBySummonerIdUsecase,
    required this.fetchUserChampionMasteriesUsecase,
    required this.generalController,
    required this.goToProfileResultCallback,
  });

  _starLoadingProfile() {
    isLoadingProfile.value = true;
  }

  _stopLoadingProfile() {
    isLoadingProfile.value = false;
  }

  _showUserNotFoundMessage() {
    _stopLoadingProfile();
    isShowingMessageUserNotExist.value = true;
    Future.delayed(Duration(seconds: 3)).then((value) {
      isShowingMessageUserNotExist.value = false;
      isLoadingProfile.notifyListeners();
    });
  }

  searchProfile({
    required String summonerName,
    required String tag,
  }) async {
    _starLoadingProfile();
    final fetchPUUID = await fetchPUUIDAndSummonerIDFromRiotUsecase(
      summonerName: summonerName,
      tagLine: tag,
    );
    fetchPUUID.fold(
      (_) => _showUserNotFoundMessage(),
      (summonerIdentification) async {
        /// Depois de ter a identificação, posso procurar pelo
        /// profile do usuário.
        final result = await fetchSummonerProfileByPUUIDUsecase(
          puuid: summonerIdentification.puuid,
          region: selectedRegion.value,
        );
        result.fold(
          (_) => _showUserNotFoundMessage(),
          (profile) async {
            final result = await fetchUserChampionMasteriesUsecase(
              region: selectedRegion.value,
              puuid: summonerIdentification.puuid,
            );

            result.fold(
              (l) => _showUserNotFoundMessage(),
              (championMasteries) {
                fetchUserTierBySummonerIdUsecase(
                  summonerId: profile.id,
                  region: selectedRegion.value,
                ).then(
                  (result) {
                    result.fold(
                      (l) => _showUserNotFoundMessage(),
                      (leagueEntries) {
                        profile.setLeagueEntriesModel(leagueEntries);
                        profile
                            .setSummonerIdentification(summonerIdentification);
                        profile.setChampionMasteriesModel(championMasteries);
                        if (profile.masteries != null) {
                          for (ChampionMasteryModel championMastery
                              in profile.masteries!) {
                            ChampionModel? champion = generalController
                                .lolConstantsModel
                                .getChampionById(
                              championMastery.championId,
                            );
                            if (champion != null) {
                              championMastery.setChampion(champion);
                            }
                          }
                        }
                        profile.selectedRegion = selectedRegion.value;
                        goToProfileResultCallback(profile);
                        _stopLoadingProfile();
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
