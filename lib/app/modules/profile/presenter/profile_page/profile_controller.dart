import 'package:flutter/material.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/summoner_identification/fetch_puuid_and_summonerID_from_riot_usecase.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/summoner_identification/fetch_summoner_profile_by_puuid_usecase.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/user_tier/fetch_user_tier_by_summoner_id.dart';
import 'package:legends_panel/app/modules/profile/domain/usecases/fetch_user_champion_masteries_usecase.dart';

class ProfileController {
  ValueNotifier<bool> isLoadingProfile = ValueNotifier(false);
  ValueNotifier<bool> isProfileFound = ValueNotifier(false);
  ValueNotifier<bool> isShowingMessage = ValueNotifier(false);
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

  ProfileController({
    required this.fetchPUUIDAndSummonerIDFromRiotUsecase,
    required this.fetchSummonerProfileByPUUIDUsecase,
    required this.fetchUserTierBySummonerIdUsecase,
    required this.fetchUserChampionMasteriesUsecase,
    required this.goToProfileResultCallback,
  });

  _starLoadingProfile() {
    isLoadingProfile.value = true;
  }

  _stopLoadingProfile() {
    isLoadingProfile.value = false;
  }

  _showUserNotFoundMessage() {
    _starLoadingProfile();
    isShowingMessage.value = true;
    Future.delayed(Duration(seconds: 3)).then((value) {
      _stopLoadingProfile();
      isShowingMessage.value = false;
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
            /// Antes de ir para os results, tenho que chamar algum outro método
            /// que devolva o summonerID para conseguir pegar os LeagueEntries.
            /// A chamada de champion Mastery retorna o summonerID. Esse atributo
            /// vai ser necessário em todas as requests subsequentes.
            final result = await fetchUserChampionMasteriesUsecase(
              region: selectedRegion.value,
              puuid: summonerIdentification.puuid,
            );

            result.fold(
              (l) => _showUserNotFoundMessage(),
              (r) {
                fetchUserTierBySummonerIdUsecase(
                  summonerId: r.first.summonerId,
                  region: selectedRegion.value,
                ).then(
                  (result) {
                    result.fold(
                      (l) => _showUserNotFoundMessage(),
                      (leagueEntries) {
                        print(leagueEntries);
                        // profile.setLeagueEntriesModel(leagueEntries);
                        // goToProfileResultCallback(profile);
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
//
//   bool isUserGreaterThanPlatinum() {
//     String elo = userTierRankedSolo.value.tier.toLowerCase();
//     return elo != 'iron' &&
//         elo != 'bronze' &&
//         elo != 'gold' &&
//         elo != 'silver' &&
//         elo != 'platinum';
//   }
//
//   getMasteryChampions(String keyRegion) async {
//     championMasteryList.value.addAll(
//       await _profileRepository.getChampionMastery(
//           _masterController.userForProfile.id, keyRegion),
//     );
//     championMasteryList.value
//         .sort((b, a) => a.championPoints.compareTo(b.championPoints));
//   }
//
//   getMatchListIds(String keyRegion) async {
//     this.newIndex.value += AMOUNT_MATCHES_TO_FIND;
//     List<String> tempMatchIdList = [];
//
//     tempMatchIdList = await _profileRepository.getMatchListIds(
//       puuid: _masterController.userForProfile.puuid,
//       start: this.oldIndex.value,
//       count: AMOUNT_MATCHES_TO_FIND,
//       keyRegion: keyRegion,
//     );
//     if (tempMatchIdList.isNotEmpty) {
//       oldIndex.value = oldIndex.value + AMOUNT_MATCHES_TO_FIND;
//       matchIdList.addAll(tempMatchIdList);
//     } else {
//       newIndex.value = oldIndex.value;
//       lockNewLoadings.value = true;
//     }
//   }
//
//   getMatches(String keyRegion) async {
//     for (int i = matchList.value.length; i < matchIdList.length; i++) {
//       MatchDetail matchDetail =
//           await _profileRepository.getMatchById(matchIdList[i], keyRegion);
//       matchList.value.add(matchDetail);
//     }
//   }
//
//   loadMoreMatches(String region) async {
//     if (!isLoadingNewMatches.value) {
//       startLoadingNewMatches();
//       await getMatchListIds(
//           _masterController.storedRegion.getKeyFromRegion(region)!);
//       await getMatches(
//           _masterController.storedRegion.getKeyFromRegion(region)!);
//       stopLoadingNewMatches();
//     }
//   }
//
//   String getMasteryImage(int index) {
//     return _profileRepository.getMasteryImage(
//         championMasteryList.value[index].championLevel.toString());
//   }
//
//   getUser(String region) async {
//     starUserLoading();
//     await _masterController.getUserProfileOnCloud(userNameInputController.text,
//         _masterController.storedRegion.getKeyFromRegion(region)!);
//     _masterController.saveUserProfile(region);
//     if (_masterController.userProfileExist()) {
//       await getUserTierInformation(
//           _masterController.storedRegion.getKeyFromRegion(region)!);
//       await getMasteryChampions(
//           _masterController.storedRegion.getKeyFromRegion(region)!);
//       await getMatchListIds(
//           _masterController.storedRegion.getKeyFromRegion(region)!);
//       await getMatches(
//           _masterController.storedRegion.getKeyFromRegion(region)!);
//       setUserRegion(region);
//       changeCurrentProfilePageTo(FOUND_USER_COMPONENT);
//       userNameInputController.clear();
//       stopUserLoading();
//     } else {
//       _showUserNotFoundMessage();
//     }
//   }
//
//
//   String getUserProfileImage() {
//     return _profileRepository.getProfileImage(
//       _masterController.userForProfile.profileIconId.toString(),
//     );
//   }
}
