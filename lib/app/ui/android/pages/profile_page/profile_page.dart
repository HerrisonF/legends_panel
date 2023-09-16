import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/controller/profile_controller/profile_controller.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController _profileController = GetIt.I<ProfileController>();

  @override
  void initState() {
    _profileController.buildPages();
    _profileController.startProfileController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _profileController.currentProfilePage,
        builder: (context, value, _) {
          return _profileController.pages.elementAt(
            _profileController.currentProfilePage.value,
          );
        },
      ),
    );
  }
}
