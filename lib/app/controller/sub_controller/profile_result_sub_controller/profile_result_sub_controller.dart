import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/util_controller/util_controller.dart';
import 'package:legends_panel/app/data/model/mapMode.dart';
import 'package:legends_panel/app/data/model/spectator/banned_champion.dart';
import 'package:legends_panel/app/data/model/spectator/participant.dart';
import 'package:legends_panel/app/data/model/spectator/spectator.dart';
import 'package:legends_panel/app/data/model/user.dart';
import 'package:legends_panel/app/data/repository/sub_profile_result_repository.dart';

class ProfileResultSubController extends UtilController {

  Rx<User> user = User().obs;
  Rx<Spectator> spectator = Spectator().obs;
  Rx<MapMode> mapMode = MapMode().obs;
  RxList<Participant> blueTeam = RxList<Participant>();
  RxList<Participant> redTeam = RxList<Participant>();
  RxList<BannedChampion> blueTeamBannedChamp = RxList<BannedChampion>();
  RxList<BannedChampion> redTeamBannedChamp = RxList<BannedChampion>();

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
    blueTeamBannedChamp.clear();
    redTeamBannedChamp.clear();
  }

  setUser(User user){
    this.user(user);
  }

  detachParticipantsIntoTeams(){
    for(int i = 0; i < 10; i++){
      Participant participant = spectator.value.participants[i];
      BannedChampion bannedChampion = spectator.value.bannedChampions[i];
      if(participant.teamId == 100){
        blueTeam.add(participant);
        blueTeamBannedChamp.add(bannedChampion);
      }else{
        redTeam.add(participant);
        redTeamBannedChamp.add(bannedChampion);
      }
    }
  }

  String minutes(){
    int minutes = (spectator.value.gameLength / 60).truncate();
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    return minutesStr;
  }

  setMapMode(MapMode mapMode){
    this.mapMode(mapMode);
  }

  getMap(){
    setMapMode(_masterController.getMap(spectator.value.mapId));
  }
}
