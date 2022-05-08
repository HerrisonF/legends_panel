import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/core/data/services/dio_http_service_imp.dart';
import 'package:legends_panel/app/core/utils/package_info_utils.dart';
import 'package:legends_panel/app/decorators/lol_version_decorator/lol_version_cache_repository_decorator.dart';
import 'package:legends_panel/app/layers/data/datasources/contracts/queue_datasources/get_queues_datasource.dart';
import 'package:legends_panel/app/layers/data/datasources/remote_imp/queues/get_queues_remote_datasource_imp.dart';
import 'package:legends_panel/app/layers/data/repositories/lol_version_repositories/get_lol_version_repository_imp.dart';
import 'package:legends_panel/app/layers/data/repositories/queue_repositories/get_queue_repository_imp.dart';
import 'package:legends_panel/app/layers/domain/repositories/lol_version/get_lol_version_repository.dart';
import 'package:legends_panel/app/core/domain/services/http_services.dart';
import 'package:legends_panel/app/layers/domain/repositories/queue/get_queues_repository.dart';
import 'package:legends_panel/app/layers/domain/usecases/queue/get_queues_usecase.dart';
import 'package:legends_panel/app/layers/domain/usecases/queue/get_queues_usecase_imp.dart';
import 'package:logging/logging.dart';

import '../../decorators/queues_decorator/queues_cache_repository_decorator.dart';
import '../../layers/data/datasources/contracts/lol_version_datasources/get_lol_version_datasource.dart';
import '../../layers/data/datasources/remote_imp/lol_version/get_lol_version_remote_datasource_imp.dart';
import '../../layers/domain/usecases/lol_version/get_lol_version/get_lol_version_usecase.dart';
import '../../layers/domain/usecases/lol_version/get_lol_version/get_lol_version_usecase_imp.dart';
import '../../layers/presentation/controllers/lol_version_controller.dart';
import '../../layers/presentation/controllers/queues_controller.dart';

class Inject {
  static void init() {
    GetIt getIt = GetIt.instance;

    /// core
    getIt.registerLazySingleton<HttpService>(() => DioHttpServiceImp());
    getIt.registerLazySingleton<PackageInfoUtils>(() => PackageInfoUtils());

    ///DataSources
    ///LOL VERSION
    getIt.registerLazySingleton<GetLolVersionDataSource>(
      () => GetLolVersionRemoteDataSourceImp(getIt()),
    );

    ///QUEUES
    getIt.registerLazySingleton<GetQueuesDataSource>(
      () => GetQueuesRemoteDataSourceImp(getIt()),
    );

    ///Repositories
    ///LOL VERSION
    getIt.registerLazySingleton<GetLolVersionRepository>(
      () => LolVersionCacheRepositoryDecorator(
        GetLolVersionRepositoryImp(getIt()),
      ),
    );

    ///QUEUES
    getIt.registerLazySingleton<GetQueuesRepository>(
      () => QueuesCacheRepositoryDecorator(
        GetQueuesRepositoryImp(getIt()),
      ),
    );

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

    ///QUEUES
    getIt.registerLazySingleton<QueuesController>(
      () => QueuesController(getIt()),
    );

    /// Application logger
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }
}
