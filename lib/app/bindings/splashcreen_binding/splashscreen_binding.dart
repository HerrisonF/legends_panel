import 'package:get/get.dart';
import 'package:legends_panel/app/controller/splashscreen_controller/splashscreen_controller.dart';

class SplashscreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashscreenController>(() => SplashscreenController());
  }
}