import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:legends_panel/app/constants/storage_keys.dart';
import 'package:legends_panel/app/data/http/config/dio_client.dart';
import 'package:legends_panel/app/data/http/config/dio_state.dart';
import 'package:legends_panel/app/data/http/config/riot_and_raw_dragon_urls.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_summoner_spell.dart';
import 'package:legends_panel/app/model/general/champion.dart';
import 'package:legends_panel/app/model/general/champion_room.dart';
import 'package:legends_panel/app/model/general/lol_version.dart';
import 'package:legends_panel/app/model/general/map_mode.dart';
import 'package:legends_panel/app/model/general/map_room.dart';
import 'package:legends_panel/app/model/general/spell_room.dart';
import 'package:legends_panel/app/model/general/user.dart';
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

  Future<LolVersion> getLOLVersionOnLocal() async {
    _logger.i("Getting lol Version on local ...");
    try {
      String lolVersionString = await box.read(StorageKeys.lolVersion);
      if (lolVersionString != null || lolVersionString.isNotEmpty) {
        _logger.i("Success to get lol Version on Local ...");
        return LolVersion.fromJson(jsonDecode(lolVersionString));
      }
    } catch (e) {
      _logger.i("Error to get lol version on local $e");
      return LolVersion();
    }
    _logger.i("Lol version not found on local ...");
    return LolVersion();
  }

  saveLolVersion(Map<String, dynamic> lolVersion) {
    _logger.i("Persisting LolVersion ...");
    try {
      box.write(StorageKeys.lolVersion, jsonEncode(lolVersion));
      _logger.i("Success to persist LolVersion ...");
    } catch (e) {
      _logger.i("Error to persist LolVersion ... $e");
    }
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
    _logger.i("Getting ChampionRoom on local ...");
    try {
      String championRoomString = await box.read(StorageKeys.championRoom);
      if (championRoomString != null || championRoomString.isNotEmpty) {
        _logger.i("Success to get ChampionRoom on Local ...");
        return ChampionRoom.fromJson(jsonDecode(championRoomString));
      }
    } catch (e) {
      _logger.i("Error to get ChampionRoom on local $e");
      return ChampionRoom();
    }
    _logger.i("ChampionRoom not found on local ...");
    return ChampionRoom();
  }

  saveChampionRoom(Map<String, dynamic> championRoom) {
    _logger.i("Persisting ChampionRoom ...");
    try {
      box.write(StorageKeys.championRoom, jsonEncode(championRoom));
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
      String spellRoomString = await box.read(StorageKeys.spellRoom);
      if (spellRoomString != null || spellRoomString.isNotEmpty) {
        _logger.i("Success to get SpellRoom on Local ...");
        return SpellRoom.fromJson(jsonDecode(spellRoomString));
      }
    } catch (e) {
      _logger.i("Error to get SpellRoom on local $e");
      return SpellRoom();
    }
    _logger.i("SpellRoom on local not found ...");
    return SpellRoom();
  }

  saveSpellRoom(Map<String, dynamic> spellRoom) {
    _logger.i("Persisting SpellRoom ...");
    try {
      box.write(StorageKeys.spellRoom, jsonEncode(spellRoom));
      _logger.i("Success to persist SpellRoom ...");
    } catch (e) {
      _logger.i("Error to persist SpellRoom ... $e");
    }
  }

  Future<MapRoom> getMapRoomOnWeb() async {
    DioClient _dioClient =
        DioClient(url: RiotAndRawDragonUrls.riotStaticDataUrl);
    final String path = "/docs/lol/maps.json";
    _logger.i("Getting mapRoom ...");
    MapRoom mapRoom = MapRoom();
    try {
      final response = await _dioClient.get(path);
      if (response.state == CustomState.SUCCESS) {
        for (dynamic mapMode in response.result.data) {
          mapRoom.maps.add(MapMode.fromJson(mapMode));
        }
        _logger.i("Success to get mapRoom ...");
        return mapRoom;
      }
      _logger.i("MapRoom not found ...");
      return mapRoom;
    } catch (e) {
      _logger.i("Error to get MapRoom ...");
      return mapRoom;
    }
  }

  Future<MapRoom> getMapRoomOnLocal() async {
    _logger.i("Getting MapRoom on Local ...");
    try {
      String mapRoomString = await box.read(StorageKeys.mapRoom);
      if (mapRoomString != null || mapRoomString.isNotEmpty) {
        _logger.i("Success to get MapRoom on Local ...");
        return MapRoom.fromJson(jsonDecode(mapRoomString));
      }
    } catch (e) {
      _logger.i("Error to get mapRoom on local $e");
      return MapRoom();
    }
    _logger.i("mapRoom on local not found ...");
    return MapRoom();
  }

  saveMapRoom(Map<String, dynamic> mapRoom) {
    _logger.i("Persisting mapRoom ...");
    try {
      box.write(StorageKeys.mapRoom, jsonEncode(mapRoom));
      _logger.i("Success to persist MapRoom ...");
    } catch (e) {
      _logger.i("Error to persist MapRoom ... $e");
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
      if (userString != null || userString.isNotEmpty) {
        return User.fromJson(jsonDecode(userString));
      }
      _logger.i("No userProfile persisted found ...");
      return user;
    } catch (e) {
      _logger.i("Error to Read persisted UserProfile ... $e");
      return user;
    }
  }

  Future<bool> saveUserProfile(User user) async {
    _logger.i("Persisting UserProfile ...");
    try {
      await box.write(StorageKeys.userProfileKey, jsonEncode(user));
      return true;
    } catch (e) {
      _logger.i("Error to persist UserProfile ... $e");
      return false;
    }
  }

  Future<User> getUserOnCloud(String summonerName, String region) async {
    DioClient _dioClient =
        DioClient(url: RiotAndRawDragonUrls.riotBaseUrl(region));
    final String path = "/lol/summoner/v4/summoners/by-name/$summonerName";
    _logger.i("Finding User...");
    try {
      final response = await _dioClient.get(path);
      if (response.state == CustomState.SUCCESS) {
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
}
