import 'package:get/get.dart';
import 'package:legends_panel/app/controller/util_controller/util_controller.dart';
import 'package:legends_panel/app/routes/app_routes.dart';

class SplashscreenController extends UtilController {

  start() async {
    Future.delayed(Duration(seconds: 1)).then((value) {
      Get.offAllNamed(Routes.MASTER);
    });
  }

}