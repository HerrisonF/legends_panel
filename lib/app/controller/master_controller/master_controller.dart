import 'package:get/get.dart';
import 'package:legends_panel/app/model/general/champion_room.dart';
import 'package:legends_panel/app/model/general/lol_version.dart';
import 'package:legends_panel/app/model/general/map_room.dart';
import 'package:legends_panel/app/model/general/spell_room.dart';
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
  Rx<LolVersion> lolVersion = LolVersion().obs;
  Rx<ChampionRoom> championRoom = ChampionRoom().obs;
  Rx<SpellRoom> spellRoom = SpellRoom().obs;
  Rx<MapRoom> mapRoom = MapRoom().obs;

  static const int NEXUS_ONE_SCREEN = 800;

  start() async {
    await readPersistedUser();
    await getLolVersion();
    await getChampionRoom();
    await getSummonerSpellsRoom();
    await getMapRoom();
    packageInfo = await PackageInfo.fromPlatform();
    Get.offAllNamed(Routes.MASTER);
  }

  readPersistedUser() async {
    userProfile.value = await _masterRepository.readPersistedUserProfile();
  }

  getLolVersion() async {
    lolVersion.value = await _masterRepository.getLOLVersionOnLocal();
    if(!isLolVersionStored() || lolVersion.value.needToLoadVersionFromWeb()){
      await getLolVersionOnWeb();
    }
    lolVersion.refresh();
  }

  bool isLolVersionStored(){
    return lolVersion.value.actualVersion.isNotEmpty;
  }

  getLolVersionOnWeb() async {
    lolVersion.value.versions.addAll(await _masterRepository.getLOLVersionOnWeb());
    lolVersion.value.actualVersion = lolVersion.value.versions.first;
    _masterRepository.saveLolVersion(lolVersion.value.toJson());
  }

  getChampionRoom() async {
    championRoom.value = await _masterRepository.getChampionRoomOnLocal();
    if(!isChampionRoomStored() || championRoom.value.needToLoadVersionFromWeb()){
      await getChampionRoomOnWeb();
    }
    championRoom.refresh();
  }

  bool isChampionRoomStored(){
    return championRoom.value.lastDate.isNotEmpty;
  }

  getChampionRoomOnWeb() async {
    championRoom.value = await _masterRepository.getChampionRoomOnWeb(lolVersion.value.actualVersion);
    _masterRepository.saveChampionRoom(championRoom.value.toJson());
  }

  getSummonerSpellsRoom() async {
    spellRoom.value = await _masterRepository.getSpellRoomOnLocal();
    if(!isSpellRoomStored() || spellRoom.value.needToLoadVersionFromWeb()){
      await getSpellRoomOnWeb();
    }
    spellRoom.refresh();
  }

  bool isSpellRoomStored(){
    return spellRoom.value.lastDate.isNotEmpty;
  }

  getSpellRoomOnWeb() async {
    spellRoom.value = await _masterRepository.getSpellRoomOnWeb(lolVersion.value.actualVersion);
    _masterRepository.saveSpellRoom(spellRoom.value.toJson());
  }

  getMapRoom() async {
    mapRoom.value = await _masterRepository.getMapRoomOnLocal();
    if(!isMapRoomStored() || mapRoom.value.needToLoadVersionFromWeb()){
      await getMapRoomOnWeb();
    }
    mapRoom.refresh();
  }

  isMapRoomStored(){
    return mapRoom.value.lastDate.isNotEmpty;
  }

  getMapRoomOnWeb() async {
    mapRoom.value = await _masterRepository.getMapRoomOnWeb();
    _masterRepository.saveMapRoom(mapRoom.value.toJson());
  }

  changeCurrentPageIndex(int newPageIndex){
    currentPageIndex(newPageIndex);
  }

  getChampionById(String championId){
    return championRoom.value.champions.where((champ) => champ.detail.key.toString() == championId).first;
  }

  getSpellById(String spellId){
    return spellRoom.value.summonerSpell.spells.where((spell) => spell.key.toString() == spellId).first;
  }


  getMapById(String mapId){
    return mapRoom.value.maps.where((map) => map.mapId.toString() == mapId).first;
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