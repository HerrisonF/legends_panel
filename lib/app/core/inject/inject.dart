import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/core/data/services/dio_http_service_imp.dart';
import 'package:legends_panel/app/core/utils/package_info_utils.dart';
import 'package:legends_panel/app/decorators/lol_version_cache_repository_decorator.dart';
import 'package:legends_panel/app/layers/data/datasources/get_lol_version_datasource.dart';
import 'package:legends_panel/app/layers/data/datasources/local/save_local_lol_version_datasource_imp.dart';
import 'package:legends_panel/app/layers/data/datasources/remote/get_lol_version_remote_datasource_imp.dart';
import 'package:legends_panel/app/layers/data/datasources/save_lol_version_datasource.dart';
import 'package:legends_panel/app/layers/data/repositories/get_lol_version_repository_imp.dart';
import 'package:legends_panel/app/layers/data/repositories/save_lol_version_repository_imp.dart';
import 'package:legends_panel/app/layers/domain/repositories/get_lol_version_repository.dart';
import 'package:legends_panel/app/layers/domain/repositories/save_lol_version_repository.dart';
import 'package:legends_panel/app/core/domain/services/http_services.dart';
import 'package:legends_panel/app/layers/domain/usecases/get_lol_version/get_lol_version_usecase.dart';
import 'package:legends_panel/app/layers/domain/usecases/get_lol_version/get_lol_version_usecase_imp.dart';
import 'package:legends_panel/app/layers/domain/usecases/save_lol_version/save_lol_version_usecase.dart';
import 'package:legends_panel/app/layers/domain/usecases/save_lol_version/save_lol_version_usecase_imp.dart';
import 'package:legends_panel/app/layers/presentation/controller/lol_version_controller.dart';
import 'package:logging/logging.dart';

class Inject {
  static void init() {
    GetIt getIt = GetIt.instance;

    /// core
    getIt.registerLazySingleton<HttpService>(() => DioHttpServiceImp());
    getIt.registerLazySingleton<PackageInfoUtils>(() => PackageInfoUtils());

    ///DataSources
    getIt.registerLazySingleton<GetLolVersionDataSource>(
      () => GetLolVersionRemoteDataSourceImp(getIt()),
    );
    getIt.registerLazySingleton<SaveLolVersionDataSource>(
      () => SaveLocalLolVersionDataSourceImp(),
    );

    ///Repositories
    getIt.registerLazySingleton<GetLolVersionRepository>(
      () => LolVersionCacheRepositoryDecorator(
        GetLolVersionRepositoryImp(getIt()),
      ),
    );
    getIt.registerLazySingleton<SaveLolVersionRepository>(
      () => SaveLolVersionRepositoryImp(getIt()),
    );

    ///Usecases
    getIt.registerLazySingleton<GetLolVersionUseCase>(
      () => GetLolVersionUseCaseImp(getIt()),
    );
    getIt.registerLazySingleton<SaveLolVersionUseCase>(
      () => SaveLolVersionUseCaseImp(getIt()),
    );

    /// A factory sempre gera uma nova instância para mim

    /// Controllers
    getIt.registerLazySingleton<LolVersionController>(
      () => LolVersionController(getIt()),
    );

    /// Application logger
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }
}
