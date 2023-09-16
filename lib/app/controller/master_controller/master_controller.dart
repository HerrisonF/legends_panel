import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:legends_panel/app/layers/presentation/controllers/lol_version_controller.dart';
import 'package:legends_panel/app/layers/presentation/controllers/queues_controller.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_perk.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_summoner_spell.dart';
import 'package:legends_panel/app/model/general/champion.dart';
import 'package:legends_panel/app/model/general/champion_room.dart';
import 'package:legends_panel/app/model/general/runesRoom.dart';
import 'package:legends_panel/app/model/general/spell_room.dart';
import 'package:legends_panel/app/model/general/stored_region.dart';
import 'package:legends_panel/app/model/general/user.dart';
import 'package:legends_panel/app/data/repository/general/master_repository.dart';
import 'package:legends_panel/app/routes/routes_path.dart';

class MasterController {
  final MasterRepository _masterRepository = MasterRepository();
  final LolVersionController _lolVersionController =
      GetIt.I.get<LolVersionController>();
  final QueuesController _queuesController = GetIt.I.get<QueuesController>();

  ValueNotifier<int> currentPageIndex = ValueNotifier(0);

  User userForCurrentGame = User();
  User userForProfile = User();
  //ValueNotifier<List<User>> favoriteUsersForCurrentGame = ValueNotifier([]);
  //ValueNotifier<List<User>> favoriteUsersForProfile = ValueNotifier([]);
  StoredRegion storedRegion = StoredRegion();
  ChampionRoom championRoom = ChampionRoom();
  SpellRoom spellRoom = SpellRoom();
  RunesRoom runesRoom = RunesRoom();

  initialize(BuildContext context) async {
    if(await ifMyVersionsNotLoad())
      return;

    if(await ifMyQueuesNotLoad())
      return;

    await getLastStoredRegions();
    await readPersistedUser();
    await getChampionRoom();
    await getSummonerSpellsRoom();
    await getRunesRoom();
    // await getFavoriteUsersStoredForCurrentGame();
    // await getFavoriteUsersStoredForProfile();
    context.push(RoutesPath.MASTER);
  }

  Future<bool> ifMyQueuesNotLoad() async => !await _queuesController.initialize();

  Future<bool> ifMyVersionsNotLoad() async => !await _lolVersionController.initialize();

  getLastStoredRegions() async {
    storedRegion = await _masterRepository.getLastStoredRegion();
  }

  saveActualRegion() async {
    await _masterRepository.saveActualRegion(storedRegion);
  }

  readPersistedUser() async {
    userForProfile = await _masterRepository.readPersistedUserProfile();
  }

  getChampionRoom() async {
    await getChampionRoomOnWeb();
  }

  bool isChampionRoomStored() {
    return championRoom.lastDate.isNotEmpty;
  }

  // addUserToFavoriteCurrentGameList(String userTier) {
  //   bool notFound = true;
  //   if (userTier.isNotEmpty) {
  //     userForCurrentGame.userTier = userTier;
  //   } else {
  //     userForCurrentGame.userTier = "";
  //   }
  //   if (favoriteUsersForCurrentGame.value.length <= 0) {
  //     favoriteUsersForCurrentGame.value.add(userForCurrentGame);
  //     saveFavoriteUsersForCurrentGame();
  //   } else {
  //     for (User favoriteUser in favoriteUsersForCurrentGame.value) {
  //       if (favoriteUser.name.toLowerCase() ==
  //           userForCurrentGame.name.toLowerCase()) {
  //         notFound = false;
  //         favoriteUsersForCurrentGame.value.remove(favoriteUser);
  //         favoriteUsersForCurrentGame.value.add(userForCurrentGame);
  //         saveFavoriteUsersForCurrentGame();
  //       }
  //     }
  //     if (notFound) {
  //       favoriteUsersForCurrentGame.value.add(userForCurrentGame);
  //       saveFavoriteUsersForCurrentGame();
  //     }
  //   }
  // }

  // addUserToFavoriteProfileList(String userTier) {
  //   bool notFound = true;
  //   if (userTier.isNotEmpty) {
  //     userForProfile.userTier = userTier;
  //   } else {
  //     userForProfile.userTier = "";
  //   }
  //   if (favoriteUsersForProfile.value.length <= 0) {
  //     favoriteUsersForProfile.value.add(userForProfile);
  //     saveFavoriteUsersForProfile();
  //   } else {
  //     for (User favoriteUser in favoriteUsersForProfile.value) {
  //       if (favoriteUser.name.toLowerCase() ==
  //           userForProfile.name.toLowerCase()) {
  //         notFound = false;
  //         favoriteUsersForProfile.value.remove(favoriteUser);
  //         favoriteUsersForProfile.value.add(userForProfile);
  //         saveFavoriteUsersForProfile();
  //       }
  //     }
  //     if (notFound) {
  //       favoriteUsersForProfile.value.add(userForProfile);
  //       saveFavoriteUsersForProfile();
  //     }
  //   }
  // }

  getUserTierImage(String tier) {
    return _masterRepository.getUserTierImage(tier);
  }

  getChampionRoomOnWeb() async {
    championRoom = await _masterRepository.getChampionRoomOnWeb(
        _lolVersionController.cachedLolVersion.getLatestVersion());
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
    spellRoom = await _masterRepository.getSpellRoomOnWeb(
        _lolVersionController.cachedLolVersion.getLatestVersion());
    _masterRepository.saveSpellRoom(spellRoom.toJson());
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
        _lolVersionController.cachedLolVersion.getLatestVersion(),
        storedRegion.getLocaleKey()!);
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

  // getFavoriteUsersStoredForCurrentGame() async {
  //   favoriteUsersForCurrentGame.value
  //       .addAll(await _masterRepository.getFavoriteUsersStoredForCurrentGame());
  // }
  //
  // getFavoriteUsersStoredForProfile() async {
  //   favoriteUsersForProfile.value
  //       .addAll(await _masterRepository.getFavoriteUsersStoredForProfile());
  // }

  // saveFavoriteUsersForCurrentGame() {
  //   _masterRepository
  //       .saveFavoriteUsersForCurrentGame(favoriteUsersForCurrentGame.value);
  // }
  //
  // saveFavoriteUsersForProfile() {
  //   _masterRepository.saveFavoriteUsersForProfile(favoriteUsersForProfile.value);
  // }
  //
  // removeFavoriteUserForCurrentGame(int index) {
  //   favoriteUsersForCurrentGame.value.removeAt(index);
  //   _masterRepository
  //       .saveFavoriteUsersForCurrentGame(favoriteUsersForCurrentGame.value);
  // }

  // removeFavoriteUserForProfile(int index) {
  //   favoriteUsersForProfile.value.removeAt(index);
  //   _masterRepository.saveFavoriteUsersForProfile(favoriteUsersForProfile.value);
  // }

  resetCurrentGameUser() {
    userForCurrentGame = User();
  }

  userProfileExist() {
    return userForProfile.id.isNotEmpty;
  }
}
