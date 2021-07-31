import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

abstract class MasterController extends GetxController {

  GetStorage box = GetStorage('default_storage');

}