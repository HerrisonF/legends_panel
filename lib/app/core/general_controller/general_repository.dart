import 'package:legends_panel/app/core/http_configuration/api_endpoints.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/user_tier.dart';

class GeneralRepository {
  late Logger logger;
  late HttpServices httpServices;

  GeneralRepository({
    required this.logger,
    required this.httpServices,
  });

  static const String origin = "ParticipantRepository";

  Future<List<UserTier>> getUserTier(
    String encryptedSummonerId,
    String region,
  ) async {
    final String path =
        "/lol/league/v4/entries/by-summoner/$encryptedSummonerId";
    List<UserTier> listTier = [];
    try {
      final response = await httpServices.get(
        url: API.riotAmericasUrl,
        path: path,
        origin: origin,
      );

      return response.fold((l) {
        logger.logDEBUG("Error to get UserTier ...");
        return listTier;
      }, (r) {
        for (dynamic tier in r.data) {
          listTier.add(UserTier.fromJson(tier));
        }
        return listTier;
      });
    } catch (e) {
      logger.logDEBUG("Error to get UserTier ... $e");
      return listTier;
    }
  }

  String getUserTierImage(String tier) {
    logger.logDEBUG("building Image Tier Url ...");
    try {
      return "images/ranked_mini_emblems/${tier.toLowerCase()}.png";
    } catch (e) {
      logger.logDEBUG("Error to build Tier Image URL ... $e");
      return "";
    }
  }

  String getChampionBadgeUrl({
    required String championId,
    required String version,
  }) {
    logger.logDEBUG("building Image Champion URL... $championId # latest");
    final String path = "/cdn/$version/img/champion/$championId";
    try {
      return API.riotDragonUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Image Champion Url $e");
      return "";
    }
  }

  String getItemUrl(String itemId) {
    final String path = "/cdn/latest/img/item/$itemId.png";
    logger.logDEBUG("building Image Item URL...");
    try {
      return API.riotDragonUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Image Item Url $e");
      return "";
    }
  }

  String getPositionUrl(String position) {
    final String path =
        "/latest/plugins/rcp-fe-lol-clash/global/default/assets/images/position-selector/positions/icon-position-${position.toLowerCase()}.png";
    logger.logDEBUG("building Image Positon URL...");
    try {
      return API.rawDataDragonUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Image Position Url $e");
      return "";
    }
  }

  String getSpellBadgeUrl({
    required String spellName,
    required String version,
  }) {
    final String path = "/cdn/$version/img/spell/$spellName";
    logger.logDEBUG("building Image Spell Url ...");
    try {
      return API.riotDragonUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Spell Image URL ... $e");
      return "";
    }
  }

  // Future<CurrentGameSpectator> getSpectator(
  //     String userId,
  //     String region,
  //     ) async {
  //   final String path = "/lol/spectator/v4/active-games/by-summoner/$userId";
  //   logger.logDEBUG("Fetching Current Game ...");
  //   try {
  //     final response = await httpServices.get(
  //       url: API.riotAmericasUrl,
  //       path: path,
  //       origin: origin,
  //     );
  //
  //     return response.fold(
  //           (l) {
  //         logger.logDEBUG("Error fetching Current Game");
  //         return CurrentGameSpectator();
  //       },
  //           (r) {
  //         return CurrentGameSpectator.fromJson(r.data);
  //       },
  //     );
  //   } catch (e) {
  //     logger.logDEBUG("Error fetching Current Game $e");
  //     return CurrentGameSpectator();
  //   }
  // }

  String getPerkUrl(String iconName) {
    final String path = "/cdn/img/$iconName";
    logger.logDEBUG("building Image Perk Url ...");
    try {
      return API.riotDragonUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Perk Image URL ...");
      return "";
    }
  }
}
