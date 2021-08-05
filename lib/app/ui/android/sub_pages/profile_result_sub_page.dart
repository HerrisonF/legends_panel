import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/sub_controller/profile_result_sub_page/profile_result_sub_controller.dart';

class ProfileResultSubPage extends StatelessWidget {
  final ProfileResultSubController _profileResultSubController =
      Get.find<ProfileResultSubController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Text(_profileResultSubController.user.value.name),
            ),
            Container(
              child: Placeholder(),
            ),
          ],
        ),
      ),
    );
  }
}
