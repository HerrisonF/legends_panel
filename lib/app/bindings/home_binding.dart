import 'package:get/get.dart';
import 'package:legends_panel/app/controller/home_controller/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}