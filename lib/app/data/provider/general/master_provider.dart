import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:legends_panel/app/constants/storage_keys.dart';
import 'package:legends_panel/app/data/http/config/dio_client.dart';
import 'package:legends_panel/app/data/http/config/dio_state.dart';
import 'package:legends_panel/app/data/http/config/riot_and_raw_dragon_urls.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_summoner_spell.dart';
import 'package:legends_panel/app/model/general/champion.dart';
import 'package:legends_panel/app/model/general/champion_room.dart';
import 'package:legends_panel/app/model/general/runesRoom.dart';
import 'package:legends_panel/app/model/general/spell_room.dart';
import 'package:legends_panel/app/model/general/stored_region.dart';
import 'package:legends_panel/app/model/general/user.dart';
import 'package:legends_panel/app/model/general/user_favorite.dart';
import 'package:logger/logger.dart';

class MasterProvider {
  final box = GetStorage(StorageKeys.globalStorageKey);
  Logger _logger = Logger();

  Future<List<String>> getLOLVersionOnWeb() async {
    DioClient _dioClient = DioClient(url: RiotAndRawDragonUrls.riotDragonUrl);
    final String path = "/api/versions.json";
    _logger.i("Getting lol Version on Web ...");
    try {
      final response = await _dioClient.get(path);
      if (response.state == CustomState.SUCCESS) {
        List<String> versions = [];
        for (dynamic version in response.result.data) {
          versions.add(version);
        }
        _logger.i("Success to get lol Version on Web ...");
        return versions;
      }
    } catch (e) {
      _logger.i("Error to get lol version on Web $e");
      return [];
    }
    _logger.i("Lol version not found on Web ...");
    return [];
  }

  Future<ChampionRoom> getChampionRoomOnWeb(String version) async {
    DioClient _dioClient = DioClient(url: RiotAndRawDragonUrls.riotDragonUrl);
    final String path = "/cdn/$version/data/en_US/champion.json";
    _logger.i("Getting Champion Room ...");
    ChampionRoom championRoom = ChampionRoom();
    try {
      final response = await _dioClient.get(path);
      if (response.state == CustomState.SUCCESS) {
        for (final name in response.result.data['data'].keys) {
          championRoom.champions
              .add(Champion.fromJson(response.result.data['data'], name));
        }
        _logger.i("Success To get Champion Room ...");
        return championRoom;
      }
    } catch (e) {
      _logger.i("Error to get ChampionRoom $e");
      return championRoom;
    }
    _logger.i("Champion Room not found ...");
    return championRoom;
  }

  Future<ChampionRoom> getChampionRoomOnLocal() async {
    _logger.i("Getting ChampionRoom on local_imp ...");
    try {
      String championRoomString = await box.read(StorageKeys.championRoomKey);
      if (championRoomString.isNotEmpty) {
        _logger.i("Success to get ChampionRoom on Local ...");
        return ChampionRoom.fromJson(jsonDecode(championRoomString));
      }
    } catch (e) {
      _logger.i("Error to get ChampionRoom on local_imp $e");
      return ChampionRoom();
    }
    _logger.i("ChampionRoom not found on local_imp ...");
    return ChampionRoom();
  }

  saveChampionRoom(Map<String, dynamic> championRoom) {
    _logger.i("Persisting ChampionRoom ...");
    try {
      box.write(StorageKeys.championRoomKey, jsonEncode(championRoom));
      _logger.i("Success to persist ChampionRoom ...");
    } catch (e) {
      _logger.i("Error to persist ChampionRoom ... $e");
    }
  }

  Future<SpellRoom> getSpellRoomOnWeb(String version) async {
    DioClient _dioClient = DioClient(url: RiotAndRawDragonUrls.riotDragonUrl);
    final String path = "/cdn/$version/data/en_US/summoner.json";
    _logger.i("Getting SpellRoom ...");
    try {
      SpellRoom spellRoom = SpellRoom();
      final response = await _dioClient.get(path);
      if (response.state == CustomState.SUCCESS) {
        _logger.i("Success to get SpellRoom ...");
        spellRoom.summonerSpell = SummonerSpell.fromJson(response.result.data);
        return spellRoom;
      }
    } catch (e) {
      _logger.i("Error to get SpellRoom $e");
      return SpellRoom();
    }
    _logger.i("SpellRoom not found ...");
    return SpellRoom();
  }

