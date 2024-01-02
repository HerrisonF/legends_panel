import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/core/http_configuration/api_endpoints.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/http_configuration/region_endpoints_enum.dart';
import 'package:legends_panel/app/modules/current_game/data/dtos/user_tier_entries/league_entry_dto.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/user_tier_entries/league_entry_model.dart';

class GeneralRepository {
  late HttpServices httpServices;

  GeneralRepository({required this.httpServices});

  static const String origin = "generalRepository";

  Future<Either<Failure, List<LeagueEntryModel>>> fetchLeagueEntries({
    required String encryptedSummonerId,
    required String region,
  }) async {
    final String path =
        "/lol/league/v4/entries/by-summoner/$encryptedSummonerId";
    List<LeagueEntryModel> models = [];
    try {
      final response = await httpServices.get(
        url: RegionEndpoints.fromString(region),
        path: path,
        origin: origin,
      );

      return response.fold(
        (l) => Left(
          Failure(message: "Nada encontrado para Summoner TIER"),
        ),
        (r) {
          for (dynamic tier in r.data) {
            LeagueEntryDTO dto = LeagueEntryDTO.fromJson(tier);

            models.add(
              LeagueEntryModel(
                leagueId: dto.leagueId,
                summonerId: dto.summonerId,
                summonerName: dto.summonerName,
                queueType: dto.queueType,
                tier: dto.tier,
                rank: dto.rank,
                leaguePoints: dto.leaguePoints,
                wins: dto.wins,
                losses: dto.losses,
                hotStreak: dto.hotStreak,
                veteran: dto.veteran,
                freshBlood: dto.freshBlood,
                inactive: dto.inactive,
              ),
            );
          }
          return Right(models);
        },
      );
    } catch (e) {
      return Left(
        Failure(
          message: "Nada encontrado para Summoner TIER",
          error: e.toString(),
        ),
      );
    }
  }

  /// Aqui são as mini-emblems.
  String getTierMiniEmblemUrl({
    required String tier,
  }) {
    final String path = "latest/plugins/rcp-fe-lol-static-assets/"
        "global/default/images/ranked-mini-crests/$tier.png";
    try {
      return API.rawDataDragonUrl + path;
    } catch (e) {
      return "";
    }
  }

  String getChampionBadgeUrl({
    required String championId,
    required String version,
  }) {
    final String path = "/cdn/$version/img/champion/$championId";
    try {
      return API.riotDragonUrl + path;
    } catch (e) {
      return "";
    }
  }

  String getItemUrl(String itemId) {
    final String path = "/cdn/latest/img/item/$itemId.png";
    try {
      return API.riotDragonUrl + path;
    } catch (e) {
      return "";
    }
  }

  String getPositionUrl(String position) {
    final String path = "/latest/plugins/rcp-fe-lol-clash/global/default/"
        "assets/images/position-selector/positions/icon-position-${position.toLowerCase()}.png";
    try {
      return API.rawDataDragonUrl + path;
    } catch (e) {
      return "";
    }
  }

  String getSpellBadgeUrl({
    required String spellName,
    required String version,
  }) {
    final String path = "/cdn/$version/img/spell/$spellName";
    try {
      return API.riotDragonUrl + path;
    } catch (e) {
      return "";
    }
  }

  /// Aqui é o estilo da perk.
  String getPerkUrl(String iconName) {
    final String path = "/cdn/img/$iconName";
    try {
      return API.riotDragonUrl + path;
    } catch (e) {
      return "";
    }
  }

  /// São as perks que o usuário selecionou.
  String getPerkDetailUrl({
    required String iconPath,
  }) {
    final String path =
        "/latest/plugins/rcp-be-lol-game-data/global/default/v1/${iconPath.toLowerCase()}";
    try {
      return API.rawDataDragonUrl + path;
    } catch (e) {
      return "";
    }
  }
}
