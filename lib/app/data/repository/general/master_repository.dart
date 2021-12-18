import 'package:legends_panel/app/model/general/champion_room.dart';
import 'package:legends_panel/app/model/general/lol_version.dart';
import 'package:legends_panel/app/model/general/map_room.dart';
import 'package:legends_panel/app/model/general/runesRoom.dart';
import 'package:legends_panel/app/model/general/spell_room.dart';
import 'package:legends_panel/app/model/general/stored_region.dart';
import 'package:legends_panel/app/model/general/user.dart';
import 'package:legends_panel/app/data/provider/general/master_provider.dart';

class MasterRepository {

  final MasterProvider _masterProvider = MasterProvider();

  Future<List<String>> getLOLVersionOnWeb() async {
    return _masterProvider.getLOLVersionOnWeb();
  }

  Future<LolVersion> getLOLVersionOnLocal() async {
    return _masterProvider.getLOLVersionOnLocal();
  }

  saveLolVersion(Map<String, dynamic> lolVersion){
    _masterProvider.saveLolVersion(lolVersion);
  }

  Future<ChampionRoom> getChampionRoomOnWeb(String version) async {
    return _masterProvider.getChampionRoomOnWeb(version);
  }

  Future<ChampionRoom> getChampionRoomOnLocal() async {
    return _masterProvider.getChampionRoomOnLocal();
  }

  saveChampionRoom(Map<String, dynamic> championRoom){
    _masterProvider.saveChampionRoom(championRoom);
  }

  Future<SpellRoom> getSpellRoomOnWeb(String version) {
    return _masterProvider.getSpellRoomOnWeb(version);
  }

  Future<SpellRoom> getSpellRoomOnLocal() {
    return _masterProvider.getSpellRoomOnLocal();
  }

  saveSpellRoom(Map<String, dynamic> spellRoom) {
    return _masterProvider.saveSpellRoom(spellRoom);
  }

  Future<MapRoom> getMapRoomOnWeb() async {
    return _masterProvider.getMapRoomOnWeb();
  }

  Future<MapRoom> getMapRoomOnLocal() {
    return _masterProvider.getMapRoomOnLocal();
  }

  saveMapRoom(Map<String, dynamic> mapRoom) {
    return _masterProvider.saveMapRoom(mapRoom);
  }

  Future<RunesRoom> getRunesRoomOnWeb(String version, String languageKey){
    return _masterProvider.getRunesRoomOnWeb(version, languageKey);
  }

  Future<RunesRoom> getRunesRoomOnLocal(){
    return _masterProvider.getRunesRoomOnLocal();
  }

  saveRunesRoom(Map<String, dynamic> runesRoom){
    return _masterProvider.saveRunesRoom(runesRoom);
  }

  Future<User> readPersistedUserProfile(){
    return _masterProvider.readPersistedUserProfile();
  }

  Future<User> getUserOnCloud(String userName, String keyRegion){
    return _masterProvider.getUserOnCloud(userName, keyRegion);
  }

  saveUserProfile(User user){
    _masterProvider.saveUserProfile(user);
  }

  deletePersistedUser(){
    _masterProvider.deletePersistedUser();
  }

  Future<StoredRegion> getLastStoredRegion(){
    return _masterProvider.getLastStoredRegion();
  }

  saveActualRegion(StoredRegion storedRegion) async {
    await _masterProvider.saveActualRegion(storedRegion);
  }

}