  Future<SpellRoom> getSpellRoomOnLocal() async {
    _logger.i("Getting SpellRoom on Local ...");
    try {
      String spellRoomString = await box.read(StorageKeys.spellRoomKey);
      if (spellRoomString.isNotEmpty) {
        _logger.i("Success to get SpellRoom on Local ...");
        return SpellRoom.fromJson(jsonDecode(spellRoomString));
      }
    } catch (e) {
      _logger.i("Error to get SpellRoom on local_imp $e");
      return SpellRoom();
    }
    _logger.i("SpellRoom on local_imp not found ...");
    return SpellRoom();
  }

  saveSpellRoom(Map<String, dynamic> spellRoom) {
    _logger.i("Persisting SpellRoom ...");
    try {
      box.write(StorageKeys.spellRoomKey, jsonEncode(spellRoom));
      _logger.i("Success to persist SpellRoom ...");
    } catch (e) {
      _logger.i("Error to persist SpellRoom ... $e");
    }
  }

  saveMapRoom(Map<String, dynamic> mapRoom) {
    _logger.i("Persisting mapRoom ...");
    try {
      box.write(StorageKeys.mapRoomKey, jsonEncode(mapRoom));
      _logger.i("Success to persist MapRoom ...");
    } catch (e) {
      _logger.i("Error to persist MapRoom ... $e");
    }
  }

  Future<RunesRoom> getRunesRoomOnWeb(String version, String regionKey) async {
    DioClient _dioClient =
    DioClient(url: RiotAndRawDragonUrls.riotDragonUrl);
    final String path = "/cdn/$version/data/$regionKey/runesReforged.json";
    _logger.i("Getting runesRoom ...");
    RunesRoom runesRoom = RunesRoom();
    try {
      final response = await _dioClient.get(path);
      if (response.state == CustomState.SUCCESS) {
        for (dynamic runesRoomTemp in response.result.data) {
          runesRoom.perkStyle.add(PerkStyle.fromJson(runesRoomTemp));
        }
        _logger.i("Success to get runesRoom ...");
        return runesRoom;
      }
      _logger.i("RunesRoom not found ...");
      return runesRoom;
    } catch (e) {
      _logger.i("Error to get RunesRoom ...");
      return runesRoom;
    }
  }

  Future<RunesRoom> getRunesRoomOnLocal() async {
    _logger.i("Getting RunesRoom on Local ...");
    try {
      String runesRoomString = await box.read(StorageKeys.runesRoomKey);
      if (runesRoomString.isNotEmpty) {
        _logger.i("Success to get RunesRoom on Local ...");
        return RunesRoom.fromJson(jsonDecode(runesRoomString));
      }
    } catch (e) {
      _logger.i("Error to get RunesRoom on local_imp $e");
      return RunesRoom();
    }
    _logger.i("runesRoom on local_imp not found ...");
    return RunesRoom();
  }

  saveRunesRoom(Map<String, dynamic> runesRoom) {
    _logger.i("Persisting runesRoom ...");
    try {
      box.write(StorageKeys.runesRoomKey, jsonEncode(runesRoom));
      _logger.i("Success to persist runesRoom ...");
    } catch (e) {
      _logger.i("Error to persist runesRoom ... $e");
    }
  }

  String getImageUrl(String championName, String version) {
    final String path =
        "/cdn/$version/img/champion/${championName.replaceAll(" ", "")}.png";
    _logger.i("building Image URL...");
    try {
      return RiotAndRawDragonUrls.riotDragonUrl + path;
    } catch (e) {
      _logger.i("Error to build Image Url $e");
      return "";
    }
  }

  Future<User> readPersistedUserProfile() async {
    _logger.i("Reading persisted UserProfile Url ...");
    User user = User();
    try {
      String userString = await box.read(StorageKeys.userProfileKey);
      if (userString.isNotEmpty) {
        return User.fromJson(jsonDecode(userString));
      }
      _logger.i("No userProfile persisted found ...");
      return user;
    } catch (e) {
      _logger.i("Error to Read persisted UserProfile ... $e");
      return user;
    }
  }

  Future<UserFavorite> readFavoriteUsersStoredForCurrentGame() async {
    _logger.i("Reading favorite users stored for current game ...");
    try {
      String userFavoriteStore = await box.read(StorageKeys.userFavoriteForCurrentGameKey);
      if (userFavoriteStore.isNotEmpty) {
        _logger.i("Success to get userFavorite on Local for current game ...");
        return UserFavorite.fromJson(jsonDecode(userFavoriteStore));
      }
      _logger.i("No userFavorite persisted found for current game ...");
      return UserFavorite();
    } catch (e) {
      _logger.i("Error to Read persisted favorite users for current game ... $e");
      return UserFavorite();
    }
  }

