import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/profile_controller/profile_controller.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController _profileController =
      Get.put(ProfileController(), permanent: true);

  @override
  void initState() {
    _profileController.buildPages();
    _profileController.startProfileController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return _profileController.pages
            .elementAt(_profileController.currentProfilePage.value);
      }),
    );
  }
}
