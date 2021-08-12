import 'package:legends_panel/app/data/http/config/dio_client.dart';
import 'package:legends_panel/app/data/http/config/dio_state.dart';
import 'package:legends_panel/app/data/model/user.dart';
import 'package:logger/logger.dart';

class HomeApiClient {

  DioClient _dioClient = DioClient();
  Logger _logger = Logger();

  Future<User> findUser(String userName) async {
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
}
