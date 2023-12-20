import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:legends_panel/app/core/routes/routes_path.dart';
import 'package:legends_panel/app/modules/about/presenter/about_page/about_page.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/master_page/master_page.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/splashscreen_page/splashscreen.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_page/current_game_page.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_page/current_game_result_page.dart';

class Routes {
  final GoRouter goRouter;

  Routes() : goRouter = _router;

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter get _router => GoRouter(
        initialLocation: RoutesPath.SPLASHSCREEN,
        navigatorKey: _rootNavigatorKey,
        routes: <RouteBase>[
          GoRoute(
            path: RoutesPath.SPLASHSCREEN,
            builder: (BuildContext _, GoRouterState state) {
              return SplashScreen();
            },
          ),
          GoRoute(
            path: RoutesPath.MASTER,
            builder: (BuildContext context, GoRouterState state) {
              return MasterPage();
            },
          ),
          GoRoute(
            path: RoutesPath.HOME,
            builder: (BuildContext context, GoRouterState state) {
              return CurrentGamePage();
            },
          ),
          GoRoute(
            path: RoutesPath.PROFILE_SUB,
            builder: (BuildContext context, GoRouterState state) {
              return CurrentGameResultPage();
            },
          ),
          GoRoute(
            path: RoutesPath.ABOUT,
            builder: (BuildContext context, GoRouterState state) {
              return AboutPage();
            },
          ),
        ],
      );
}
