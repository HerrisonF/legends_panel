import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/general_controller/general_controller.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/usecases/game_constants_usecase/fetch_game_constants_usecase.dart';

class SplashscreenController {
  late FetchGameConstantsUsecase fetchGameConstantsUsecase;
  late Function callback;
  late GeneralController generalController;


  SplashscreenController({
    required this.callback,
    required this.fetchGameConstantsUsecase,
    required this.generalController,
  }) {
    fetchGames();
  }

  /// Carga das principais constantes usadas na aplicação.
  fetchGames() async {
    final result = await fetchGameConstantsUsecase();
    result.fold((l) => id, (r) {
      generalController.setLolConstants(r);
      callback(r);
    });
  }
}
