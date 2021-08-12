import 'package:basic_utils/basic_utils.dart';
import 'package:legends_panel/app/data/http/config/dio_client.dart';
import 'package:legends_panel/app/data/http/config/dio_state.dart';
import 'package:legends_panel/app/data/model/spectator/spectator.dart';
import 'package:logger/logger.dart';

class SubProfileResultProvider {

  DioClient _dioClient = DioClient();
  Logger _logger = Logger();

  Future<Spectator> fetchCurrentGame(String userId) async {
    final String path = "/lol/spectator/v4/active-games/by-summoner/$userId";
    _logger.i("Fetching Current Game ...");
    try{
      final response = await _dioClient.get(path);
      if(response.state == CustomState.SUCCESS){
        return Spectator.fromJson(response.result.data);
      }
    }catch(e){
      _logger.i("Error fetching Current Game $e");
      return Spectator();
    }
    _logger.i("No current game found ...");
    return Spectator();
  }

  String getChampionBadgeUrl(String championId, String version) {
    final String path = "/cdn/$version/img/champion/$championId.png";
    _logger.i("building Image Champion URL...");
    try{
      return _dioClient.riotDragonBaseUrl + path;
    }catch(e){
      _logger.i("Error to build Image Champion Url $e");
      return "";
    }
  }

  String getSpellBadgeUrl(String spellName, String version){
    final String path = "/cdn/$version/img/spell/$spellName.png";
    _logger.i("building Image Spell Url ...");
    try{
      return _dioClient.riotDragonBaseUrl + path;
    }catch(e){
      _logger.i("Error to build Spell Image URL");
      return "";
    }
  }

}