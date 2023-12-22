import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/core/http_configuration/http_services_impl.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/core/logger/logger_impl.dart';
import 'package:legends_panel/app/core/routes/routes.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/master_page/master_controller.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/master_page/queues_controller.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_controller/current_game_controller.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_controller/current_game_participant_controller.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_controller/current_game_result_controller.dart';
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

    GetIt.I.registerSingletonAsync<SharedPreferences>(() async {
      return await SharedPreferences.getInstance();
    });

    getIt.registerSingleton<Routes>(Routes());

    getIt.registerSingleton<QueuesController>(
      QueuesController(),
    );

    getIt.registerSingleton<MasterController>(
      MasterController(),
    );

    getIt.registerLazySingleton<CurrentGameController>(
      () => CurrentGameController(),
    );

    // getIt.registerLazySingleton<ProfileController>(
    //   () => ProfileController(),
    // );

    getIt.registerLazySingleton<CurrentGameResultController>(
        () => CurrentGameResultController());

    getIt.registerLazySingleton<CurrentGameParticipantController>(
      () => CurrentGameParticipantController(),
    );

    await GetIt.I.allReady();
  }
}
