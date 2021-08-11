import 'package:legends_panel/app/data/model/user.dart';
import 'package:legends_panel/app/data/provider/home_provider.dart';
import 'package:legends_panel/app/data/provider/master_provider.dart';

class MasterRepository {

  final MasterProvider masterProvider = MasterProvider();

  String getImageUrl(String championName, String version){
    return masterProvider.getImageUrl(championName, version);
  }

}