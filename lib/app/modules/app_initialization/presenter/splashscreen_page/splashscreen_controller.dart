import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/usecases/game_constants_usecase/fetch_game_constants_usecase.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/master_page/master_controller.dart';

class SplashscreenController {
  late FetchGameConstantsUsecase fetchGameConstantsUsecase;
  final MasterController _masterController = GetIt.I<MasterController>();

  late Function callback;

  /// Carga das principais constantes usadas na aplicação.

  SplashscreenController({
    required this.callback,
    required this.fetchGameConstantsUsecase,
  }) {
    fetchGames();
  }

  fetchGames() async {
    await fetchGameConstantsUsecase();
    _masterController.initialize().then(
          (value) => callback(),
    );
  }
}
