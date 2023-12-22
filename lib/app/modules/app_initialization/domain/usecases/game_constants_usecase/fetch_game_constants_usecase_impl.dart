import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/modules/app_initialization/data/repositories/splash_repository/splash_repository.dart';
import 'package:legends_panel/app/modules/app_initialization/data/repositories/splash_repository/splash_repository_local.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/champion_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/game_mode_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/item_mother_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/lol_constants_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/mapa_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/queue_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/usecases/game_constants_usecase/fetch_game_constants_usecase.dart';

class FetchGameConstantsUsecaseImpl extends FetchGameConstantsUsecase {
  late SplashRepository remoteRepository;
  late SplashRepositoryLocal localRepository;
  late String localization;

  FetchGameConstantsUsecaseImpl({
    required this.remoteRepository,
    required this.localRepository,
    required this.localization,
  });

  @override
  Future<Either<Failure, LolConstantsModel>> call() async {
    try {
      LolConstantsModel lolConstantsModel = LolConstantsModel();

      /// Nesse caso, preciso esperar pelo get de versões para poder chamar
      /// a lista de champions.
      await remoteRepository.fetchGameLanguages()
        ..fold((l) => id, (r) async {
          lolConstantsModel.setGameLanguages(r);

          await remoteRepository.fetchVersions()
            ..fold((l) => id, (r) async {
              lolConstantsModel.setGameVersions(r);
              final response = await Future.value([
                await remoteRepository.fetchChampions(
                  language: lolConstantsModel.getLanguage(localization),
                  version: lolConstantsModel.getLatestLolVersion(),
                ),
                await remoteRepository.fetchItems(
                  language: lolConstantsModel.getLanguage(localization),
                  version: lolConstantsModel.getLatestLolVersion(),
                )
              ]);

              response[0].fold((l) => id, (r) {
                lolConstantsModel.setChampions(r as List<ChampionModel>);
              });

              response[1].fold((l) => id, (r) {
                lolConstantsModel.setItemMotherModel(r as ItemMotherModel);
              });
            });
        });

      ///

      final response = await Future.value(
        [
          await remoteRepository.fetchQueues(),
          await remoteRepository.fetchMaps(),
          await remoteRepository.fetchGameModes(),
        ],
      );

      response[0].fold((l) => id, (r) {
        lolConstantsModel.setQueues(r as List<QueueModel>);
      });
      response[1].fold((l) => id, (r) {
        lolConstantsModel.setMaps(r as List<MapaModel>);
      });
      response[2].fold((l) => id, (r) {
        lolConstantsModel.setGameModes(r as List<GameModeModel>);
      });

      return Right(lolConstantsModel);
    } catch (e) {
      return Left(
        Failure(
          message: "Erro ao capturar as requests de constants",
          error: e.toString(),
        ),
      );
    }
  }
}
