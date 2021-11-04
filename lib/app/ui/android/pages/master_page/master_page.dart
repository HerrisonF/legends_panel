import 'package:flutter/material.dart';
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
        body: IndexedStack(
          index: _masterController.currentPageIndex.value,
          children: [
            CurrentGamePage(),
            ProfilePage(),
            AboutPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xFF4248A5),
          unselectedItemColor: Color(0xFF292E78).withOpacity(0.3),
          backgroundColor: Colors.white,
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
        icon: Container(
          margin: EdgeInsets.only(top: 10),
          child: Icon(Icons.assignment_ind_outlined),
        ),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: Container(
            margin: EdgeInsets.only(top: 10),
            child: Icon(Icons.perm_identity_rounded)),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: Container(
            margin: EdgeInsets.only(top: 10),
            child: Icon(Icons.account_balance_outlined)),
        label: "",
      ),
    ];
  }
}
