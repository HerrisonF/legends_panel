import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:legends_panel/app/bindings/home_binding.dart';
import 'package:legends_panel/app/routes/app_routes.dart';
import 'package:legends_panel/app/ui/android/pages/home_page/home_page.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.HOME, page: ()=> HomePage(), binding: HomeBinding()),
  ];
}