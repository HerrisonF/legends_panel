import 'package:flutter/material.dart';
import 'package:legends_panel/app/modules/profile/data/repositories/profile_repository.dart';

class ProfileController {
  ValueNotifier<bool> isLoadingProfile = ValueNotifier(false);
  ValueNotifier<bool> isProfileFound = ValueNotifier(false);
  ValueNotifier<bool> isShowingMessage = ValueNotifier(false);
  ValueNotifier<bool> isShowingMessageUserIsNotPlaying = ValueNotifier(false);
  ValueNotifier<bool> lockNewLoadings = ValueNotifier(false);
  ValueNotifier<bool> isLoadingNewMatches = ValueNotifier(false);

  late ProfileRepository profileRepository;

  ProfileController({
    required this.profileRepository,
  });

  starLoadingProfile() {
    isLoadingProfile.value = true;
  }

  stopLoadingProfile() {
    isLoadingProfile.value = false;
  }

  _showUserNotFoundMessage() {
    stopLoadingProfile();
    isShowingMessage.value = true;
    Future.delayed(Duration(seconds: 3)).then((value) {
      isShowingMessage.value = false;
    });
  }

//   startProfileController() async {
//     await checkIsUserStored();
//   }
//   checkIsUserStored() async {
//     if (_masterController.userProfileExist()) {
//       if (_masterController.userForProfile.region.isNotEmpty) {
//         isUserFound.value = true;
//         final region = _masterController.userForProfile.region;
//         starUserLoading();
//         await getUserTierInformation(
//             _masterController.storedRegion.getKeyFromRegion(region)!);
//         await getMasteryChampions(
//             _masterController.storedRegion.getKeyFromRegion(region)!);
//         await getMatchListIds(
//             _masterController.storedRegion.getKeyFromRegion(region)!);
//         await getMatches(
//             _masterController.storedRegion.getKeyFromRegion(region)!);
//         stopUserLoading();
//       }
//     }
//   }
//
//   getUserTierInformation(String keyRegion) async {
//     userTierList.value = await _profileRepository.getUserTier(
//         _masterController.userForProfile.id, keyRegion);
//     for (UserTier userTier in userTierList.value) {
//       if (userTier.queueType == StringConstants.rankedSolo) {
//         userTierRankedSolo.value = userTier;
//         userTierRankedSolo.notifyListeners();
//       } else if (userTier.queueType == StringConstants.rankedFlex) {
//         userTierRankedFlex.value = userTier;
//         userTierRankedFlex.notifyListeners();
//       }
//     }
//   }
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
//   String getChampionImage(int championId) {
//     String returnedChampion =
//         _masterController.getChampionById(championId.toString()).detail.id;
//     return _profileRepository.getChampionImage(returnedChampion);
//   }
//
//   String getCircularChampionImage(int championId) {
//     String returnedChampion = _masterController
//         .getChampionById(championId.toString())
//         .detail
//         .id
//         .toString();
//     return _profileRepository.getCircularChampionImage(returnedChampion);
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
