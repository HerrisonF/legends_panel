import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_perk.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_summoner_spell.dart';
import 'package:legends_panel/app/model/general/champion.dart';
import 'package:legends_panel/app/model/general/champion_room.dart';
import 'package:legends_panel/app/model/general/runesRoom.dart';
import 'package:legends_panel/app/model/general/lol_version.dart';
import 'package:legends_panel/app/model/general/map_room.dart';
import 'package:legends_panel/app/model/general/spell_room.dart';
import 'package:legends_panel/app/model/general/stored_region.dart';
import 'package:legends_panel/app/model/general/user.dart';
import 'package:legends_panel/app/data/repository/general/master_repository.dart';
import 'package:legends_panel/app/routes/app_routes.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MasterController {
  final MasterRepository _masterRepository = MasterRepository();

  RxInt currentPageIndex = 0.obs;
  late PackageInfo packageInfo;

  User userForCurrentGame = User();
  User userForProfile = User();
  RxList<User> favoriteUsersForCurrentGame = RxList<User>();
  RxList<User> favoriteUsersForProfile = RxList<User>();
  StoredRegion storedRegion = StoredRegion();
  LolVersion lolVersion = LolVersion();
  ChampionRoom championRoom = ChampionRoom();
  SpellRoom spellRoom = SpellRoom();
  MapRoom mapRoom = MapRoom();
  RunesRoom runesRoom = RunesRoom();

  static const int NEXUS_ONE_SCREEN_WIDTH = 480;

  start() async {
    await getLastStoredRegions();
    await readPersistedUser();
    await getLolVersion();
    await getChampionRoom();
    await getSummonerSpellsRoom();
    await getMapRoom();
    await getRunesRoom();
    await getFavoriteUsersStoredForCurrentGame();
    await getFavoriteUsersStoredForProfile();
    packageInfo = await PackageInfo.fromPlatform();
    Get.offAllNamed(Routes.MASTER);
  }

  screenWidthSizeIsBiggerThanNexusOne() {
    return WidgetsBinding.instance!.window.physicalSize.width >
        NEXUS_ONE_SCREEN_WIDTH;
  }

  getLastStoredRegions() async {
    storedRegion = await _masterRepository.getLastStoredRegion();
  }

  saveActualRegion() async {
    await _masterRepository.saveActualRegion(storedRegion);
  }

  readPersistedUser() async {
    userForProfile = await _masterRepository.readPersistedUserProfile();
  }

  getLolVersion() async {
    lolVersion = await _masterRepository.getLOLVersionOnLocal();
    if (!isLolVersionStored() || lolVersion.needToLoadVersionFromWeb()) {
      await getLolVersionOnWeb();
    }
  }

  bool isLolVersionStored() {
    return lolVersion.actualVersion.isNotEmpty;
  }

  getLolVersionOnWeb() async {
    lolVersion.versions.addAll(await _masterRepository.getLOLVersionOnWeb());
    lolVersion.actualVersion = lolVersion.versions.first;
    _masterRepository.saveLolVersion(lolVersion.toJson());
  }

  getChampionRoom() async {
    championRoom = await _masterRepository.getChampionRoomOnLocal();
    if (!isChampionRoomStored() || championRoom.needToLoadVersionFromWeb()) {
      await getChampionRoomOnWeb();
    }
  }

  bool isChampionRoomStored() {
    return championRoom.lastDate.isNotEmpty;
  }

  addUserToFavoriteCurrentGameList(String userTier) {
    bool notFound = true;
    if (userTier.isNotEmpty) {
      userForCurrentGame.userTier = userTier;
    } else {
      userForCurrentGame.userTier = "";
    }
    if (favoriteUsersForCurrentGame.length <= 0) {
      favoriteUsersForCurrentGame.add(userForCurrentGame);
      saveFavoriteUsersForCurrentGame();
    } else {
      for (User favoriteUser in favoriteUsersForCurrentGame) {
        if (favoriteUser.name.toLowerCase() ==
            userForCurrentGame.name.toLowerCase()) {
          notFound = false;
          favoriteUsersForCurrentGame.remove(favoriteUser);
          favoriteUsersForCurrentGame.add(userForCurrentGame);
          saveFavoriteUsersForCurrentGame();
        }
      }
      if (notFound) {
        favoriteUsersForCurrentGame.add(userForCurrentGame);
        saveFavoriteUsersForCurrentGame();
      }
    }
  }

  addUserToFavoriteProfileList(String userTier) {
    bool notFound = true;
    if (userTier.isNotEmpty) {
      userForProfile.userTier = userTier;
    } else {
      userForProfile.userTier = "";
    }
    if (favoriteUsersForProfile.length <= 0) {
      favoriteUsersForProfile.add(userForProfile);
      saveFavoriteUsersForProfile();
    } else {
      for (User favoriteUser in favoriteUsersForProfile) {
        if (favoriteUser.name.toLowerCase() ==
            userForProfile.name.toLowerCase()) {
          notFound = false;
          favoriteUsersForProfile.remove(favoriteUser);
          favoriteUsersForProfile.add(userForProfile);
          saveFavoriteUsersForProfile();
        }
      }
      if (notFound) {
        favoriteUsersForProfile.add(userForProfile);
        saveFavoriteUsersForProfile();
      }
    }
  }

  getUserTierImage(String tier) {
    return _masterRepository.getUserTierImage(tier);
  }

  getChampionRoomOnWeb() async {
    championRoom =
        await _masterRepository.getChampionRoomOnWeb(lolVersion.actualVersion);
    _masterRepository.saveChampionRoom(championRoom.toJson());
  }

  getSummonerSpellsRoom() async {
    spellRoom = await _masterRepository.getSpellRoomOnLocal();
    if (!isSpellRoomStored() || spellRoom.needToLoadVersionFromWeb()) {
      await getSpellRoomOnWeb();
    }
  }

  bool isSpellRoomStored() {
    return spellRoom.lastDate.isNotEmpty;
  }

  getSpellRoomOnWeb() async {
    spellRoom =
        await _masterRepository.getSpellRoomOnWeb(lolVersion.actualVersion);
    _masterRepository.saveSpellRoom(spellRoom.toJson());
  }

  getMapRoom() async {
    mapRoom = await _masterRepository.getMapRoomOnLocal();
    if (!isMapRoomStored() || mapRoom.needToLoadVersionFromWeb()) {
      await getMapRoomOnWeb();
    }
  }

  isMapRoomStored() {
    return mapRoom.lastDate.isNotEmpty;
  }

  getMapRoomOnWeb() async {
    mapRoom = await _masterRepository.getMapRoomOnWeb();
    _masterRepository.saveMapRoom(mapRoom.toJson());
  }

  getRunesRoom() async {
    runesRoom = await _masterRepository.getRunesRoomOnLocal();
    if (!isRunesRoomStored() || runesRoom.needToLoadVersionFromWeb()) {
      await getRunesRoomOnWeb();
    }
  }

  isRunesRoomStored() {
    return runesRoom.lastDate.isNotEmpty;
  }

  getRunesRoomOnWeb() async {
    runesRoom = await _masterRepository.getRunesRoomOnWeb(
        lolVersion.actualVersion, storedRegion.getLocaleKey()!);
    _masterRepository.saveRunesRoom(runesRoom.toJson());
  }

  String getPerkSubStyleIconName(CurrentGamePerk perk) {
    PerkStyle perkStyle = PerkStyle();
    var currentPerk = runesRoom.perkStyle.where(
        (perkStyle) => perkStyle.id.toString() == perk.perkSubStyle.toString());
    if (currentPerk.length > 0) {
      perkStyle = currentPerk.first;
    }
    return perkStyle.icon;
  }

  String getFirstPerkFromPerkStyle(CurrentGamePerk perk) {
    PerkStyle perkStyle = PerkStyle();
    var currentPerk = runesRoom.perkStyle.where(
        (perkStyle) => perkStyle.id.toString() == perk.perkStyle.toString());
    if (currentPerk.length > 0) {
      perkStyle = currentPerk.first;
    }
    Runes runes = Runes();
    var firstIcon;
    for (Slots slot in perkStyle.slots) {
      firstIcon = slot.runes
          .where((rune) => rune.id.toString() == perk.perkIds[0].toString());
      if (firstIcon.length > 0) {
        break;
      }
    }

    if (firstIcon.length > 0) {
      runes = firstIcon.first;
    }
    return runes.icon;
  }

  changeCurrentPageIndex(int newPageIndex) {
    currentPageIndex(newPageIndex);
  }

  getChampionById(String championId) {
    Champion champion = Champion();
    var champs = championRoom.champions
        .where((champ) => champ.detail.key.toString() == championId);
    if (champs.length > 0) champion = champs.first;
    return champion.detail.id;
  }

  getSpellById(String spellId) {
    Spell spell = Spell();
    var spells = spellRoom.summonerSpell.spells
        .where((spell) => spell.key.toString() == spellId);
    if (spells.length > 0) spell = spells.first;
    return spell;
  }

  getMapById(String queueId) {
    return mapRoom.maps.where((map) => map.queueId.toString() == queueId).first;
  }

  getCurrentUserOnCloud(String userName, String keyRegion) async {
    userForCurrentGame =
        await _masterRepository.getUserOnCloud(userName, keyRegion);
  }

  getUserProfileOnCloud(String userName, String keyRegion) async {
    userForProfile =
        await _masterRepository.getUserOnCloud(userName, keyRegion);
  }

  saveUserProfile(String region) {
    this.userForProfile.region = region;
    _masterRepository.saveUserProfile(this.userForProfile);
  }

  deleteUserProfile() {
    _masterRepository.deletePersistedUser();
    userForProfile = User();
  }

  getFavoriteUsersStoredForCurrentGame() async {
    favoriteUsersForCurrentGame.addAll(await _masterRepository.getFavoriteUsersStoredForCurrentGame());
  }

  getFavoriteUsersStoredForProfile() async {
    favoriteUsersForProfile.addAll(await _masterRepository.getFavoriteUsersStoredForProfile());
  }

  saveFavoriteUsersForCurrentGame() {
    _masterRepository.saveFavoriteUsersForCurrentGame(favoriteUsersForCurrentGame);
  }

  saveFavoriteUsersForProfile() {
    _masterRepository.saveFavoriteUsersForProfile(favoriteUsersForProfile);
  }

  removeFavoriteUserForCurrentGame(int index) {
    favoriteUsersForCurrentGame.removeAt(index);
    _masterRepository.saveFavoriteUsersForCurrentGame(favoriteUsersForCurrentGame);
  }

  removeFavoriteUserForProfile(int index) {
    favoriteUsersForProfile.removeAt(index);
    _masterRepository.saveFavoriteUsersForProfile(favoriteUsersForProfile);
  }

  resetCurrentGameUser() {
    userForCurrentGame = User();
  }

  userProfileExist() {
    return userForProfile.id.isNotEmpty;
  }
}
