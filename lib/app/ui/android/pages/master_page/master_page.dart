import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/ui/android/pages/current_game_page/current_game_page.dart';
import 'package:legends_panel/app/ui/android/pages/profile_page/profile_page.dart';

class MasterPage extends StatelessWidget {

  final MasterController _masterController = Get.find<MasterController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: _masterController.currentPageIndex.value,
          children: [
            CurrentGamePage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).primaryColor.withOpacity(0.4),
          backgroundColor: Theme.of(context).backgroundColor,
          currentIndex: _masterController.currentPageIndex.value,
          onTap: _masterController.changeCurrentPageIndex,
          items: bottomNavigatorItems(),
        ),
      ),
    );
  }

  bottomNavigatorItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.assignment_ind_outlined),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.perm_identity_rounded),
        label: "",
      ),
    ];
  }
}
