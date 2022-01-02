import 'package:legends_panel/app/data/http/config/dio_client.dart';
import 'package:legends_panel/app/data/http/config/dio_state.dart';
import 'package:legends_panel/app/data/http/config/riot_and_raw_dragon_urls.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_spectator.dart';
import 'package:logger/logger.dart';

class CurrentGameProvider {

  Logger _logger = Logger();

  Future<CurrentGameSpectator> getCurrentGameExists(String encryptedSummonerId, String keyRegion) async {
    final String path = "/lol/spectator/v4/active-games/by-summoner/$encryptedSummonerId";
    _logger.i("Getting currentGame ...");
    try{
      DioClient _dioClient = DioClient(url: RiotAndRawDragonUrls.riotBaseUrl(keyRegion));
      final response = await _dioClient.get(path);
      if(response.state == CustomState.SUCCESS){
        _logger.i("Current game exist ...");
        return CurrentGameSpectator.fromJson(response.result.data);
      }
    }catch(e){
      _logger.i("Error to get Current game $e");
      return CurrentGameSpectator();
    }
    _logger.i("Current game not exists ...");
    return CurrentGameSpectator();
  }
}
