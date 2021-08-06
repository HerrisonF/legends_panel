import 'package:get/get.dart';
import 'package:legends_panel/app/controller/util_controller/util_controller.dart';
import 'package:legends_panel/app/data/model/spectator/participant.dart';
import 'package:legends_panel/app/data/model/spectator/spectator.dart';
import 'package:legends_panel/app/data/model/user.dart';
import 'package:legends_panel/app/data/repository/sub_profile_result_repository.dart';

class ProfileResultSubController extends UtilController {

  Rx<User> user = User().obs;
  Rx<Spectator> spectator = Spectator().obs;
  RxList<Participant> blueTeam = RxList<Participant>();
  RxList<Participant> redTeam = RxList<Participant>();

  SubProfileResultRepository _subProfileResultRepository = SubProfileResultRepository();

  setUser(User user){
    this.user.value = user;
    _getCurrentGame();
  }

  _getCurrentGame() async {
    _clearOldSearch();
    spectator.value = await _subProfileResultRepository.fetchCurrentGame(user.value.id);
    _detachParticipantsIntoTeams();
  }

  _clearOldSearch(){
    blueTeam.clear();
    redTeam.clear();
  }

  _detachParticipantsIntoTeams(){
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

}
