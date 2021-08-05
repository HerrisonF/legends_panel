import 'package:legends_panel/app/data/http/config/dio_client.dart';
import 'package:legends_panel/app/data/http/config/dio_state.dart';
import 'package:legends_panel/app/data/model/user.dart';

class HomeApiClient {

  DioClient _dioClient = DioClient();

  Future<User> findUser(String userName) async {
    final String path = "/lol/summoner/v4/summoners/by-name/$userName";
    try{
      final response = await _dioClient.get(path);
      if(response.state == CustomState.SUCCESS){
        return User.fromJson(response.result.data);
      }
    }catch(e){
      return User();
    }
    return User();
  }
}
