import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/core/http_configuration/api_endpoints.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/http_configuration/region_endpoints_enum.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/champion_mastery.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/match_detail.dart';
import 'package:legends_panel/app/modules/profile/data/dtos/champion_mastery_dto.dart';

class ProfileRepository {
  late Logger logger;
  late HttpServices httpServices;

  ProfileRepository({
    required this.logger,
    required this.httpServices,
  });

  static const String origin = "ProfileRepository";

  String getProfileImage({
    required String profileIconId,
    required String version,
  }) {
    final String path = "/cdn/$version/img/profileicon/$profileIconId.png";
    try {
      return API.riotDragonUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Image Profile URL ... $e");
      return "";
    }
  }

  String getRankedTierBadge({
    required String tier,
  }) {
    final String path = "/latest/plugins/rcp-fe-lol-shared-components/global/default/${tier.toLowerCase()}.png";
    try {
      return API.rawDataDragonUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Image Profile URL ... $e");
      return "";
    }
  }

  Future<Either<Failure, List<ChampionMastery>>> getChampionMastery({
    required String encryptedPUUID,
    required String region,
  }) async {
    final String path =
        "/lol/champion-mastery/v4/champion-masteries/by-puuid/$encryptedPUUID/top";

    List<ChampionMastery> championMasteryList = [];

    try {
      final response = await httpServices.get(
        url: RegionEndpoints.fromString(region),
        path: path,
        origin: origin,
      );

      return response.fold((l) {
        return Left(
          Failure(message: "Champion Mastery não encontrada"),
        );
      }, (r) {
        for (dynamic championMastery in r.data) {
          ChampionMasteryDTO dto = ChampionMasteryDTO.fromJson(championMastery);

          championMasteryList.add(ChampionMastery(
            tokensEarned: dto.tokensEarned,
            championPointsSinceLastLevel: dto.championPointsSinceLastLevel,
            championPoints: dto.championPoints,
            championLevel: dto.championLevel,
            summonerId: dto.summonerId,
            lastPlayTime: dto.lastPlayTime,
            championId: dto.championId,
            chestGranted: dto.chestGranted,
            championPointsUntilNextLevel: dto.championPointsUntilNextLevel,
          ));
        }
        return Right(championMasteryList);
      });
    } catch (e) {
      logger.logDEBUG("Error to get Champion Mastery");
      return Left(
        Failure(
          error: e.toString(),
          message: "Error to get Champion Mastery",
        ),
      );
    }
  }

  String getMasteryImage(String championLevel) {
    if (championLevel == "3") {
      final String path =
          "/latest/game/assets/ux/mastery/mastery_icon_default.png";
      return API.rawDataDragonUrl + path;
    }
    final String path =
        "/latest/game/assets/ux/mastery/mastery_icon_$championLevel.png";
    try {
      return API.rawDataDragonUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Image Champion for mastery Url $e");
      return "";
    }
  }

  Future<List<String>> getMatchListIds({
    required String puuid,
    required int start,
    required int count,
    required String keyRegion,
  }) async {
    final String path = "/lol/match/v5/matches/by-puuid/$puuid/ids";
    logger.logDEBUG("Getting MatchList ...");

    List<String> matchListId = [];

    String url = "";

    if (keyRegion == "KR" ||
        keyRegion == "RU" ||
        keyRegion == "JP1" ||
        keyRegion == "TR1" ||
        keyRegion == "OC1") {
      url = API.riotAsiaUrl;
    }
    if (keyRegion == "EUN1" || keyRegion == "EUW1" || keyRegion == "NA1") {
      url = API.riotEuropeUrl;
    }

    if (keyRegion == "LA1" || keyRegion == "BR1" || keyRegion.isEmpty) {
      url = API.riotAmericasUrl;
    }

    final riotGetParams = {
      "start": "${start.toString()}",
      "count": "${count.toString()}"
    };
    try {
      final response = await httpServices.get(
        url: url,
        queryParameters: riotGetParams,
        path: path,
        origin: origin,
      );

      return response.fold((l) {
        logger.logDEBUG("Error to get MatchList");
        return matchListId;
      }, (r) {
        for (String id in r.data) {
          matchListId.add(id);
        }
        return matchListId;
      });
    } catch (e) {
      logger.logDEBUG("Error to get MatchList $e");
      return matchListId;
    }
  }

  Future<MatchDetail> getMatchById(String matchId, String keyRegion) async {
    final String path = "/lol/match/v5/matches/$matchId";

    String url = "";

    if (keyRegion == "KR" ||
        keyRegion == "RU" ||
        keyRegion == "JP1" ||
        keyRegion == "TR1" ||
        keyRegion == "OC1") {
      url = API.riotAsiaUrl;
    }
    if (keyRegion == "EUN1" || keyRegion == "EUW1" || keyRegion == "NA1") {
      url = API.riotEuropeUrl;
    }

    if (keyRegion == "LA1" || keyRegion == "BR1" || keyRegion.isEmpty) {
      url = API.riotAmericasUrl;
    }
    try {
      final response = await httpServices.get(
        url: url,
        path: path,
        origin: origin,
      );

      return response.fold((l) {
        logger.logDEBUG("Error to get Match by id");
        return MatchDetail();
      }, (r) {
        return MatchDetail.fromJson(r.data);
      });
    } catch (e) {
      logger.logDEBUG("Error to get MAtch by id $e");
      return MatchDetail();
    }
  }
}
