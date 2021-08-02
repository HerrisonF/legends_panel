import 'package:legends_panel/app/data/http/config/dio_client.dart';
import 'package:legends_panel/app/data/model/user.dart';

class HomeApiClient {

  DioClient _dioClient = DioClient();

  Future<User> findUser(String userName) async {
    final String path = "/lol/summoner/v4/summoners/by-name/$userName";
    final response = await _dioClient.get(path);
    print(response.result.data.toString());
    return User();
  }
}
