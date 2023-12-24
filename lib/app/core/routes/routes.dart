import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:legends_panel/app/core/routes/routes_path.dart';
import 'package:legends_panel/app/modules/about/presenter/about_page/about_page.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/menu_navigator/menu_navigator_container.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/splashscreen_page/splashscreen.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_page/current_game_page.dart';
import 'package:legends_panel/app/modules/profile/presenter/profile_page/profile_page.dart';

class Routes {
  final GoRouter goRouter;

  Routes() : goRouter = _router;

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter get _router => GoRouter(
        initialLocation: RoutesPath.SPLASHSCREEN,
        navigatorKey: _rootNavigatorKey,
        routes: [
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state, child) {
              return NoTransitionPage(
                child: MenuNavigatorContainer(
                  location: state.uri.toString(),
                  child: child,
                ),
              );
            },
            routes: [
              GoRoute(
                parentNavigatorKey: _shellNavigatorKey,
                path: RoutesPath.CURRENT_GAME_PAGE,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: CurrentGamePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: _shellNavigatorKey,
                path: RoutesPath.PROFILE_PAGE,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: ProfilePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: _shellNavigatorKey,
                path: RoutesPath.ABOUT_PAGE,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: AboutPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: RoutesPath.SPLASHSCREEN,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: SplashScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
          ),
        ],
      );
}
