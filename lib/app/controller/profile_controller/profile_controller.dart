import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/data/model/general/champion.dart';
import 'package:legends_panel/app/data/model/general/champion_mastery.dart';
import 'package:legends_panel/app/data/model/general/match_list.dart';
import 'package:legends_panel/app/data/model/general/user_tier.dart';
import 'package:legends_panel/app/data/repository/profile_repository/profile_repository.dart';

class ProfileController {
  final ProfileRepository _profileRepository = ProfileRepository();
  final TextEditingController userNameInputController = TextEditingController();
  final MasterController _masterController = Get.find<MasterController>();

  Rx<String> buttonMessage = "BUTTON_MESSAGE_SEARCH".tr.obs;

  RxList<UserTier> userTierList = RxList<UserTier>();
  RxList<ChampionMastery> championMasteryList = RxList<ChampionMastery>();
  Rx<MatchList> matchList = MatchList().obs;

  Rx<bool> isLoading = false.obs;
  Rx<bool> isShowingMessage = false.obs;

  startLoading() {
    isLoading(true);
  }

  stopLoading() {
    isLoading(false);
  }

  startProfileController() {
    checkUserExist();
  }

  checkUserExist() async {
    if (_masterController.userProfileExist()) {
      startLoading();
      await getUserTierInformation();
      await getMasteryChampions();
      await getMatchList();
      stopLoading();
    }
  }

  getUserTierInformation() async {
    userTierList.value =
        await _profileRepository.getUserTier(_masterController.userProfile.value.id);
  }

  getMasteryChampions() async {
    championMasteryList.addAll(
      await _profileRepository
          .getChampionMastery(_masterController.userProfile.value.id),
    );
  }

  getMatchList() async {
    matchList.value = await _profileRepository
        .getMatchList(_masterController.userProfile.value.accountId);
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

  String getLoLVersion() {
    return _masterController.lolVersion;
  }

  getUserOnCloud() async {
    startLoading();
    await _masterController.getUserProfileOnCloud(userNameInputController.text);
    if (_masterController.userProfileExist()) {
      await getUserTierInformation();
      await getMasteryChampions();
      await getMatchList();
      userNameInputController.clear();
      stopLoading();
    } else {
      _showUserNotFoundMessage();
    }
  }

  _showUserNotFoundMessage() {
    stopLoading();
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
