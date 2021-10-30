import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/util_controller/util_controller.dart';
import 'package:legends_panel/app/routes/app_routes.dart';

class SplashscreenController extends UtilController {

  final MasterController _masterController = Get.put(MasterController(), permanent: true);

  start() async {
     _masterController.start();
  }

}