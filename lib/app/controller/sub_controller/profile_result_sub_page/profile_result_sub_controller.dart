import 'package:get/get.dart';
import 'package:legends_panel/app/controller/util_controller/util_controller.dart';
import 'package:legends_panel/app/data/model/user.dart';

class ProfileResultSubController extends UtilController {

  Rx<User> user = User().obs;

  setUser(User user){
    this.user.value = user;
  }

}
