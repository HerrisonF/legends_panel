import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/util_controller/util_controller.dart';
import 'package:legends_panel/app/data/repository/initial_repository.dart';
import 'package:legends_panel/app/routes/app_routes.dart';

class SplashscreenController extends UtilController {

  final InitialRepository _initialRepository = InitialRepository();
  final MasterController _masterController = Get.put(MasterController());

  start() async {
    await _masterController.setLoLVersion(await _initialRepository.getLOLVersion());
    await _masterController.setChampionList(await _initialRepository.getChampionList(_masterController.lolVersion.value));
    Get.offAllNamed(Routes.MASTER);
  }

}