import 'package:legends_panel/app/data/model/user_model.dart';
import 'package:legends_panel/app/data/provider/home_provider.dart';

class HomeRepository {

  final HomeApiClient homeApiClient = HomeApiClient();

  Future<User> getAlgo(){
    return homeApiClient.getAlgo();
  }

}