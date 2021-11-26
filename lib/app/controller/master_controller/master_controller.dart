import 'package:get/get.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_summoner_spell.dart';
import 'package:legends_panel/app/model/general/champion.dart';
import 'package:legends_panel/app/model/general/map_mode.dart';
import 'package:legends_panel/app/model/general/user.dart';
import 'package:legends_panel/app/data/repository/general/master_repository.dart';
import 'package:legends_panel/app/routes/app_routes.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MasterController {

  final MasterRepository _masterRepository = MasterRepository();

  Rx<User> userCurrentGame = User().obs;
  Rx<User> userProfile = User().obs;
  late PackageInfo packageInfo;

  RxInt currentPageIndex = 0.obs;
  List<Champion> championList = <Champion>[];
  SummonerSpell summonerSpell = SummonerSpell();
  List<MapMode> mapList = <MapMode>[];
  String lolVersion = "";

  static const int NEXUS_ONE_SCREEN = 800;

  start() async {
    await readPersistedUser();
    await getLolVersion();
    await getChampionList();
    await getSummonerSpells();
    await getMapList();
    packageInfo = await PackageInfo.fromPlatform();
   Get.offAllNamed(Routes.MASTER);
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

  getCurrentUserOnCloud(String userName, String region) async {
    userCurrentGame.value = await _masterRepository.getUserOnCloud(userName, region);
  }

  getUserProfileOnCloud(String userName, String region) async {
    userProfile.value = await _masterRepository.getUserOnCloud(userName, region);
    if(userProfile.value.id.isNotEmpty){
      saveUserProfile(region);
    }
  }

  saveUserProfile(String region){
    this.userProfile.value.region = region;
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