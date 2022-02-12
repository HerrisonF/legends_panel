import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/constants/string_constants.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
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

  Rx<int> oldIndex = 0.obs;
  Rx<int> newIndex = 0.obs;

  Rx<int> currentProfilePage = 0.obs;

  RxList<UserTier> userTierList = RxList<UserTier>();
  Rx<UserTier> userTierRankedSolo = UserTier().obs;
  Rx<UserTier> userTierRankedFlex = UserTier().obs;
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

  static const SEARCH_USER_PROFILE_COMPONENT = 0;
  static const FOUND_USER_COMPONENT = 1;
  static const AMOUNT_MATCHES_TO_FIND = 6;

  buildPages() {
    pages = [
      SearchUserProfileComponent(),
      FoundUserComponent(),
    ];
  }

  String getLastStoredRegionForProfile() {
    if (_masterController.storedRegion.lastStoredProfileRegion.isEmpty) {
      return 'NA';
    }
    return _masterController.storedRegion.lastStoredProfileRegion;
  }

  saveActualRegion(String region) {
    _masterController.storedRegion.lastStoredProfileRegion = region;
    _masterController.saveActualRegion();
  }

  changeCurrentProfilePageTo(int page) {
    currentProfilePage.value = page;
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
      if (_masterController.userForProfile.region.isNotEmpty) {
        isUserFound(true);
        final region = _masterController.userForProfile.region;
        starUserLoading();
        await getUserTierInformation(_masterController.storedRegion.getKeyFromRegion(region)!);
        await getMasteryChampions(_masterController.storedRegion.getKeyFromRegion(region)!);
        await getMatchListIds(_masterController.storedRegion.getKeyFromRegion(region)!);
        await getMatches(_masterController.storedRegion.getKeyFromRegion(region)!);
        changeCurrentProfilePageTo(FOUND_USER_COMPONENT);
        stopUserLoading();
      }
    }
  }

  getUserTierInformation(String keyRegion) async {
    userTierList.value = await _profileRepository.getUserTier(
        _masterController.userForProfile.id, keyRegion);
    for (UserTier userTier in userTierList) {
      if (userTier.queueType == StringConstants.rankedSolo) {
        userTierRankedSolo.value = userTier;
        userTierRankedSolo.refresh();
      } else if (userTier.queueType == StringConstants.rankedFlex) {
        userTierRankedFlex.value = userTier;
        userTierRankedFlex.refresh();
      }
    }
  }

  bool isUserGreaterThanGold(){
    String elo = userTierRankedSolo.value.tier.toLowerCase();
    return elo != 'iron' &&  elo != 'bronze' && elo != 'gold' && elo != 'silver';
  }

  getMasteryChampions(String keyRegion) async {
    championMasteryList.addAll(
      await _profileRepository.getChampionMastery(
          _masterController.userForProfile.id, keyRegion),
    );
    championMasteryList
        .sort((b, a) => a.championPoints.compareTo(b.championPoints));
  }

  getMatchListIds(String keyRegion) async {
    this.newIndex.value += AMOUNT_MATCHES_TO_FIND;
    List<String> tempMatchIdList = [];

    tempMatchIdList = await _profileRepository.getMatchListIds(
      puuid: _masterController.userForProfile.puuid,
      start: this.oldIndex.value,
      count: AMOUNT_MATCHES_TO_FIND,
      keyRegion: keyRegion,
    );
    if (tempMatchIdList.isNotEmpty) {
      oldIndex.value = oldIndex.value + AMOUNT_MATCHES_TO_FIND;
      matchIdList.addAll(tempMatchIdList);
    } else {
      newIndex.value = oldIndex.value;
      lockNewLoadings.value = true;
    }
  }

  getMatches(String keyRegion) async {
    for (int i = matchList.length; i < matchIdList.length; i++) {
      MatchDetail matchDetail =
          await _profileRepository.getMatchById(matchIdList[i], keyRegion);
      matchList.add(matchDetail);
    }
  }

  loadMoreMatches(String region) async {
    if (!isLoadingNewMatches.value) {
      startLoadingNewMatches();
      await getMatchListIds(_masterController.storedRegion.getKeyFromRegion(region)!);
      await getMatches(_masterController.storedRegion.getKeyFromRegion(region)!);
      stopLoadingNewMatches();
    }
  }

  String getChampionImage(int championId) {
    String returnedChampion =
        _masterController.getChampionById(championId.toString()).detail.id;
    return _profileRepository.getChampionImage(returnedChampion);
  }

  String getCircularChampionImage(int championId) {
    String returnedChampion =
        _masterController.getChampionById(championId.toString()).detail.id.toString();
    return _profileRepository.getCircularChampionImage(returnedChampion, _masterController.lolVersion.actualVersion);
  }

  String getMasteryImage(int index) {
    return _profileRepository
        .getMasteryImage(championMasteryList[index].championLevel.toString());
  }

  getUser(String region) async {
    starUserLoading();
    await _masterController.getUserProfileOnCloud(userNameInputController.text,
        _masterController.storedRegion.getKeyFromRegion(region)!);
    _masterController.saveUserProfile(region);
    if (_masterController.userProfileExist()) {
      await getUserTierInformation(_masterController.storedRegion.getKeyFromRegion(region)!);
      await getMasteryChampions(_masterController.storedRegion.getKeyFromRegion(region)!);
      await getMatchListIds(_masterController.storedRegion.getKeyFromRegion(region)!);
      await getMatches(_masterController.storedRegion.getKeyFromRegion(region)!);
      setUserRegion(region);
      changeCurrentProfilePageTo(FOUND_USER_COMPONENT);
      userNameInputController.clear();
      stopUserLoading();
    } else {
      _showUserNotFoundMessage();
    }
  }

  setUserRegion(String region) {
    _masterController.userForProfile.region = region;
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
    this.isShowingMessage(false);
    oldIndex = 0.obs;
    newIndex = 0.obs;

    this.userTierList.clear();
    this.championMasteryList.clear();
    this.matchIdList.clear();
    this.matchList.clear();
  }

  String getUserProfileImage() {
    return _profileRepository.getProfileImage(
      _masterController.lolVersion.actualVersion,
      _masterController.userForProfile.profileIconId.toString(),
    );
  }
}
