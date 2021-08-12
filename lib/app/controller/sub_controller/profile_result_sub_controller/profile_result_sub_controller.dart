import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/util_controller/util_controller.dart';
import 'package:legends_panel/app/data/model/champion.dart';
import 'package:legends_panel/app/data/model/mapMode.dart';
import 'package:legends_panel/app/data/model/spectator/participant.dart';
import 'package:legends_panel/app/data/model/spectator/spectator.dart';
import 'package:legends_panel/app/data/model/spectator/summoner_spell.dart';
import 'package:legends_panel/app/data/model/user.dart';
import 'package:legends_panel/app/data/repository/sub_profile_result_repository.dart';

class ProfileResultSubController extends UtilController {

  Rx<User> user = User().obs;
  Rx<Spectator> spectator = Spectator().obs;
  Rx<MapMode> mapMode = MapMode().obs;
  RxList<Participant> blueTeam = RxList<Participant>();
  RxList<Participant> redTeam = RxList<Participant>();

  SubProfileResultRepository _subProfileResultRepository = SubProfileResultRepository();

  MasterController _masterController = Get.find<MasterController>();

  Future<bool> existCurrentGame(User user) async {
    _clearOldSearch();
    spectator.value = await _subProfileResultRepository.fetchCurrentGame(user.id);
    return spectator.value.participants.length > 0;
  }

  _clearOldSearch(){
    blueTeam.clear();
    redTeam.clear();
  }

  setUser(User user){
    this.user(user);
  }

  detachParticipantsIntoTeams(){
    for(int i = 0; i < 10; i++){
      Participant participant = spectator.value.participants[i];
      if(participant.teamId == 100){
        blueTeam.add(participant);
      }else{
        redTeam.add(participant);
      }
    }
  }

  String minutes(){
    int minutes = (spectator.value.gameLength / 60).truncate();
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    return minutesStr;
  }

  String getChampionBadgeUrl(String championId){
    Champion champion = _masterController.getChampionById(championId);
    return _subProfileResultRepository.getChampionBadgeUrl(champion.detail.id, _masterController.lolVersion.value);
  }

  String getSpellUrl(String spellId){
    Spell spell = _masterController.getSpellById(spellId);
    return _subProfileResultRepository.getSpellBadgeUrl(spell.id, _masterController.lolVersion.value);
  }

  setMapMode(MapMode mapMode){
    this.mapMode(mapMode);
  }

  getMap(){
    setMapMode(_masterController.getMap(spectator.value.mapId));
  }
}
