import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/home_controller/home_controller.dart';

class HomePage extends StatelessWidget {

  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("TITLE_HOME_PAGE".tr),
        ),
      ),
    );
  }

}
