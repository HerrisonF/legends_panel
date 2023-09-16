import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/core/utils/screen_utils.dart';
import 'package:legends_panel/app/ui/android/pages/about_page/about_page.dart';
import 'package:legends_panel/app/ui/android/pages/current_game_page/current_game_page.dart';
import 'package:legends_panel/app/ui/android/pages/profile_page/profile_page.dart';

class MasterPage extends StatelessWidget {
  final MasterController _masterController = GetIt.I<MasterController>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _masterController.currentPageIndex,
      builder: (context, value, _) {
        return Scaffold(
          body: Stack(
            children: [
              IndexedStack(
                index: _masterController.currentPageIndex.value,
                children: [
                  CurrentGamePage(),
                  ProfilePage(),
                  AboutPage(),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: ScreenUtils.screenWidthSizeIsBiggerThanNexusOne()
                        ? 10
                        : 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customIconButton(context, 0, FeatherIcons.crosshair),
                      customIconButton(context, 1, FeatherIcons.user),
                      customIconButton(context, 2, FeatherIcons.box),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  customIconButton(BuildContext context, int selectedIcon, IconData icon) {
    return IconButton(
      onPressed: () {
        _masterController.changeCurrentPageIndex(selectedIcon, context);
      },
      icon: Icon(
        icon,
        color: _masterController.currentPageIndex.value == selectedIcon
            ? Color(0xFF4248A5)
            : Color(0xFF292E78).withOpacity(0.3),
        size: ScreenUtils.screenWidthSizeIsBiggerThanNexusOne() ? 22 : 14,
      ),
    );
  }
}
