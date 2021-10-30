import 'package:legends_panel/app/data/http/config/dio_client.dart';
import 'package:legends_panel/app/data/http/config/dio_state.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_spectator.dart';
import 'package:logger/logger.dart';

class CurrentGameProvider {

  DioClient _dioClient = DioClient();
  Logger _logger = Logger();

  Future<CurrentGameSpectator> checkCurrentGameExists(String encryptedSummonerId) async {
    final String path = "/lol/spectator/v4/active-games/by-summoner/$encryptedSummonerId";
    _logger.i("Checking Current Game exists ...");
    try{
      final response = await _dioClient.get(path);
      if(response.state == CustomState.SUCCESS){
        return CurrentGameSpectator.fromJson(response.result.data);
      }
    }catch(e){
      _logger.i("Error to check Current Game exists $e");
      return CurrentGameSpectator();
    }
    _logger.i("No current game found ...");
    return CurrentGameSpectator();
  }
}