  Future<UserFavorite> readFavoriteUsersStoredForProfile() async {
    _logger.i("Reading favorite users stored for profile ...");
    try {
      String userFavoriteStore = await box.read(StorageKeys.userFavoriteForProfileKey);
      if (userFavoriteStore.isNotEmpty) {
        _logger.i("Success to get userFavorite on Local for profile ...");
        return UserFavorite.fromJson(jsonDecode(userFavoriteStore));
      }
      _logger.i("No userProfile persisted found for profile ...");
      return UserFavorite();
    } catch (e) {
      _logger.i("Error to Read persisted favorite users for profile ... $e");
      return UserFavorite();
    }
  }


  String getUserTierImage(String tier){
    _logger.i("building Image Tier Url ...");
    try{
      return "images/ranked_mini_emblems/${tier.toLowerCase()}.png";
    }catch(e){
      _logger.i("Error to build Tier Image URL ... $e");
      return "";
    }
  }

  saveFavoriteUsersForCurrentGame(UserFavorite usersFavorite) async {
    deleteFavoriteUsersForCurrentGame();
    _logger.i("Persisting FavoriteUser for current game ...");
    try {
      await box.write(StorageKeys.userFavoriteForCurrentGameKey, jsonEncode(usersFavorite));
      _logger.i("Success to persist favorite user for current game ...");
    } catch (e) {
      _logger.i("Error to persist favorite user for current game ... $e");
    }
  }

  saveFavoriteUsersForProfile(UserFavorite usersFavorite) async {
    deleteFavoriteUsersForCurrentGame();
    _logger.i("Persisting FavoriteUser for profile ...");
    try {
      await box.write(StorageKeys.userFavoriteForProfileKey, jsonEncode(usersFavorite));
      _logger.i("Success to persist favorite user for profile ...");
    } catch (e) {
      _logger.i("Error to persist favorite user for profile ... $e");
    }
  }

  deleteFavoriteUsersForCurrentGame(){
    try {
      _logger.i("deleting favorite users for current game");
      box.remove(StorageKeys.userFavoriteForCurrentGameKey);
    } catch (e) {
      _logger.i("Error to delete favorite users for current game $e");
    }
  }

  deleteFavoriteUsersForProfile(){
    try {
      _logger.i("deleting favorite users for profile");
      box.remove(StorageKeys.userFavoriteForProfileKey);
    } catch (e) {
      _logger.i("Error to delete favorite users for profile $e");
    }
  }

  saveUserProfile(User user) async {
    _logger.i("Persisting UserProfile ...");
    try {
      await box.write(StorageKeys.userProfileKey, jsonEncode(user));
      _logger.i("Success to persist UserProfile ...");
    } catch (e) {
      _logger.i("Error to persist UserProfile ... $e");
    }
  }

  Future<User> getUserOnCloud(String summonerName, String keyRegion) async {
    DioClient _dioClient =
        DioClient(url: RiotAndRawDragonUrls.riotBaseUrl(keyRegion));
    final String path = "/lol/summoner/v4/summoners/by-name/$summonerName";
    _logger.i("Finding User...");
    try {
      final response = await _dioClient.get(path);
      if (response.state == CustomState.SUCCESS) {
        _logger.i("Success to Found User...");
        return User.fromJson(response.result.data);
      }
    } catch (e) {
      _logger.i("Error to find User ${e.toString()}");
      return User();
    }
    _logger.i("No user found...");
    return User();
  }

  deletePersistedUser() {
    try {
      _logger.i("deleting userProfile");
      box.remove(StorageKeys.userProfileKey);
    } catch (e) {
      _logger.i("Error to delete userProfile $e");
    }
  }

  Future<StoredRegion> getLastStoredRegion() async {
    _logger.i("Getting LastStoredRegion ...");
    StoredRegion storedRegion = StoredRegion();
    try{
      String lastStoredRegionString = await box.read(StorageKeys.regionKey);
      if(lastStoredRegionString.isNotEmpty){
        storedRegion = StoredRegion.fromJson(jsonDecode(lastStoredRegionString));
      }
      _logger.i("Success to get LastStoredRegion ...");
      return storedRegion;
    }catch(e){
      _logger.i("Error to get LastStoredRegion $e");
      return storedRegion;
    }
  }

  saveActualRegion(StoredRegion storedRegion) async {
    _logger.i("Saving Actual Region ...");
    try{
      await box.write(StorageKeys.regionKey, jsonEncode(storedRegion));
      _logger.i("Success to persist Actual Region ...");
    }catch(e){
      _logger.i("Error to save Actual Region $e");
    }
  }
}
