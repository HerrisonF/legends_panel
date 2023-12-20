import 'package:legends_panel/app/core/http_configuration/api_paths_ednpoints.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/model/general/champion_with_spell.dart';

class BuildPageRepository {
  late Logger logger;
  late HttpServices httpServices;

  BuildPageRepository({
    required this.logger,
  });

  String getChampionImage(String championId, String version) {
    final String path = "/cdn/$version/img/champion/$championId.png";
    logger.logDEBUG("building Image Champion for mastery URL...");
    try {
      return API.riotDragonUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Image Champion for mastery Url $e");
      return "";
    }
  }

  String getChampionSpellImage(String spellName, String version) {
    final String path = "/cdn/$version/img/spell/$spellName.png";
    logger.logDEBUG("building spell image champion...");
    try {
      return API.riotDragonUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build spell image champion $e");
      return "";
    }
  }

  String getPerkStyleUrl(String perkStyle) {
    final String path = "/images/lol/perkStyle/$perkStyle.png";
    logger.logDEBUG("building Image Perk Style Url ...");
    try {
      return API.opGGUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Perk Style Image URL ...");
      return "";
    }
  }

  String getSpellBadgeUrl(String spellName, String version) {
    final String path = "/cdn/$version/img/spell/$spellName.png";
    logger.logDEBUG("building Image Spell Url ...");
    try {
      return API.riotDragonUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Spell Image URL ... $e");
      return "";
    }
  }

  String getItemUrl(String itemId, String version) {
    final String path = "/cdn/$version/img/item/$itemId.png";
    logger.logDEBUG("building Image Item URL...");
    try {
      return API.riotDragonUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Image Item Url $e");
      return "";
    }
  }

  String getPerkUrl(String perk) {
    final String path = "/images/lol/perk/$perk.png";
    logger.logDEBUG("building Image Perk Url ...");
    try {
      return API.opGGUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Perk Image URL ...");
      return "";
    }
  }

  String getPerkShardUrl(String perk) {
    final String path = "/images/lol/perkShard/$perk.png";
    logger.logDEBUG("building Image Perk shard Url ...");
    try {
      return API.opGGUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Perk shard Image URL ...");
      return "";
    }
  }

  Future<ChampionWithSpell> getChampionForSpell(
    String championName,
    String version,
  ) async {
    final String path = "/cdn/$version/data/en_US/champion/$championName.json";
    logger.logDEBUG("Getting champion spell json ...");
    try {
      final response = await httpServices.get(
          url: API.riotDragonUrl, path: path, origin: "BuildPageRepository");

      return response.fold((l) {
        logger.logDEBUG("Error to get champion spell");
        return ChampionWithSpell();
      }, (r) {
        logger.logDEBUG("Success getting champion spell ...");
        return ChampionWithSpell.fromJson(r.data);
      });
    } catch (e) {
      logger.logDEBUG("Error to get champion spell");
      return ChampionWithSpell();
    }
  }
}
