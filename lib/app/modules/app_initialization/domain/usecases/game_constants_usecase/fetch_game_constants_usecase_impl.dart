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
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/summoner_spell.dart';
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

      /// Essas requests só podem ser chamadas 1 vez por dia para economizar
      /// recursos. A ideia é que o dará tempo do aplicativo se atualizar caso
      /// o jogo se atualize. Um dia não é algo crítico.

      if (await temMaisQue24Horas()) {
        await _syncRequest(lolConstantsModel);
        await _asyncRequest(lolConstantsModel);
        await localRepository.saveRegisterDate();
        await localRepository.saveLolConstants(
          lolConstantsModel: lolConstantsModel,
        );
      } else {
        final response = await localRepository.fetchLolConstantsLocal();
        return response.fold(
          (l) => Left(l),
          (r) => Right(r),
        );
      }
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

  Future<void> _asyncRequest(LolConstantsModel lolConstantsModel) async {
    final response = await Future.value(
      [
        await remoteRepository.fetchQueues(),
        await remoteRepository.fetchMaps(),
        await remoteRepository.fetchGameModes(),
      ],
    );

    response[0].fold((l) => Left(l), (r) {
      lolConstantsModel.setQueues(r as List<QueueModel>);
    });
    response[1].fold((l) => Left(l), (r) {
      lolConstantsModel.setMaps(r as List<MapaModel>);
    });
    response[2].fold((l) => Left(l), (r) {
      lolConstantsModel.setGameModes(r as List<GameModeModel>);
    });
  }

  /// Nesse caso, preciso esperar pelo get de versões para poder chamar
  /// a lista de champions. Depois de recuperado, o resto das requests podem
  /// ser asyncronas.
  Future<void> _syncRequest(LolConstantsModel lolConstantsModel) async {
    await remoteRepository.fetchGameLanguages()
      ..fold((l) => Left(l), (r) async {
        lolConstantsModel.setGameLanguages(r);
        await remoteRepository.fetchVersions()
          ..fold((l) => Left(l), (r) async {
            lolConstantsModel.setGameVersions(r);
            final response = await Future.value([
              await remoteRepository.fetchChampions(
                language: lolConstantsModel.getLanguage(localization),
                version: lolConstantsModel.getLatestLolVersion(),
              ),
              await remoteRepository.fetchItems(
                language: lolConstantsModel.getLanguage(localization),
                version: lolConstantsModel.getLatestLolVersion(),
              ),
              await remoteRepository.fetchSummonerSpells(
                language: lolConstantsModel.getLanguage(localization),
                version: lolConstantsModel.getLatestLolVersion(),
              ),
            ]);

            response[0].fold((l) => Left(l), (r) {
              lolConstantsModel.setChampions(r as List<ChampionModel>);
            });

            response[1].fold((l) => Left(l), (r) {
              lolConstantsModel.setItemMotherModel(r as ItemMotherModel);
            });

            response[2].fold((l) => Left(l), (r) {
              lolConstantsModel.setSummonerSpells(r as List<SummonerSpell>);
            });
            lolConstantsModel.setRankedConstants();
          });
      });
  }

  Future<bool> temMaisQue24Horas() async {
    DateTime actualDate = DateTime.now();
    int milissegundosInt = 0;
    final response = await localRepository.fetchRegisterDate();

    return response.fold(
      (l) => true,
      (r) {
        if (r.isNotEmpty) {
          milissegundosInt = int.parse(r);

          Duration timeDifference = actualDate.difference(
            DateTime.fromMillisecondsSinceEpoch(milissegundosInt),
          );
          return timeDifference.inHours > 12;
        }

        return true;
      },
    );
  }
}
