import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/routes/app_routes.dart';

class SplashscreenController extends MasterController {

  start() async {
    Future.delayed(Duration(seconds: 1)).then((value) {
      Get.offAllNamed(Routes.HOME);
    });
  }

}