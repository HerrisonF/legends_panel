import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/core/http_configuration/http_services_impl.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/core/logger/logger_impl.dart';
import 'package:legends_panel/app/core/routes/routes.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/layers/domain/usecases/queue/get_queues_usecase.dart';
import 'package:legends_panel/app/layers/domain/usecases/queue/get_queues_usecase_imp.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/master_page/master_controller/master_controller.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/splashscreen_page/splashscreen_controller.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_controller/current_game_controller.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_controller/current_game_participant_controller.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_controller/current_game_result_controller.dart';
import 'package:legends_panel/app/modules/profile/presenter/profile_controller/profile_controller.dart';

import '../../layers/domain/usecases/lol_version/get_lol_version/get_lol_version_usecase.dart';
import '../../layers/domain/usecases/lol_version/get_lol_version/get_lol_version_usecase_imp.dart';
import '../../layers/presentation/controllers/lol_version_controller.dart';
import '../../layers/presentation/controllers/queues_controller.dart';

class Inject {
  static void init() {
    GetIt getIt = GetIt.instance;

    /// core
    getIt.registerSingleton<Logger>(LoggerImpl());
    getIt.registerSingleton<HttpServices>(
      HttpServicesImp(
        logger: getIt(),
      ),
    );
    getIt.registerSingleton<Routes>(Routes());

    ///Usecases
    ///LOL VERSION
    getIt.registerLazySingleton<GetLolVersionUseCase>(
      () => GetLolVersionUseCaseImp(getIt()),
    );

    ///QUEUES
    getIt.registerLazySingleton<GetQueuesUseCase>(
      () => GetQueuesUseCaseImp(getIt()),
    );

    /// A factory sempre gera uma nova instância para mim

    /// Controllers
    /// LOL VERSION
    getIt.registerLazySingleton<LolVersionController>(
      () => LolVersionController(getIt()),
    );

    getIt.registerLazySingleton<CurrentGameController>(
      () => CurrentGameController(),
    );
    getIt.registerLazySingleton<MasterController>(
      () => MasterController(),
    );

    getIt.registerLazySingleton<ProfileController>(
      () => ProfileController(),
    );

    getIt.registerLazySingleton<CurrentGameResultController>(
        () => CurrentGameResultController());

    getIt.registerLazySingleton<SplashscreenController>(
      () => SplashscreenController(),
    );
    getIt.registerLazySingleton<CurrentGameParticipantController>(
      () => CurrentGameParticipantController(),
    );

    ///QUEUES
    getIt.registerLazySingleton<QueuesController>(
      () => QueuesController(getIt()),
    );
  }
}
