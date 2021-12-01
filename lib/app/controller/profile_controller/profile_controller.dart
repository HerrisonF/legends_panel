import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/model/general/champion.dart';
import 'package:legends_panel/app/model/general/champion_mastery.dart';
import 'package:legends_panel/app/model/general/match_detail.dart';
import 'package:legends_panel/app/model/general/user_tier.dart';
import 'package:legends_panel/app/data/repository/profile_repository/profile_repository.dart';
import 'package:legends_panel/app/ui/android/pages/profile_page/found_user_profile.dart';
import 'package:legends_panel/app/ui/android/pages/profile_page/search_user_profile_component.dart';

class ProfileController {
  final ProfileRepository _profileRepository = ProfileRepository();
  final TextEditingController userNameInputController = TextEditingController();
  final MasterController _masterController = Get.find<MasterController>();

  int amountMatches = 6;
  Rx<int> oldIndex = 0.obs;
  Rx<int> newIndex = 0.obs;

  Rx<int> currentProfilePage = 0.obs;

  RxList<UserTier> userTierList = RxList<UserTier>();
  RxList<ChampionMastery> championMasteryList = RxList<ChampionMastery>();
  List<String> matchIdList = [];
  RxList<MatchDetail> matchList = RxList<MatchDetail>();

  Rx<bool> isUserLoading = false.obs;
  Rx<bool> isShowingMessage = false.obs;
  Rx<bool> isUserFound = false.obs;
  Rx<bool> isShowingMessageUserIsNotPlaying = false.obs;
  Rx<bool> lockNewLoadings = false.obs;
  Rx<bool> isLoadingNewMatches = false.obs;

  List<Widget> pages = [];

  buildPages() {
    pages = [
      SearchUserProfileComponent(),
      FoundUserComponent(),
    ];
  }

  changeCurrentProfilePage(int index){
    currentProfilePage.value = index;
  }

  starUserLoading() {
    isUserLoading(true);
  }

  stopUserLoading() {
    isUserLoading(false);
  }

  startLoadingNewMatches() {
    isLoadingNewMatches(true);
  }

  stopLoadingNewMatches() {
    isLoadingNewMatches(false);
  }

  startProfileController() async {
    await checkIsUserStored();
  }

  checkIsUserStored() async {
    if (_masterController.userProfileExist()) {
      if (_masterController.userProfile.value.region != "") {
        isUserFound(true);
        final tempRegion = _masterController.userProfile.value.region;
        starUserLoading();
        await getUserTierInformation(tempRegion);
        await getMasteryChampions(tempRegion);
        await getMatchListIds(tempRegion);
        await getMatches(tempRegion);
        changeCurrentProfilePage(1);
        stopUserLoading();
      }
    }
  }

  getUserTierInformation(String region) async {
    userTierList.value = await _profileRepository.getUserTier(
        _masterController.userProfile.value.id, region);
  }

  getMasteryChampions(String region) async {
    championMasteryList.addAll(
      await _profileRepository.getChampionMastery(
          _masterController.userProfile.value.id, region),
    );
    championMasteryList
        .sort((b, a) => a.championPoints.compareTo(b.championPoints));
  }

  getMatchListIds(String region) async {
    this.newIndex.value += 6;
    List<String> tempMatchIdList = [];

    tempMatchIdList = await _profileRepository.getMatchListIds(
        _masterController.userProfile.value.puuid,
        this.newIndex.value,
        this.amountMatches,
        region);
    if (tempMatchIdList.length > 0) {
      oldIndex.value = newIndex.value;
      this.matchIdList.addAll(tempMatchIdList);
    } else {
      newIndex.value = oldIndex.value;
      lockNewLoadings.value = true;
    }
  }

  getMatches(String region) async {
    for (String matchId in matchIdList) {
      MatchDetail matchDetail =
          await _profileRepository.getMatchById(matchId, region);
      matchList.add(matchDetail);
    }
  }

  loadMoreMatches(String region) async {
    startLoadingNewMatches();
    await getMatchListIds(region);
    for (int i = matchList.length; i < matchIdList.length; i++) {
      MatchDetail matchDetail =
          await _profileRepository.getMatchById(matchIdList[i], region);
      matchList.add(matchDetail);
    }
    stopLoadingNewMatches();
  }

  String getChampionImage(int championId) {
    Champion champion =
        _masterController.getChampionById(championId.toString());
    return _profileRepository.getChampionImage(champion.detail.id);
  }

  String getCircularChampionImage(int championId) {
    Champion champion =
        _masterController.getChampionById(championId.toString());
    return _profileRepository.getCircularChampionImage(champion.detail.id);
  }

  String getMasteryImage(int index) {
    return _profileRepository
        .getMasteryImage(championMasteryList[index].championLevel.toString());
  }

  getUserOnCloud(String region) async {
    starUserLoading();
    await _masterController.getUserProfileOnCloud(
        userNameInputController.text, region);
    if (_masterController.userProfileExist()) {
      await getUserTierInformation(region);
      await getMasteryChampions(region);
      await getMatchListIds(region);
      await getMatches(region);
      setUserRegion(region);
      changeCurrentProfilePage(1);
      userNameInputController.clear();
      stopUserLoading();
    } else {
      _showUserNotFoundMessage();
    }
  }

  setUserRegion(String region){
    _masterController.userProfile.value.region = region;
  }

  _showUserNotFoundMessage() {
    stopUserLoading();
    isShowingMessage(true);
    Future.delayed(Duration(seconds: 3)).then((value) {
      isShowingMessage(false);
    });
  }

  deletePersistedUser() {
    _masterController.deleteUserProfile();
    isShowingMessage(false);
    amountMatches = 6;
    oldIndex = 0.obs;
    newIndex = 0.obs;

    userTierList = RxList<UserTier>();
    championMasteryList = RxList<ChampionMastery>();
    matchIdList = [];
    matchList = RxList<MatchDetail>();
  }

  String getUserProfileImage() {
    return _profileRepository.getProfileImage(
      _masterController.lolVersion.value.actualVersion,
      _masterController.userProfile.value.profileIconId.toString(),
    );
  }
}
