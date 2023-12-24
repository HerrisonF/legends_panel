import 'package:legends_panel/app/modules/app_initialization/domain/usecases/game_constants_usecase/fetch_game_constants_usecase.dart';

class SplashscreenController {
  late FetchGameConstantsUsecase fetchGameConstantsUsecase;
  late Function callback;

  SplashscreenController({
    required this.callback,
    required this.fetchGameConstantsUsecase,
  }) {
    fetchGames();
  }

  /// Carga das principais constantes usadas na aplicação.
  fetchGames() async {
    await fetchGameConstantsUsecase();
    callback();
  }
}
