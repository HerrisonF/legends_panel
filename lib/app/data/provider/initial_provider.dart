import 'package:legends_panel/app/data/http/config/dio_client.dart';
import 'package:legends_panel/app/data/http/config/dio_state.dart';
import 'package:legends_panel/app/data/model/champion.dart';
import 'package:logger/logger.dart';

class InitialProvider {

  DioClient _dioClient = DioClient(riotDragon: true);
  Logger _logger = Logger();

  Future<String> getLOLVersion() async {
    final String path = "/api/versions.json";
    _logger.i("Getting lol Version ...");
    try{
      final response = await _dioClient.get(path);
      if(response.state == CustomState.SUCCESS){
        return response.result.data.first;
      }
    }catch(e){
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
    try{
      final response = await _dioClient.get(path);
      if(response.state == CustomState.SUCCESS){
        for (final name in response.result.data['data'].keys) {
          championList.add(Champion.fromJson(response.result.data['data'], name));
        }
        return championList;
      }
    }catch(e){
      _logger.i("Error to get ChampionList $e");
      return championList;
    }
    _logger.i("Champion List not found ...");
    return championList;
  }

}