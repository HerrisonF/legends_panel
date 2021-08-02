import 'package:legends_panel/app/data/model/user.dart';
import 'package:legends_panel/app/data/provider/home_provider.dart';

class HomeRepository {

  final HomeApiClient homeApiClient = HomeApiClient();

  Future<User> findUser(String userName){
    return homeApiClient.findUser(userName);
  }

}