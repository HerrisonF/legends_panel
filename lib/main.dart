import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legends_panel/app/core/constants/storage_keys.dart';
import 'package:legends_panel/app/core/routes/routes.dart';
import 'app/core/inject/inject.dart';

import 'l10n/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Inject.init();

  await GetStorage.init(StorageKeys.globalStorageKey);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [SystemUiOverlay.top],
  );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      routerConfig: GetIt.I<Routes>().goRouter,
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
