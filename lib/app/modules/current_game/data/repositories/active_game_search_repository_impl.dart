import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/core/http_configuration/api_endpoints.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/http_configuration/region_endpoints_enum.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/modules/current_game/data/dtos/active_game/active_game_info_dto.dart';
import 'package:legends_panel/app/modules/current_game/data/dtos/summoner_identification/summoner_identification_dto.dart';
import 'package:legends_panel/app/modules/current_game/data/dtos/summoner_identification/summoner_profile_dto.dart';
import 'package:legends_panel/app/modules/current_game/data/repositories/active_game_search_respository.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_banned_champion_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_customization_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_info_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_participant_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_perk_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/summoner_identification/summoner_identification_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/summoner_identification/summoner_profile_model.dart';

class ActiveGameSearchRepositoryImpl extends ActiveGameSearchRepository {
  late Logger logger;
  late HttpServices httpServices;

  ActiveGameSearchRepositoryImpl({
    required this.logger,
    required this.httpServices,
  });

  Future<Either<Failure, SummonerIdentificationModel>>
      fetchSummonerIdentification({
    required String summonerName,
    required String tagLine,
  }) async {
    logger.logDEBUG("Getting Summoner Identification ...");
    try {
      final response = await httpServices.get(
        url: API.riotAmericasUrl,
        path: '/riot/account/v1/accounts/by-riot-id/$summonerName/$tagLine',
        origin: "CURRENT_GAME_REPOSITORY",
      );

      return response.fold((l) {
        logger.logDEBUG("Summoner Identification not found ${l.status}");
        return Left(
          Failure(
            message: "Houve falta de autorização ou erro de configuração "
                "no momento de buscar a identificação.",
          ),
        );
      }, (r) {
        logger.logDEBUG("Summoner Identification game found ...");

        SummonerIdentificationDTO dto =
            SummonerIdentificationDTO.fromJson(r.data);

        return Right(
          SummonerIdentificationModel(
            puuid: dto.puuid,
            gameName: dto.gameName,
            tagLine: dto.tagLine,
          ),
        );
      });
    } catch (e) {
      logger.logDEBUG("Error to get Summoner identification ${e.toString()}");
      return Left(
        Failure(
          message: "Error to get Summoner identification.",
          error: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ActiveGameInfoModel>> fetchActiveGame({
    required String summonerId,
    required String region,
  }) async {
    logger.logDEBUG("Fetching Active Game ...");
    try {
      final response = await httpServices.get(
        url: RegionEndpoints.fromString(region),
        path: '/lol/spectator/v4/active-games/by-summoner/$summonerId',
        origin: "CURRENT_GAME_REPOSITORY",
      );

      return response.fold((l) {
        logger.logDEBUG("Game not found ${l.status}");
        return Left(
          Failure(
            message: "Houve falta de autorização ou erro de configuração "
                "no momento de buscar a identificação.",
          ),
        );
      }, (r) {
        logger.logDEBUG("Game found ...");

        ActiveGameInfoDTO dto = ActiveGameInfoDTO.fromJson(r.data);

        ActiveGameInfoModel model = ActiveGameInfoModel(
          gameMode: dto.gameMode,
          gameId: dto.gameId,
          gameLength: dto.gameLength,
          gameQueueConfigId: dto.gameQueueConfigId,
          gameStartTime: dto.gameStartTime,
          gameType: dto.gameType,
          mapId: dto.mapId,
          platformId: dto.platformId,
          activeGameBannedChampions: dto.activeGameBannedChampions
              .map((e) => ActiveGameBannedChampionModel(
                    pickTurn: e.pickTurn,
                    championId: e.championId,
                    teamId: e.teamId,
                  ))
              .toList(),
          activeGameParticipants: dto.activeGameParticipants
              .map((e) => ActiveGameParticipantModel(
                    championId: e.championId,
                    puuid: e.puuid,
                    perk: ActiveGamePerkModel(
                      perkIds: e.perk.perkIds.map((e) => e).toList(),
                      perkStyle: e.perk.perkStyle,
                      perkSubStyle: e.perk.perkSubStyle,
                    ),
                    profileIconId: e.profileIconId,
                    bot: e.bot,
                    teamId: e.teamId,
                    summonerName: e.summonerName,
                    summonerId: e.summonerId,
                    spell1Id: e.spell1Id,
                    spell2Id: e.spell2Id,
                    gameCustomizations: e.gameCustomizations
                        .map(
                          (e) => ActiveGameCustomizationModel(
                            category: e.category,
                            content: e.content,
                          ),
                        )
                        .toList(),
                  ))
              .toList(),
        );

        return Right(model);
      });
    } catch (e) {
      logger.logDEBUG("Error to fetch Active Game ${e.toString()}");
      return Left(
        Failure(
          message: "Error to fetch Active Game.",
          error: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SummonerProfileModel>> fetchSummonerProfile({
    required String puuid,
    required String region,
  }) async {
    logger.logDEBUG("Fetching Summoner Profile Game ...");
    try {
      final response = await httpServices.get(
        url: RegionEndpoints.fromString(region),
        path: '/lol/summoner/v4/summoners/by-puuid/$puuid',
        origin: "CURRENT_GAME_REPOSITORY",
      );

      return response.fold((l) {
        logger.logDEBUG("Summoner Profile not found ${l.status}");
        return Left(
          Failure(
            message: "Houve falta de autorização ou erro de configuração "
                "no momento de buscar a identificação.",
          ),
        );
      }, (r) {
        logger.logDEBUG("Summoner Profile found ...");

        SummonerProfileDTO dto = SummonerProfileDTO.fromJson(r.data);

        SummonerProfileModel model = SummonerProfileModel(
          accountId: dto.accountId,
          profileIconId: dto.profileIconId,
          name: dto.name,
          id: dto.id,
          summonerLevel: dto.summonerLevel,
        );

        return Right(model);
      });
    } catch (e) {
      logger.logDEBUG("Error to fetch Summoner Profile ${e.toString()}");
      return Left(
        Failure(
          message: "Error to fetch Summoner Profile.",
          error: e.toString(),
        ),
      );
    }
  }
}
