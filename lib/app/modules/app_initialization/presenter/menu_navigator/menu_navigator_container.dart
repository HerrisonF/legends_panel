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
  MenuNavigatorController menuNavigatorController = MenuNavigatorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
        child: ValueListenableBuilder(
          valueListenable: menuNavigatorController.currentPageIndex,
          builder: (context, index, _) {
            return BottomAppBar(
              child: Row(
                children: [
                  MenuTabIconWidget(
                    activeColor: index == 0
                        ? Colors.black
                        : Colors.grey,
                    icon: Icons.home_outlined,
                    onTapMenuItem: () => menuNavigatorController.navigateToPage(
                      context,
                      RoutesPath.currentGamePageIndex,
                      RoutesPath.CURRENT_GAME_PAGE,
                    ),
                  ),
                  MenuTabIconWidget(
                    activeColor: index == RoutesPath.profilePageIndex
                        ? Colors.black
                        : Colors.grey,
                    icon: Icons.directions_bus,
                    onTapMenuItem: () => menuNavigatorController.navigateToPage(
                      context,
                      RoutesPath.profilePageIndex,
                      RoutesPath.PROFILE_PAGE,
                    ),
                  ),
                  MenuTabIconWidget(
                    activeColor: index == RoutesPath.aboutPageIndex
                        ? Colors.black
                        : Colors.grey,
                    icon: Icons.settings,
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
