import 'package:get/get.dart';
import 'package:legends_panel/app/data/model/current_game_spectator/current_game_summoner_spell.dart';
import 'package:legends_panel/app/data/model/general/champion.dart';
import 'package:legends_panel/app/data/model/general/map_mode.dart';
import 'package:legends_panel/app/data/model/general/user.dart';
import 'package:legends_panel/app/data/repository/general/master_repository.dart';

class MasterController {

  final MasterRepository _masterRepository = MasterRepository();

  Rx<User> userCurrentGame = User().obs;
  Rx<User> userProfile = User().obs;

  RxInt currentPageIndex = 0.obs;
  List<Champion> championList = <Champion>[];
  SummonerSpell summonerSpell = SummonerSpell();
  List<MapMode> mapList = <MapMode>[];
  String lolVersion = "";

  start() async {
    await readPersistedUser();
    await getLolVersion();
    await getChampionList();
    await getSummonerSpells();
    await getMapList();
  }

  readPersistedUser() async {
    userProfile.value = await _masterRepository.readPersistedUserProfile();
  }

  getLolVersion() async {
    lolVersion = await _masterRepository.getLOLVersion();
  }

  getChampionList() async {
    championList.addAll(await _masterRepository.getChampionList(lolVersion));
  }

  getSummonerSpells() async {
    summonerSpell = await _masterRepository.getSpellList(lolVersion);
  }

  getMapList() async {
    mapList.addAll(await _masterRepository.getMapList());
  }

  changeCurrentPageIndex(int newPageIndex){
    currentPageIndex(newPageIndex);
  }

  getChampionById(String championId){
    return championList.where((champ) => champ.detail.key.toString() == championId).first;
  }

  getSpellById(String spellId){
    return summonerSpell.spell.where((spell) => spell.key.toString() == spellId).first;
  }


  getMapById(String mapId){
    return mapList.where((map) => map.mapId.toString() == mapId).first;
  }

  getCurrentUserOnCloud(String userName) async {
    userCurrentGame.value = await _masterRepository.getUserOnCloud(userName);
  }

  getUserProfileOnCloud(String userName) async {
    userProfile.value = await _masterRepository.getUserOnCloud(userName);
    if(userProfile.value.id.isNotEmpty){
      saveUserProfile();
    }
  }

  saveUserProfile(){
    _masterRepository.saveUserProfile(this.userProfile.value);
  }

  deleteUserProfile(){
    _masterRepository.deletePersistedUser();
    userProfile.value = User();
  }

  userProfileExist(){
    return userProfile.value.id.isNotEmpty;
  }

}