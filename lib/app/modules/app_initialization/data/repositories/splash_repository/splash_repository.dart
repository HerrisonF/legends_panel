import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/champion_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/game_language_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/game_mode_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/game_version_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/item_mother_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/mapa_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/queue_model.dart';

abstract class SplashRepository{
  Future<Either<Failure, List<QueueModel>>> fetchQueues();
  Future<Either<Failure, List<GameVersionModel>>> fetchVersions();
  Future<Either<Failure, List<MapaModel>>> fetchMaps();
  Future<Either<Failure, List<GameModeModel>>> fetchGameModes();
  Future<Either<Failure, List<GameLanguageModel>>> fetchGameLanguages();
  Future<Either<Failure, List<ChampionModel>>> fetchChampions({
    required String version,
    required String language,
  });
  Future<Either<Failure, ItemMotherModel>> fetchItems({
    required String version,
    required String language,
  });
}