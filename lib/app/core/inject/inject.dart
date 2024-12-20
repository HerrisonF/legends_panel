import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/core/general_controller/general_controller.dart';
import 'package:legends_panel/app/core/general_controller/general_repository.dart';
import 'package:legends_panel/app/core/http_configuration/http_services_impl.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/core/logger/logger_impl.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/routes/routes.dart';
import 'package:legends_panel/app/modules/current_game/data/repositories/active_game_result_repository/active_game_result_repository.dart';
import 'package:legends_panel/app/modules/current_game/data/repositories/active_game_result_repository/active_game_result_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Inject {
  static Future<void> init() async {
    GetIt getIt = GetIt.instance;

    /// core
    getIt.registerSingleton<Logger>(LoggerImpl());
    getIt.registerSingleton<HttpServices>(
      HttpServicesImp(
        logger: getIt(),
      ),
    );
    getIt.registerLazySingleton<Routes>(() => Routes());

    GetIt.I.registerSingletonAsync<SharedPreferences>(() async {
      return await SharedPreferences.getInstance();
    });

    GetIt.I.registerLazySingleton<GeneralRepository>(
      () => GeneralRepository(httpServices: getIt()),
    );

    GetIt.I.registerLazySingleton<GeneralController>(
      () => GeneralController(generalRepository: getIt()),
    );

    GetIt.I.registerLazySingleton<ActiveGameResultRepository>(
          () => ActiveGameResultRepositoryImpl(),
    );

    ///

    await GetIt.I.allReady();
  }
}
