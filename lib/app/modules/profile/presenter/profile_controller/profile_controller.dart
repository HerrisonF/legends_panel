import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/core/constants/string_constants.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/layers/presentation/controllers/lol_version_controller.dart';
import 'package:legends_panel/app/model/general/champion_mastery.dart';
import 'package:legends_panel/app/model/general/match_detail.dart';
import 'package:legends_panel/app/model/general/user_tier.dart';
import 'package:legends_panel/app/data/repository/profile_repository/profile_repository.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/master_page/master_controller/master_controller.dart';
import 'package:legends_panel/app/modules/profile/presenter/profile_page/found_user_profile.dart';
import 'package:legends_panel/app/modules/profile/presenter/profile_page/search_user_profile_component.dart';


class ProfileController {
  final ProfileRepository _profileRepository = ProfileRepository(
    logger: GetIt.I<Logger>(),
    httpServices: GetIt.I<HttpServices>()
  );
  final TextEditingController userNameInputController = TextEditingController();
  final MasterController _masterController = GetIt.I<MasterController>();
  final LolVersionController _lolVersionController =
      GetIt.I.get<LolVersionController>();

  ValueNotifier<int> oldIndex = ValueNotifier(0);
  ValueNotifier<int> newIndex = ValueNotifier(0);

  ValueNotifier<int> currentProfilePage = ValueNotifier(0);

  ValueNotifier<List<UserTier>> userTierList = ValueNotifier([]);
  ValueNotifier<UserTier> userTierRankedSolo = ValueNotifier(UserTier());
  ValueNotifier<UserTier> userTierRankedFlex = ValueNotifier(UserTier());
  ValueNotifier<List<ChampionMastery>> championMasteryList = ValueNotifier([]);
  List<String> matchIdList = [];
  ValueNotifier<List<MatchDetail>> matchList = ValueNotifier([]);

  ValueNotifier<bool> isUserLoading = ValueNotifier(false);
  ValueNotifier<bool> isShowingMessage = ValueNotifier(false);
  ValueNotifier<bool> isUserFound = ValueNotifier(false);
  ValueNotifier<bool> isShowingMessageUserIsNotPlaying = ValueNotifier(false);
  ValueNotifier<bool> lockNewLoadings = ValueNotifier(false);
  ValueNotifier<bool> isLoadingNewMatches = ValueNotifier(false);

  List<Widget> pages = [];

  static const SEARCH_USER_PROFILE_COMPONENT = 0;
  static const FOUND_USER_COMPONENT = 1;
  static const AMOUNT_MATCHES_TO_FIND = 10;

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
    isUserLoading.value = true;
  }

  stopUserLoading() {
    isUserLoading.value = false;
  }

  startLoadingNewMatches() {
    isLoadingNewMatches.value = true;
  }

  stopLoadingNewMatches() {
    isLoadingNewMatches.value = false;
  }

  startProfileController() async {
    await checkIsUserStored();
  }

  checkIsUserStored() async {
    if (_masterController.userProfileExist()) {
      if (_masterController.userForProfile.region.isNotEmpty) {
        isUserFound.value = true;
        final region = _masterController.userForProfile.region;
        starUserLoading();
        await getUserTierInformation(
            _masterController.storedRegion.getKeyFromRegion(region)!);
        await getMasteryChampions(
            _masterController.storedRegion.getKeyFromRegion(region)!);
        await getMatchListIds(
            _masterController.storedRegion.getKeyFromRegion(region)!);
        await getMatches(
            _masterController.storedRegion.getKeyFromRegion(region)!);
        changeCurrentProfilePageTo(FOUND_USER_COMPONENT);
        stopUserLoading();
      }
    }
  }

  getUserTierInformation(String keyRegion) async {
    userTierList.value = await _profileRepository.getUserTier(
        _masterController.userForProfile.id, keyRegion);
    for (UserTier userTier in userTierList.value) {
      if (userTier.queueType == StringConstants.rankedSolo) {
        userTierRankedSolo.value = userTier;
        userTierRankedSolo.notifyListeners();
      } else if (userTier.queueType == StringConstants.rankedFlex) {
        userTierRankedFlex.value = userTier;
        userTierRankedFlex.notifyListeners();
      }
    }
  }

  bool isUserGreaterThanPlatinum() {
    String elo = userTierRankedSolo.value.tier.toLowerCase();
    return elo != 'iron' &&
        elo != 'bronze' &&
        elo != 'gold' &&
        elo != 'silver' &&
        elo != 'platinum';
  }

  getMasteryChampions(String keyRegion) async {
    championMasteryList.value.addAll(
      await _profileRepository.getChampionMastery(
          _masterController.userForProfile.id, keyRegion),
    );
    championMasteryList.value
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
    for (int i = matchList.value.length; i < matchIdList.length; i++) {
      MatchDetail matchDetail =
          await _profileRepository.getMatchById(matchIdList[i], keyRegion);
      matchList.value.add(matchDetail);
    }
  }

  loadMoreMatches(String region) async {
    if (!isLoadingNewMatches.value) {
      startLoadingNewMatches();
      await getMatchListIds(
          _masterController.storedRegion.getKeyFromRegion(region)!);
      await getMatches(
          _masterController.storedRegion.getKeyFromRegion(region)!);
      stopLoadingNewMatches();
    }
  }

  String getChampionImage(int championId) {
    String returnedChampion =
        _masterController.getChampionById(championId.toString()).detail.id;
    return _profileRepository.getChampionImage(returnedChampion);
  }

  String getCircularChampionImage(int championId) {
    String returnedChampion = _masterController
        .getChampionById(championId.toString())
        .detail
        .id
        .toString();
    return _profileRepository.getCircularChampionImage(returnedChampion,
        _lolVersionController.cachedLolVersion.getLatestVersion());
  }

  String getMasteryImage(int index) {
    return _profileRepository
        .getMasteryImage(championMasteryList.value[index].championLevel.toString());
  }

  getUser(String region) async {
    starUserLoading();
    await _masterController.getUserProfileOnCloud(userNameInputController.text,
        _masterController.storedRegion.getKeyFromRegion(region)!);
    _masterController.saveUserProfile(region);
    if (_masterController.userProfileExist()) {
      await getUserTierInformation(
          _masterController.storedRegion.getKeyFromRegion(region)!);
      await getMasteryChampions(
          _masterController.storedRegion.getKeyFromRegion(region)!);
      await getMatchListIds(
          _masterController.storedRegion.getKeyFromRegion(region)!);
      await getMatches(
          _masterController.storedRegion.getKeyFromRegion(region)!);
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
    isShowingMessage.value = true;
    Future.delayed(Duration(seconds: 3)).then((value) {
      isShowingMessage.value = false;
    });
  }

  deletePersistedUser() {
    _masterController.deleteUserProfile();
    this.isShowingMessage.value = false;
    oldIndex.value = 0;
    newIndex.value = 0;
    userTierRankedSolo.value = UserTier();
    this.userTierList.value.clear();
    this.championMasteryList.value.clear();
    this.matchIdList.clear();
    this.matchList.value.clear();
  }

  String getUserProfileImage() {
    return _profileRepository.getProfileImage(
      _lolVersionController.cachedLolVersion.getLatestVersion(),
      _masterController.userForProfile.profileIconId.toString(),
    );
  }
}
