import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:legends_panel/app/data/http/config/dio_client.dart';
import 'package:legends_panel/app/data/http/config/dio_state.dart';
import 'package:legends_panel/app/data/model/current_game_spectator/current_game_summoner_spell.dart';
import 'package:legends_panel/app/data/model/general/champion.dart';
import 'package:legends_panel/app/data/model/general/map_mode.dart';
import 'package:legends_panel/app/data/model/general/user.dart';
import 'package:logger/logger.dart';

const PROFILE_KEY = "userProfile";

class MasterProvider {
  final box = GetStorage('store');
  Logger _logger = Logger();

  Future<String> getLOLVersion() async {
    DioClient _dioClient = DioClient(riotDragon: true);
    final String path = "/api/versions.json";
    _logger.i("Getting lol Version ...");
    try {
      final response = await _dioClient.get(path);
      if (response.state == CustomState.SUCCESS) {
        return response.result.data.first;
      }
    } catch (e) {
      _logger.i("Error to get lol version $e");
      return "";
    }
    _logger.i("Lol version not found ...");
    return "";
  }

  Future<List<Champion>> getChampionList(String version) async {
    DioClient _dioClient = DioClient(riotDragon: true);
    final String path = "/cdn/$version/data/en_US/champion.json";
    _logger.i("Getting Champion List ...");
    List<Champion> championList = <Champion>[];
    try {
      final response = await _dioClient.get(path);
      if (response.state == CustomState.SUCCESS) {
        for (final name in response.result.data['data'].keys) {
          championList
              .add(Champion.fromJson(response.result.data['data'], name));
        }
        return championList;
      }
    } catch (e) {
      _logger.i("Error to get ChampionList $e");
      return championList;
    }
    _logger.i("Champion List not found ...");
    return championList;
  }

  Future<SummonerSpell> getSpellList(String version) async {
    DioClient _dioClient = DioClient(riotDragon: true);
    final String path = "/cdn/$version/data/en_US/summoner.json";
    _logger.i("Getting Spell List ...");
    try {
      final response = await _dioClient.get(path);
      if (response.state == CustomState.SUCCESS) {
        return SummonerSpell.fromJson(response.result.data);
      }
    } catch (e) {
      _logger.i("Error to get Spell List $e");
      return SummonerSpell();
    }
    _logger.i("Spell List not found ...");
    return SummonerSpell();
  }

  Future<List<MapMode>> getMapList() async {
    DioClient _dioClient = DioClient(riotStaticConst: true);
    final String path = "/docs/lol/maps.json";
    _logger.i("Getting static maps ...");
    List<MapMode> mapList = <MapMode>[];
    try {
      final response = await _dioClient.get(path);
      if(response.state == CustomState.SUCCESS){
        for(dynamic mapMode in response.result.data){
          mapList.add(MapMode.fromJson(mapMode));
        }
        return mapList;
      }
      _logger.i("Map List not found ...");
      return mapList;
    } catch (e) {
      _logger.i("Error to get Map List ...");
      return <MapMode>[];
    }
  }

  String getImageUrl(String championName, String version) {
    DioClient _dioClient = DioClient(riotDragon: true);
    final String path = "/cdn/$version/img/champion/${championName.replaceAll(" ", "")}.png";
    _logger.i("building Image URL...");
    try{
      return _dioClient.riotDragonBaseUrl + path;
    }catch(e){
      _logger.i("Error to build Image Url $e");
      return "";
    }
  }

  Future<User> readPersistedUserProfile() async {
    _logger.i("Reading persisted UserProfile Url ...");
    User user = User();
    try{
      String userString = await box.read(PROFILE_KEY);
      if(userString.isNotEmpty){
        return User.fromJson(jsonDecode(userString));
      }
      _logger.i("No userProfile persisted found ...");
      return user;
    }catch(e){
      _logger.i("Error to Read persisted UserProfile ... $e");
      return user;
    }
  }

  Future<bool> saveUserProfile(User user) async {
    _logger.i("Persisting UserProfile ...");
    try{
      await box.write(PROFILE_KEY, jsonEncode(user));
      return true;
    }catch(e){
      _logger.i("Error to persist UserProfile ... $e");
      return false;
    }
  }

  Future<User> getUserOnCloud(String userName) async {
    DioClient _dioClient = DioClient();
    final String path = "/lol/summoner/v4/summoners/by-name/$userName";
    _logger.i("Finding User...");
    try{
      final response = await _dioClient.get(path);
      if(response.state == CustomState.SUCCESS){
        return User.fromJson(response.result.data);
      }
    }catch(e){
      _logger.i("Error to find User ${e.toString()}");
      return User();
    }
    _logger.i("No user found...");
    return User();
  }

  deletePersistedUser(){
    try{
      _logger.i("deleting userProfile");
      box.remove(PROFILE_KEY);
    }catch(e){
      _logger.i("Error to delete userProfile $e");
    }
  }
}
