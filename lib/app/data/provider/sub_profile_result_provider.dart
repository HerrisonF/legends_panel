import 'package:legends_panel/app/data/http/config/dio_client.dart';
import 'package:legends_panel/app/data/http/config/dio_state.dart';
import 'package:legends_panel/app/data/model/spectator/spectator.dart';

class SubProfileResultProvider {

  DioClient _dioClient = DioClient();

  Future<Spectator> fetchCurrentGame(String userId) async {
    final String path = "/lol/spectator/v4/active-games/by-summoner/$userId";
    try{
      final response = await _dioClient.get(path);
      if(response.state == CustomState.SUCCESS){
        return Spectator.fromJson(response.result.data);
      }
    }catch(e){
      return Spectator();
    }
    return Spectator();
  }

}