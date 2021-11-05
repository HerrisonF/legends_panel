import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/model/general/champion.dart';
import 'package:legends_panel/app/model/general/champion_mastery.dart';
import 'package:legends_panel/app/model/general/match_detail.dart';
import 'package:legends_panel/app/model/general/user_tier.dart';
import 'package:legends_panel/app/data/repository/profile_repository/profile_repository.dart';

class ProfileController {
  final ProfileRepository _profileRepository = ProfileRepository();
  final TextEditingController userNameInputController = TextEditingController();
  final MasterController _masterController = Get.find<MasterController>();

  Rx<String> buttonMessage = "BUTTON_MESSAGE_SEARCH".tr.obs;
  int amountMatches = 5;
  Rx<int> oldIndex = 0.obs;
  Rx<int> newIndex = 0.obs;

  RxList<UserTier> userTierList = RxList<UserTier>();
  RxList<ChampionMastery> championMasteryList = RxList<ChampionMastery>();
  List<String> matchIdList = [];
  RxList<MatchDetail> matchList = RxList<MatchDetail>();

  Rx<bool> isUserLoading = false.obs;
  Rx<bool> isShowingMessage = false.obs;
  Rx<bool> lockNewLoadings = false.obs;
  Rx<bool> isLoadingNewMatches = false.obs;

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


  int getImageFromBestChampionPlayer() {
    int championId = 0;
    dynamic oldPoints = 0;
    championMasteryList.forEach((element) {
      if(element.championPoints > oldPoints){
        oldPoints = element.championPoints;
        championId = element.championId;
      }
    });
    return championId;
  }


  checkIsUserStored() async {
    if(_masterController.userProfileExist()){
      if(_masterController.userProfile.value.region != ""){
        final tempRegion = _masterController.userProfile.value.region;
        starUserLoading();
        await getUserTierInformation(tempRegion);
        await getMasteryChampions(tempRegion);
        await getMatchListIds(tempRegion);
        await getMatches(tempRegion);
        stopUserLoading();
      }
    }
  }

  getUserTierInformation(String region) async {
    userTierList.value = await _profileRepository
        .getUserTier(_masterController.userProfile.value.id, region);
  }

  getMasteryChampions(String region) async {
    championMasteryList.addAll(
      await _profileRepository
          .getChampionMastery(_masterController.userProfile.value.id, region),
    );
  }

  getMatchListIds(String region) async {
    this.newIndex.value += 5;
    List<String> tempMatchIdList = [];

    tempMatchIdList = await _profileRepository.getMatchListIds(
        _masterController.userProfile.value.puuid,
        this.newIndex.value,
        this.amountMatches, region);
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
      MatchDetail matchDetail = await _profileRepository.getMatchById(matchId, region);
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

  String getMasteryImage(int index) {
    return _profileRepository
        .getMasteryImage(championMasteryList[index].championLevel.toString());
  }

  getUserOnCloud(String region) async {
    starUserLoading();
    await _masterController.getUserProfileOnCloud(userNameInputController.text, region);
    if (_masterController.userProfileExist()) {
      await getUserTierInformation(region);
      await getMasteryChampions(region);
      await getMatchListIds(region);
      await getMatches(region);
      userNameInputController.clear();
      stopUserLoading();
    } else {
      _showUserNotFoundMessage();
    }
  }

  _showUserNotFoundMessage() {
    stopUserLoading();
    isShowingMessage(true);
    buttonMessage("BUTTON_MESSAGE_USER_NOT_FOUND".tr);
    Future.delayed(Duration(seconds: 3)).then((value) {
      buttonMessage("BUTTON_MESSAGE_SEARCH".tr);
      isShowingMessage(false);
    });
  }

  deletePersistedUser() {
    _masterController.deleteUserProfile();
  }

  String getUserProfileImage() {
    return _profileRepository.getProfileImage(
      _masterController.lolVersion.toString(),
      _masterController.userProfile.value.profileIconId.toString(),
    );
  }
}
