import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:legends_panel/app/layers/presentation/ui/pages/splashscreen_page/splashscreen.dart';
import 'package:legends_panel/app/routes/app_routes.dart';
import 'package:legends_panel/app/ui/android/pages/about_page/about_page.dart';
import 'package:legends_panel/app/ui/android/pages/current_game_page/current_game_page.dart';
import 'package:legends_panel/app/ui/android/pages/master_page/master_page.dart';
import 'package:legends_panel/app/ui/android/pages/current_game_page/current_game_result_page.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.MASTER, page: ()=> MasterPage()),
    GetPage(name: Routes.SPLASHSCREEN, page: ()=> SplashScreen()),
    GetPage(name: Routes.HOME, page: ()=> CurrentGamePage()),
    GetPage(name: Routes.PROFILE_SUB, page: ()=> CurrentGameResultPage()),
    GetPage(name: Routes.ABOUT, page: ()=> AboutPage()),
  ];
}