import 'package:legends_panel/app/model/current_game_spectator/current_game_summoner_spell.dart';
import 'package:legends_panel/app/model/general/champion.dart';
import 'package:legends_panel/app/model/general/map_mode.dart';
import 'package:legends_panel/app/model/general/user.dart';
import 'package:legends_panel/app/data/provider/general/master_provider.dart';

class MasterRepository {

  final MasterProvider _masterProvider = MasterProvider();

  Future<String> getLOLVersion() async {
    return _masterProvider.getLOLVersion();
  }

  Future<List<Champion>> getChampionList(String version) async {
    return _masterProvider.getChampionList(version);
  }

  Future<SummonerSpell> getSpellList(String version) {
    return _masterProvider.getSpellList(version);
  }

  Future<List<MapMode>> getMapList() async {
    return _masterProvider.getMapList();
  }

  Future<User> readPersistedUserProfile(){
    return _masterProvider.readPersistedUserProfile();
  }

  Future<User> getUserOnCloud(String userName){
    return _masterProvider.getUserOnCloud(userName);
  }

  Future<bool> saveUserProfile(User user){
    return _masterProvider.saveUserProfile(user);
  }

  deletePersistedUser(){
    _masterProvider.deletePersistedUser();
  }

}