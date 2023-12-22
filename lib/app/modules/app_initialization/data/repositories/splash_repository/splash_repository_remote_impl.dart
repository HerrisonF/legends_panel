import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/core/http_configuration/api_paths_endpoints.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/game_language_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/game_mode_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/game_version_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/mapa_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/queue_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/repositories/splash_repository/splash_repository.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/game_language_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/game_mode_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/game_version_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/mapa_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/queue_model.dart';

class SplashRepositoryRemoteImpl extends SplashRepository {
  late HttpServices httpServices;

  static const origin = "SplashRepository-Queues-Remote";

  SplashRepositoryRemoteImpl({
    required this.httpServices,
  });

  @override
  Future<Either<Failure, List<QueueModel>>> fetchQueues() async {
    try {
      final response = await httpServices.get(
        url: API.riotStaticDataUrl,
        path: '/docs/lol/queues.json',
        origin: origin,
      );

      return response.fold(
        (l) => Left(l),
        (r) {
          List<QueueModel> queues = [];
          r.data.forEach(
            (queue) {
              QueueDto dto = QueueDto.fromJson(queue);
              queues.add(
                QueueModel(
                  description: dto.description,
                  map: dto.map,
                  notes: dto.notes,
                  queueId: dto.queueId,
                ),
              );
            },
          );

          return Right(queues);
        },
      );
    } catch (e) {
      return Left(
        Failure(
          message: 'Falha na busca remota de QUEUES.',
          error: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<GameVersionModel>>> fetchVersions() async {
    try {
      final response = await httpServices.get(
        url: API.riotDragonUrl,
        path: '/api/versions.json',
        origin: origin,
      );

      return response.fold(
        (l) => Left(l),
        (r) {
          List<GameVersionModel> gameVersions = [];
          r.data.forEach((item) {
            GameVersionDTO dto = GameVersionDTO.fromJson(item);
            gameVersions.add(
              GameVersionModel(
                version: dto.version,
              ),
            );
          });

          return Right(gameVersions);
        },
      );
    } catch (e) {
      return Left(
        Failure(
          message: 'Falha na busca remota de VERSÕES.',
          error: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<MapaModel>>> fetchMaps() async {
    try {
      final response = await httpServices.get(
        url: API.riotStaticDataUrl,
        path: '/docs/lol/maps.json',
        origin: origin,
      );
      List<MapaModel> mapas = [];

      response.fold((l) => Left(l), (r) {
        r.data.forEach(
          (queue) {
            MapaDTO dto = MapaDTO.fromJson(queue);
            mapas.add(
              MapaModel(
                notes: dto.notes,
                mapaId: dto.mapId,
                mapName: dto.mapName,
              ),
            );
          },
        );
      });

      return Right(mapas);
    } catch (e) {
      return Left(
        Failure(
          message: 'Falha na busca remota de MAPAS.',
          error: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<GameModeModel>>> fetchGameModes() async {
    try {
      final response = await httpServices.get(
        url: API.riotStaticDataUrl,
        path: '/docs/lol/gameModes.json',
        origin: origin,
      );
      List<GameModeModel> gameModes = [];

      response.fold((l) => Left(l), (r) {
        r.data.forEach(
          (queue) {
            GameModeDTO dto = GameModeDTO.fromJson(queue);
            gameModes.add(
              GameModeModel(
                gameMode: dto.gameMode,
                description: dto.description,
              ),
            );
          },
        );
      });

      return Right(gameModes);
    } catch (e) {
      return Left(
        Failure(
          message: 'Falha na busca remota de GAMEMODES.',
          error: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<GameLanguageModel>>> fetchGameLanguages() async {
    try {
      final response = await httpServices.get(
        url: API.riotDragonUrl,
        path: '/cdn/languages.json',
        origin: origin,
      );

      return response.fold(
        (l) => Left(l),
        (r) {
          List<GameLanguageModel> gameLanguages = [];
          r.data.forEach((item) {
            GameLanguageDTO dto = GameLanguageDTO.fromJson(item);
            gameLanguages.add(
              GameLanguageModel(
                language: dto.language,
              ),
            );
          });

          return Right(gameLanguages);
        },
      );
    } catch (e) {
      return Left(
        Failure(
          message: 'Falha na busca remota de LINGUAGENS.',
          error: e.toString(),
        ),
      );
    }
  }
}
