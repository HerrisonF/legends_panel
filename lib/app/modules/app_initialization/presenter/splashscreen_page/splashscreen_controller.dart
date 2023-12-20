import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/master_page/master_controller/master_controller.dart';

import '../../../../layers/presentation/util_controllers/util_controller.dart';

class SplashscreenController extends UtilController {
  final MasterController _masterController =
      GetIt.I<MasterController>();

  start(BuildContext context) async {
    _masterController.initialize(context);
  }
}
