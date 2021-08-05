import 'package:get/get.dart';
import 'package:legends_panel/app/controller/util_controller/util_controller.dart';
import 'package:legends_panel/app/data/model/user.dart';
import 'package:legends_panel/app/data/repository/sub_profile_result_repository.dart';

class ProfileResultSubController extends UtilController {

  Rx<User> user = User().obs;

  SubProfileResultRepository _subProfileResultRepository = SubProfileResultRepository();

  setUser(User user){
    this.user.value = user;
    _getCurrentGame();
  }

  _getCurrentGame(){
    _subProfileResultRepository.fetchCurrentGame(user.value.id);
  }

}
