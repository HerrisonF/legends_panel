import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/ui/android/pages/about_page/about_page.dart';
import 'package:legends_panel/app/ui/android/pages/current_game_page/current_game_page.dart';
import 'package:legends_panel/app/ui/android/pages/profile_page/profile_page.dart';

class MasterPage extends StatelessWidget {
  final MasterController _masterController = Get.find<MasterController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: _masterController.currentPageIndex.value,
                children: [
                  CurrentGamePage(),
                  ProfilePage(),
                  AboutPage(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 15,
                right: MediaQuery.of(context).size.width / 15,
                bottom: MediaQuery.of(context).size.height > NEXUS_ONE_SCREEN ? 20 : 5
              ),
              color: Colors.white,
              height: MediaQuery.of(context).size.height / 11,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customIconButton(context, 0, FeatherIcons.crosshair),
                  customIconButton(context, 1, FeatherIcons.user),
                  customIconButton(context, 2, FeatherIcons.coffee),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  static const int NEXUS_ONE_SCREEN = 800;
  customIconButton(BuildContext context, int indexPage, IconData icon) {
    return Container(
      child: IconButton(
        onPressed: () {
          _masterController.changeCurrentPageIndex(indexPage);
        },
        icon: Icon(
          icon,
          color: _masterController.currentPageIndex.value == indexPage
              ? Color(0xFF4248A5)
              : Color(0xFF292E78).withOpacity(0.3),
          size:  MediaQuery.of(context).size.height > NEXUS_ONE_SCREEN ? 22 : 16,
        ),
      ),
    );
  }
}
