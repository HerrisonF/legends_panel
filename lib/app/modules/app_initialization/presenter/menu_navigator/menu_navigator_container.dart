import 'package:flutter/material.dart';
import 'package:legends_panel/app/core/routes/routes_path.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/menu_navigator/menu_navigator_controller.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/menu_navigator/menu_tab_icon_widget.dart';

class MenuNavigatorContainer extends StatefulWidget {
  final String location;
  final Widget child;

  const MenuNavigatorContainer({
    Key? key,
    required this.child,
    required this.location,
  }) : super(key: key);

  @override
  State<MenuNavigatorContainer> createState() => _MenuNavigatorContainerState();
}

class _MenuNavigatorContainerState extends State<MenuNavigatorContainer> {
  late MenuNavigatorController menuNavigatorController;

  @override
  void initState() {
    menuNavigatorController = MenuNavigatorController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: ValueListenableBuilder(
          valueListenable: menuNavigatorController.currentPageIndex,
          builder: (context, index, _) {
            return BottomAppBar(
              child: Row(
                children: [
                  MenuTabIconWidget(
                    activeColor: index == RoutesPath.currentGamePageIndex
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                    icon: Icons.gamepad,
                    onTapMenuItem: () => menuNavigatorController.navigateToPage(
                      context,
                      RoutesPath.currentGamePageIndex,
                      RoutesPath.CURRENT_GAME_PAGE,
                    ),
                  ),
                  MenuTabIconWidget(
                    activeColor: index == RoutesPath.profilePageIndex
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                    icon: Icons.account_box,
                    onTapMenuItem: () => menuNavigatorController.navigateToPage(
                      context,
                      RoutesPath.profilePageIndex,
                      RoutesPath.PROFILE_PAGE,
                    ),
                  ),
                  MenuTabIconWidget(
                    activeColor: index == RoutesPath.aboutPageIndex
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                    icon: Icons.apps_sharp,
                    onTapMenuItem: () => menuNavigatorController.navigateToPage(
                      context,
                      RoutesPath.aboutPageIndex,
                      RoutesPath.ABOUT_PAGE,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
