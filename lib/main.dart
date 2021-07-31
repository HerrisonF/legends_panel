import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:legends_panel/app/routes/app_pages.dart';
import 'package:legends_panel/app/routes/app_routes.dart';
import 'package:legends_panel/app/translations/app_translations.dart';
import 'package:legends_panel/app/ui/theme/app_theme.dart';
import 'dart:ui' as ui;

void main() async {
  await GetStorage.init('default_store');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final GetStorage box = GetStorage('default_store');

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Legends Panel',
      debugShowCheckedModeBanner: false,
      theme: box.read("theme") == "dark" ? appDarkTheme : appLightTheme,
      darkTheme: appDarkTheme,
      themeMode: ThemeMode.system,
      getPages: AppPages.routes,
      initialRoute: Routes.HOME,
      locale: ui.window.locale,
      translationsKeys: AppTranslation.translations,
    );
  }
}
