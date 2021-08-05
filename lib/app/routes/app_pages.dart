import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:legends_panel/app/routes/app_routes.dart';
import 'package:legends_panel/app/ui/android/pages/home_page/home_page.dart';
import 'package:legends_panel/app/ui/android/pages/master_page/master_page.dart';
import 'package:legends_panel/app/ui/android/pages/splashscreen_page/splashscreen.dart';
import 'package:legends_panel/app/ui/android/sub_pages/profile_result_sub_page.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.MASTER, page: ()=> MasterPage()),
    GetPage(name: Routes.SPLASHSCREEN, page: ()=> SplashScreen()),
    GetPage(name: Routes.HOME, page: ()=> HomePage()),
    GetPage(name: Routes.PROFILE_SUB, page: ()=> ProfileResultSubPage()),
  ];
}