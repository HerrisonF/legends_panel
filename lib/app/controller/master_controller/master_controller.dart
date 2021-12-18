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

  Rx<User> userForCurrentGame = User().obs;
  Rx<User> userForProfile = User().obs;
  late PackageInfo packageInfo;
  Rx<StoredRegion> storedRegion = StoredRegion().obs;
  RxInt currentPageIndex = 0.obs;
  Rx<LolVersion> lolVersion = LolVersion().obs;
  Rx<ChampionRoom> championRoom = ChampionRoom().obs;
  Rx<SpellRoom> spellRoom = SpellRoom().obs;
  Rx<MapRoom> mapRoom = MapRoom().obs;
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
    packageInfo = await PackageInfo.fromPlatform();
    Get.offAllNamed(Routes.MASTER);
  }

  screenSizeIsBiggerThanNexusOne(){
    return WidgetsBinding.instance!.window.physicalSize.width > NEXUS_ONE_SCREEN_WIDTH;
  }

  getLastStoredRegions() async {
    storedRegion.value = await _masterRepository.getLastStoredRegion();
    storedRegion.refresh();
  }

  saveActualRegion() async {
    await _masterRepository.saveActualRegion(storedRegion.value);
  }

  readPersistedUser() async {
    userForProfile.value = await _masterRepository.readPersistedUserProfile();
  }

  getLolVersion() async {
    lolVersion.value = await _masterRepository.getLOLVersionOnLocal();
    if (!isLolVersionStored() || lolVersion.value.needToLoadVersionFromWeb()) {
      await getLolVersionOnWeb();
    }
    lolVersion.refresh();
  }

  bool isLolVersionStored() {
    return lolVersion.value.actualVersion.isNotEmpty;
  }

  getLolVersionOnWeb() async {
    lolVersion.value.versions
        .addAll(await _masterRepository.getLOLVersionOnWeb());
    lolVersion.value.actualVersion = lolVersion.value.versions.first;
    _masterRepository.saveLolVersion(lolVersion.value.toJson());
  }

  getChampionRoom() async {
    championRoom.value = await _masterRepository.getChampionRoomOnLocal();
    if (!isChampionRoomStored() ||
        championRoom.value.needToLoadVersionFromWeb()) {
      await getChampionRoomOnWeb();
    }
    championRoom.refresh();
  }

  bool isChampionRoomStored() {
    return championRoom.value.lastDate.isNotEmpty;
  }

  getChampionRoomOnWeb() async {
    championRoom.value = await _masterRepository
        .getChampionRoomOnWeb(lolVersion.value.actualVersion);
    _masterRepository.saveChampionRoom(championRoom.value.toJson());
  }

  getSummonerSpellsRoom() async {
    spellRoom.value = await _masterRepository.getSpellRoomOnLocal();
    if (!isSpellRoomStored() || spellRoom.value.needToLoadVersionFromWeb()) {
      await getSpellRoomOnWeb();
    }
    spellRoom.refresh();
  }

  bool isSpellRoomStored() {
    return spellRoom.value.lastDate.isNotEmpty;
  }

  getSpellRoomOnWeb() async {
    spellRoom.value = await _masterRepository
        .getSpellRoomOnWeb(lolVersion.value.actualVersion);
    _masterRepository.saveSpellRoom(spellRoom.value.toJson());
  }

  getMapRoom() async {
    mapRoom.value = await _masterRepository.getMapRoomOnLocal();
    if (!isMapRoomStored() || mapRoom.value.needToLoadVersionFromWeb()) {
      await getMapRoomOnWeb();
    }
    mapRoom.refresh();
  }

  isMapRoomStored() {
    return mapRoom.value.lastDate.isNotEmpty;
  }

  getMapRoomOnWeb() async {
    mapRoom.value = await _masterRepository.getMapRoomOnWeb();
    _masterRepository.saveMapRoom(mapRoom.value.toJson());
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
        lolVersion.value.actualVersion, storedRegion.value.getLocaleKey()!);
    _masterRepository.saveRunesRoom(runesRoom.toJson());
  }

  String getPerkStyle(CurrentGamePerk perk) {
    PerkStyle perkStyle = PerkStyle();
    var currentPerk = runesRoom.perkStyle.where(
        (perkStyle) => perkStyle.id.toString() == perk.perkSubStyle.toString());
    if (currentPerk.length > 0) {
      perkStyle = currentPerk.first;
    }
    return perkStyle.icon;
  }

  String getFirstPerkFromPerkStyle(CurrentGamePerk perk){
    PerkStyle perkStyle = PerkStyle();
    var currentPerk = runesRoom.perkStyle.where(
            (perkStyle) => perkStyle.id.toString() == perk.perkStyle.toString());
    if (currentPerk.length > 0) {
      perkStyle = currentPerk.first;
    }
    Runes runes = Runes();
    var firstIcon;
    for(Slots slot in perkStyle.slots){
      firstIcon = slot.runes.where((rune)=> rune.id.toString() == perk.perkIds[0].toString());
      if(firstIcon.length > 0){
        break;
      }
    }

    if(firstIcon.length > 0){
      runes = firstIcon.first;
    }
    return runes.icon;
  }

  changeCurrentPageIndex(int newPageIndex) {
    currentPageIndex(newPageIndex);
  }

  getChampionById(String championId) {
    Champion champion = Champion();
    var champs = championRoom.value.champions
        .where((champ) => champ.detail.key.toString() == championId);
    if (champs.length > 0) champion = champs.first;
    return champion.detail.id;
  }

  getSpellById(String spellId) {
    Spell spell = Spell();
    var spells = spellRoom.value.summonerSpell.spells
        .where((spell) => spell.key.toString() == spellId);
    if (spells.length > 0) spell = spells.first;
    return spell;
  }

  getMapById(String queueId) {
    return mapRoom.value.maps
        .where((map) => map.queueId.toString() == queueId)
        .first;
  }

  getCurrentUserOnCloud(String userName, String keyRegion) async {
    userForCurrentGame.value =
        await _masterRepository.getUserOnCloud(userName, keyRegion);
  }

  getUserProfileOnCloud(String userName, String keyRegion) async {
    userForProfile.value =
        await _masterRepository.getUserOnCloud(userName, keyRegion);
  }

  saveUserProfile(String region) {
    this.userForProfile.value.region = region;
    _masterRepository.saveUserProfile(this.userForProfile.value);
  }

  deleteUserProfile() {
    _masterRepository.deletePersistedUser();
    userForProfile.value = User();
  }

  userProfileExist() {
    return userForProfile.value.id.isNotEmpty;
  }
}
