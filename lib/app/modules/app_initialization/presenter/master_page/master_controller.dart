import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/champion_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/champion_room.dart';
import 'package:legends_panel/app/modules/app_initialization/data/repositories/master_repository.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/runesRoom.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/spell_room.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/stored_region.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/user.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/master_page/queues_controller.dart';
import 'package:legends_panel/app/modules/current_game/domain/current_game_spectator/current_game_perk.dart';
import 'package:legends_panel/app/modules/current_game/domain/current_game_spectator/current_game_summoner_spell.dart';

class MasterController {
  final MasterRepository _masterRepository = MasterRepository(
    logger: GetIt.I.get<Logger>(),
  );
  final QueuesController _queuesController = GetIt.I.get<QueuesController>();

  ValueNotifier<int> currentPageIndex = ValueNotifier(0);

  User userForCurrentGame = User();
  User userForProfile = User();
  StoredRegion storedRegion = StoredRegion();
  ChampionRoom championRoom = ChampionRoom();
  SpellRoom spellRoom = SpellRoom();
  RunesRoom runesRoom = RunesRoom();

  Future<void> initialize() async {

    // if (await ifMyQueuesNotLoad()) return;

    await getLastStoredRegions();
    await readPersistedUser();
    await getChampionRoom();
    await getSummonerSpellsRoom();
    await getRunesRoom();
  }

  // Future<bool> ifMyQueuesNotLoad() async =>
  //     !await _queuesController.initialize();

  getLastStoredRegions() async {
    //storedRegion = await _masterRepository.getLastStoredRegion();
  }

  saveActualRegion() async {
    //await _masterRepository.saveActualRegion(storedRegion);
  }

  readPersistedUser() async {
    //userForProfile = await _masterRepository.readPersistedUserProfile();
  }

  getChampionRoom() async {
    await getChampionRoomOnWeb();
  }

  bool isChampionRoomStored() {
    return championRoom.lastDate.isNotEmpty;
  }

  getUserTierImage(String tier) {
    //return _masterRepository.getUserTierImage(tier);
  }

  getChampionRoomOnWeb() async {
    //championRoom = await _masterRepository.getChampionRoomOnWeb();
    //_masterRepository.saveChampionRoom(championRoom.toJson());
  }

  getSummonerSpellsRoom() async {
    //spellRoom = await _masterRepository.getSpellRoomOnLocal();
    if (!isSpellRoomStored() || spellRoom.needToLoadVersionFromWeb()) {
      await getSpellRoomOnWeb();
    }
  }

  bool isSpellRoomStored() {
    return spellRoom.lastDate.isNotEmpty;
  }

  getSpellRoomOnWeb() async {
    //spellRoom = await _masterRepository.getSpellRoomOnWeb();
    //_masterRepository.saveSpellRoom(spellRoom.toJson());
  }

  getRunesRoom() async {
    // runesRoom = await _masterRepository.getRunesRoomOnLocal();
    if (!isRunesRoomStored() || runesRoom.needToLoadVersionFromWeb()) {
      await getRunesRoomOnWeb();
    }
  }

  isRunesRoomStored() {
    return runesRoom.lastDate.isNotEmpty;
  }

  getRunesRoomOnWeb() async {
    // runesRoom = await _masterRepository.getRunesRoomOnWeb(
    //     storedRegion.getLocaleKey()!);
    // _masterRepository.saveRunesRoom(runesRoom.toJson());
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

  changeCurrentPageIndex(int newPageIndex, BuildContext context) {
    FocusScope.of(context).unfocus();
    currentPageIndex.value = newPageIndex;
  }

  Champion getChampionById(String championId) {
    Champion champion = Champion();
    var champs = championRoom.champions
        .where((champ) => champ.detail.key.toString() == championId);
    if (champs.length > 0) champion = champs.first;
    return champion;
  }

  getSpellById(String spellId) {
    Spell spell = Spell();
    var spells = spellRoom.summonerSpell.spells
        .where((spell) => spell.key.toString() == spellId);
    if (spells.length > 0) spell = spells.first;
    return spell;
  }

  getCurrentUserOnCloud(String userName, String keyRegion) async {
    // userForCurrentGame =
    //     await _masterRepository.getUserOnCloud(userName, keyRegion);
  }

  getUserProfileOnCloud(String userName, String keyRegion) async {
    // userForProfile =
    //     await _masterRepository.getUserOnCloud(userName, keyRegion);
  }

  saveUserProfile(String region) {
    // this.userForProfile.region = region;
    // _masterRepository.saveUserProfile(this.userForProfile);
  }

  deleteUserProfile() {
    // _masterRepository.deletePersistedUser();
    // userForProfile = User();
  }

  resetCurrentGameUser() {
    userForCurrentGame = User();
  }

  userProfileExist() {
    return userForProfile.id.isNotEmpty;
  }
}
