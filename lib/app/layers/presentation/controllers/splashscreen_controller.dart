import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';

import '../util_controllers/util_controller.dart';

class SplashscreenController extends UtilController {
  final MasterController _masterController =
      GetIt.I<MasterController>();

  start(BuildContext context) async {
    _masterController.initialize(context);
  }
}
