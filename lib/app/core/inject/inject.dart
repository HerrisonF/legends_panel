import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/core/http_configuration/http_services_impl.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/core/logger/logger_impl.dart';
import 'package:legends_panel/app/core/routes/routes.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/modules/app_initialization/data/repositories/lol_version/lol_version_repository_impl.dart';
import 'package:legends_panel/app/modules/app_initialization/data/repositories/queue/queues_repository.dart';
import 'package:legends_panel/app/modules/app_initialization/data/repositories/queue/queues_repository_impl.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/usecases/lol_version/get_lol_version/get_lol_version_usecase.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/usecases/lol_version/get_lol_version/get_lol_version_usecase_imp.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/usecases/queue/get_queues_usecase.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/usecases/queue/get_queues_usecase_imp.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/master_page/lol_version_controller.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/master_page/master_controller.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/master_page/queues_controller.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/splashscreen_page/splashscreen_controller.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_controller/current_game_controller.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_controller/current_game_participant_controller.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_controller/current_game_result_controller.dart';
import 'package:legends_panel/app/modules/profile/presenter/profile_controller/profile_controller.dart';

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

    getIt.registerSingleton<GetLolVersionRepositoryImpl>(
      GetLolVersionRepositoryImpl(httpServices: getIt()),
    );
    getIt.registerSingleton<QueuesRepository>(
      QueuesRepositoryImpl(httpServices: getIt()),
    );

    getIt.registerSingleton<GetLolVersionUseCase>(
      GetLolVersionUseCaseImp(getLolVersionRepository: getIt()),
    );
    getIt.registerSingleton<LolVersionController>(
      LolVersionController(getLolVersionUseCase: getIt()),
    );

    getIt.registerSingleton<GetQueuesUseCase>(
      GetQueuesUseCaseImp(
        queuesRepository: getIt(),
      ),
    );
    getIt.registerSingleton<QueuesController>(
      QueuesController(getIt()),
    );

    getIt.registerSingleton<MasterController>(
      MasterController(),
    );

    getIt.registerLazySingleton<SplashscreenController>(
      () => SplashscreenController(),
    );

    getIt.registerLazySingleton<CurrentGameController>(
      () => CurrentGameController(),
    );

    getIt.registerLazySingleton<ProfileController>(
      () => ProfileController(),
    );

    getIt.registerLazySingleton<CurrentGameResultController>(
        () => CurrentGameResultController());

    getIt.registerLazySingleton<CurrentGameParticipantController>(
      () => CurrentGameParticipantController(),
    );
  }
}
