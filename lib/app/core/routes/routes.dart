import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:legends_panel/app/core/routes/routes_path.dart';
import 'package:legends_panel/app/modules/about/presenter/about_page/about_page.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/menu_navigator/menu_navigator_container.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/splashscreen_page/splashscreen.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_info_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/summoner_identification/summoner_profile_model.dart';
import 'package:legends_panel/app/modules/current_game/presenter/active_game/active_game_search_page.dart';
import 'package:legends_panel/app/modules/profile/presenter/profile_page/profile_page.dart';
import 'package:legends_panel/app/modules/profile/presenter/profile_page/profile_result_page/profile_result_page.dart';

import '../../modules/current_game/presenter/active_game/active_game_result/active_game_result_page.dart';

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
                path: RoutesPath.ACTIVE_GAME_SEARCH_PAGE,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: ActiveGameSearchPage(),
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
                path: RoutesPath.PROFILE_RESULT,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  SummonerProfileModel profile =
                      state.extra as SummonerProfileModel;

                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: ProfileResultPage(
                      summonerProfileModel: profile,
                    ),
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
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: RoutesPath.ACTIVE_GAME_RESULT,
            pageBuilder: (context, state) {
              ActiveGameInfoModel activeGameInfo =
                  state.extra as ActiveGameInfoModel;

              return CustomTransitionPage(
                key: state.pageKey,
                child: ActiveGameResultPage(
                  activeGameInfoModel: activeGameInfo,
                ),
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
