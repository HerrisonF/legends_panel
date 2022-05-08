import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';

import '../util_controllers/util_controller.dart';

class SplashscreenController extends UtilController {
  final MasterController _masterController =
      Get.put(MasterController(), permanent: true);

  start() async {
    _masterController.initialize();
  }
}
