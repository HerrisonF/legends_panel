import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:legends_panel/app/ui/theme/app_theme.dart';

abstract class MasterController extends GetxController {

  GetStorage box = GetStorage('default_storage');

  RxString txtThemeButtom = "TEXT_BT_THEME_DARK".obs;

  @override
  void onInit() {
    txtThemeButtom.value = Get.isDarkMode ? "TEXT_BT_THEME_LIGHT" : "TEXT_BT_THEME_DARK";
    super.onInit();
  }

  void changeTheme(){
    if(Get.isDarkMode){
      box.write("theme", "light");
      txtThemeButtom.value = "TEXT_BT_THEME_DARK";
      Get.changeTheme(appDarkTheme);
    }else{
      box.write("theme", "dark");
      txtThemeButtom.value = "TEXT_BT_THEME_LIGHT";
      Get.changeTheme(appLightTheme);
    }
  }

}