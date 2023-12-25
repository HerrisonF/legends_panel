import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/core/http_configuration/api_endpoints.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/modules/current_game/data/dtos/summoner_identification_dto.dart';
import 'package:legends_panel/app/modules/current_game/data/repositories/current_game_respository.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/summoner_identification_model.dart';

class CurrentGameRepositoryImpl extends CurrentGameRepository {
  late Logger logger;
  late HttpServices httpServices;

  CurrentGameRepositoryImpl({
    required this.logger,
    required this.httpServices,
  });

  Future<Either<Failure, SummonerIdentificationModel>>
      getSummonerIdentification({
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
        return Right(SummonerIdentificationModel.empty());
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
      return Right(SummonerIdentificationModel.empty());
    }
  }
}
