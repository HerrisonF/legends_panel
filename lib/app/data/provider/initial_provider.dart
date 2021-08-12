import 'package:legends_panel/app/data/http/config/dio_client.dart';
import 'package:legends_panel/app/data/http/config/dio_state.dart';
import 'package:legends_panel/app/data/model/champion.dart';
import 'package:legends_panel/app/data/model/mapMode.dart';
import 'package:legends_panel/app/data/model/spectator/summoner_spell.dart';
import 'package:logger/logger.dart';

class InitialProvider {
  DioClient _dioClient = DioClient(riotDragon: true);
  Logger _logger = Logger();

  Future<String> getLOLVersion() async {
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
    final String path = "/cdn/$version/data/en_US/summoner.json";
    _logger.i("Getting Spell List ...");
    try {
      final response = await _dioClient.get(path);
      if (response.state == CustomState.SUCCESS) {
        return SummonerSpell.fromJson(response.result.data);
      }
    } catch (e) {
      _logger.i("Error to get Spell List $e");
      return SummonerSpell("", "", []);
    }
    _logger.i("Spell List not found ...");
    return SummonerSpell("", "", []);
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
}
