import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/core/http_configuration/api_endpoints.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/http_configuration/region_endpoints_enum.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/modules/profile/data/dtos/match_detail_dto.dart';
import 'package:legends_panel/app/modules/profile/domain/models/champion_mastery_model.dart';
import 'package:legends_panel/app/modules/profile/domain/models/match_detail_model.dart';
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
    final String path =
        "/latest/plugins/rcp-fe-lol-shared-components/global/default/${tier.toLowerCase()}.png";
    try {
      return API.rawDataDragonUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Image Profile URL ... $e");
      return "";
    }
  }

  Future<Either<Failure, List<ChampionMasteryModel>>> getChampionMastery({
    required String encryptedPUUID,
    required String region,
  }) async {
    final String path =
        "/lol/champion-mastery/v4/champion-masteries/by-puuid/$encryptedPUUID/top";

    List<ChampionMasteryModel> championMasteryList = [];

    try {
      final response = await httpServices.get(
        url: RegionEndpoints.fromString(region),
        path: path,
        origin: origin,
      );

      return response.fold(
        (l) {
          return Left(
            Failure(message: "Champion Mastery não encontrada"),
          );
        },
        (r) {
          for (dynamic championMastery in r.data) {
            ChampionMasteryDTO dto =
                ChampionMasteryDTO.fromJson(championMastery);

            championMasteryList.add(
              ChampionMasteryModel(
                tokensEarned: dto.tokensEarned,
                championPointsSinceLastLevel: dto.championPointsSinceLastLevel,
                championPoints: dto.championPoints,
                championLevel: dto.championLevel,
                lastPlayTime: dto.lastPlayTime,
                championId: dto.championId,
                championPointsUntilNextLevel: dto.championPointsUntilNextLevel,
              ),
            );
          }
          return Right(championMasteryList);
        },
      );
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

  String getMasteryImage({
    required int championLevel,
  }) {
    if (championLevel <= 3) {
      return "images/champion_mastery/masterycrest_0.png";
    }
    if(championLevel >= 10){
      return "images/champion_mastery/masterycrest_10.png";
    }
    final String path =
        "images/champion_mastery/masterycrest_$championLevel.png";
    try {
      return path;
    } catch (e) {
      logger.logDEBUG("Error to build Image Champion for mastery Url $e");
      return "";
    }
  }

  Future<Either<Failure, List<String>>> getMatchListIds({
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
        return Left(l);
      }, (r) {
        for (String id in r.data) {
          matchListId.add(id);
        }
        return Right(matchListId);
      });
    } catch (e) {
      return Left(
        Failure(
          message: "Error to get MatchList",
          error: e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, MatchDetailModel>> getMatchById({
    required String matchId,
    required String keyRegion,
  }) async {
    final String path = "/lol/match/v5/matches/$matchId";

    String url = "";

    if (keyRegion == "KR" ||
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

      return response.fold(
        (l) {
          logger.logDEBUG("Error to get Match by id");
          return Left(l);
        },
        (r) {
          MatchDetailDTO dto = MatchDetailDTO.fromJson(r.data);
          return Right(
            MatchDetailModel(
              info: dto.infoDTO != null
                  ? InfoModel(
                      gameCreation: dto.infoDTO!.gameCreation,
                      gameDuration: dto.infoDTO!.gameDuration,
                      gameEndTimestamp: dto.infoDTO!.gameEndTimestamp,
                      gameId: dto.infoDTO!.gameId,
                      gameMode: dto.infoDTO!.gameMode,
                      gameStartTimestamp: dto.infoDTO!.gameStartTimestamp,
                      participants: dto.infoDTO!.participantDTOs
                          .map(
                            (participant) => ParticipantModel(
                              championId: participant.championId,
                              kills: participant.kills,
                              teamId: participant.teamId,
                              puuid: participant.puuid,
                              summonerLevel: participant.summonerLevel,
                              win: participant.win,
                              summonerId: participant.summonerId,
                              summonerName: participant.summonerName,
                              perks: participant.perksDTO != null
                                  ? PerksModel(
                                      statPerks: StatPerksModel(
                                        defense: participant
                                            .perksDTO!.statPerksDTO.defense,
                                        flex: participant
                                            .perksDTO!.statPerksDTO.flex,
                                        offense: participant
                                            .perksDTO!.statPerksDTO.offense,
                                      ),
                                      styles: participant.perksDTO!.stylesDTO
                                          .map(
                                            (e) => PerkStyleModel(
                                              description: e.description,
                                              style: e.style,
                                              selections: e.selectionsDTO
                                                  .map(
                                                    (perk) =>
                                                        PerkStyleSelectionModel(
                                                      perk: perk.perk,
                                                      var1: perk.var1,
                                                      var2: perk.var2,
                                                      var3: perk.var3,
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          )
                                          .toList(),
                                    )
                                  : null,
                              assists: participant.assists,
                              baronKills: participant.baronKills,
                              bountyLevel: participant.bountyLevel,
                              champExperience: participant.champExperience,
                              championName: participant.championName,
                              championTransform: participant.championTransform,
                              champLevel: participant.champLevel,
                              consumablesPurchased:
                                  participant.consumablesPurchased,
                              damageDealtToBuildings:
                                  participant.damageDealtToBuildings,
                              damageDealtToObjectives:
                                  participant.damageDealtToObjectives,
                              damageDealtToTurrets:
                                  participant.damageDealtToTurrets,
                              damageSelfMitigated:
                                  participant.damageSelfMitigated,
                              deaths: participant.deaths,
                              detectorWardsPlaced:
                                  participant.detectorWardsPlaced,
                              doubleKills: participant.doubleKills,
                              dragonKills: participant.dragonKills,
                              firstBloodAssist: participant.firstBloodAssist,
                              firstBloodKill: participant.firstBloodKill,
                              firstTowerAssist: participant.firstTowerAssist,
                              firstTowerKill: participant.firstTowerKill,
                              gameEndedInEarlySurrender:
                                  participant.gameEndedInEarlySurrender,
                              gameEndedInSurrender:
                                  participant.gameEndedInSurrender,
                              goldEarned: participant.goldEarned,
                              goldSpent: participant.goldSpent,
                              individualPosition:
                                  participant.individualPosition,
                              inhibitorKills: participant.inhibitorKills,
                              inhibitorLost: participant.inhibitorLost,
                              inhibitorTakedowns:
                                  participant.inhibitorTakedowns,
                              item0: participant.item0,
                              item1: participant.item1,
                              item2: participant.item2,
                              item3: participant.item3,
                              item4: participant.item4,
                              item5: participant.item5,
                              item6: participant.item6,
                              itemsPurchased: participant.itemsPurchased,
                              killingSpress: participant.killingSpress,
                              lane: participant.lane,
                              largestCriticalStrike:
                                  participant.largestCriticalStrike,
                              largestKillingSpree:
                                  participant.largestKillingSpree,
                              largestMultiKill: participant.largestMultiKill,
                              longestTimeSpentLiving:
                                  participant.longestTimeSpentLiving,
                              magicDamageDealt: participant.magicDamageDealt,
                              magicDamageDealtToChampions:
                                  participant.magicDamageDealtToChampions,
                              magicDamageTaken: participant.magicDamageTaken,
                              neutralMinionsKilled:
                                  participant.neutralMinionsKilled,
                              nexusKills: participant.nexusKills,
                              nexusLost: participant.nexusLost,
                              nexusTakeDowns: participant.nexusTakeDowns,
                              objectivesStolen: participant.objectivesStolen,
                              objectiveStolenAssists:
                                  participant.objectiveStolenAssists,
                              participantId: participant.participantId,
                              pentaKills: participant.pentaKills,
                              physicalDamageDealt:
                                  participant.physicalDamageDealt,
                              physicalDamageDealtToChampions:
                                  participant.physicalDamageDealtToChampions,
                              physicalDamageTaken:
                                  participant.physicalDamageTaken,
                              profileIcon: participant.profileIcon,
                              quadraKills: participant.quadraKills,
                              riotIdName: participant.riotIdName,
                              riotIdTagline: participant.riotIdTagline,
                              role: participant.role,
                              sightWardsBoughtInGame:
                                  participant.sightWardsBoughtInGame,
                              spell1Casts: participant.spell1Casts,
                              spell2Casts: participant.spell2Casts,
                              spell3Casts: participant.spell3Casts,
                              spell4Casts: participant.spell4Casts,
                              summoner1Casts: participant.summoner1Casts,
                              summoner1Id: participant.summoner1Id,
                              summoner2Casts: participant.summoner2Casts,
                              summoner2Id: participant.summoner2Id,
                              teamEarlySurrendered:
                                  participant.teamEarlySurrendered,
                              teamPosition: participant.teamPosition,
                              timeCCingOthers: participant.timeCCingOthers,
                              timePlayed: participant.timePlayed,
                              totalDamageDealt: participant.totalDamageDealt,
                              totalDamageDealtToChampions:
                                  participant.totalDamageDealtToChampions,
                              totalDamageShieldedOnTeammates:
                                  participant.totalDamageShieldedOnTeammates,
                              totalDamageTaken: participant.totalDamageTaken,
                              totalHeal: participant.totalHeal,
                              totalHealsOnTeammates:
                                  participant.totalHealsOnTeammates,
                              totalMinionsKilled:
                                  participant.totalMinionsKilled,
                              totalTimeCCDealt: participant.totalTimeCCDealt,
                              totalTimeSpentDead:
                                  participant.totalTimeSpentDead,
                              totalUnitsHealed: participant.totalUnitsHealed,
                              tripleKills: participant.tripleKills,
                              trueDamageDealt: participant.trueDamageDealt,
                              trueDamageDealtToChampions:
                                  participant.trueDamageDealtToChampions,
                              trueDamageTaken: participant.trueDamageTaken,
                              turretKills: participant.turretKills,
                              turretsLost: participant.turretsLost,
                              turretTakedowns: participant.turretTakedowns,
                              unrealKills: participant.unrealKills,
                              visionScore: participant.visionScore,
                              visionWardsBoughtInGame:
                                  participant.visionWardsBoughtInGame,
                              wardsKilled: participant.wardsKilled,
                              wardsPlaced: participant.wardsPlaced,
                            ),
                          )
                          .toList(),
                      platformId: dto.infoDTO!.platformId,
                      queueId: dto.infoDTO!.queueId,
                      teams: dto.infoDTO!.teamDTOs
                          .map(
                            (e) => TeamModel(
                              bans: e.banDTOs
                                  .map(
                                    (ban) => BanModel(
                                      championId: ban.championId,
                                      pickTurn: ban.pickTurn,
                                    ),
                                  )
                                  .toList(),
                              objetivos: ObjetivosModel(
                                baron: ObjetivoModel(
                                  first: e.objetivosDTO.baronDTO.first,
                                  kills: e.objetivosDTO.baronDTO.kills,
                                ),
                                champion: ObjetivoModel(
                                  first: e.objetivosDTO.championDTO.first,
                                  kills: e.objetivosDTO.championDTO.kills,
                                ),
                                dragon: ObjetivoModel(
                                  first: e.objetivosDTO.dragonDTO.first,
                                  kills: e.objetivosDTO.dragonDTO.kills,
                                ),
                                inhibitor: ObjetivoModel(
                                  first: e.objetivosDTO.inhibitorDTO.first,
                                  kills: e.objetivosDTO.inhibitorDTO.kills,
                                ),
                                riftHerald: ObjetivoModel(
                                  first: e.objetivosDTO.riftHeraldDTO.first,
                                  kills: e.objetivosDTO.riftHeraldDTO.kills,
                                ),
                                tower: ObjetivoModel(
                                  first: e.objetivosDTO.towerDTO.first,
                                  kills: e.objetivosDTO.towerDTO.kills,
                                ),
                              ),
                              teamId: e.teamId,
                              win: e.win,
                            ),
                          )
                          .toList(),
                      gameName: dto.infoDTO!.gameName,
                      mapId: dto.infoDTO!.mapId,
                      gameVersion: dto.infoDTO!.gameVersion,
                      tournamentCode: dto.infoDTO!.tournamentCode,
                    )
                  : null,
              metaData: dto.metaDataDTO != null
                  ? MetaDataModel(
                      dataVersion: dto.metaDataDTO!.dataVersion,
                      matchId: dto.metaDataDTO!.matchId,
                      participantsPUUIDs: dto.metaDataDTO!.participantsPUUIDs
                          .map((e) => e)
                          .toList(),
                    )
                  : null,
            ),
          );
        },
      );
    } catch (e) {
      return Left(
        Failure(
          message: "Error to get MAtch by id",
          error: e.toString(),
        ),
      );
    }
  }
}
