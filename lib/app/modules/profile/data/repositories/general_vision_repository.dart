import 'package:legends_panel/app/core/http_configuration/api_paths_endpoints.dart';
import 'package:legends_panel/app/core/logger/logger.dart';

class GeneralVisionRepository {
  late Logger logger;

  GeneralVisionRepository({
    required this.logger,
  });

  String getBaronIcon() {
    final String path = "/images/site/summoner/icon-baron-b.png";
    logger.logDEBUG("building Image Baron Url ...");
    try {
      return API.opGGUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Baron Image URL ...");
      return "";
    }
  }

  String getDragonIcon() {
    final String path = "/images/site/summoner/icon-dragon-b.png";
    logger.logDEBUG("building Image Dragon Url ...");
    try {
      return API.opGGUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Dragon Image URL ...");
      return "";
    }
  }

  String getTowerIcon() {
    final String path = "/images/site/summoner/icon-tower-b.png";
    logger.logDEBUG("building Image Tower Url ...");
    try {
      return API.opGGUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Tower Image URL ...");
      return "";
    }
  }

  String getKillIcon() {
    final String path =
        "/latest/game/assets/ux/traiticons/trait_icon_blademaster.png";
    logger.logDEBUG("building Image Kill Url ...");
    try {
      return API.rawDataDragonUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Kill Image URL ...");
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

  String getMinionUrl() {
    final String path =
        "/latest/game/assets/ux/tft/stageicons/minionsupcoming.png";
    logger.logDEBUG("building Image Minion Url ...");
    try {
      return API.rawDataDragonUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Perk Minion URL ...");
      return "";
    }
  }

  String getGoldIconUrl() {
    final String path = "/latest/game/assets/ux/floatingtext/goldicon.png";
    logger.logDEBUG("building Gold icon Url ...");
    try {
      return API.rawDataDragonUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Gold icon URL ...");
      return "";
    }
  }

  String getHeraldIcon() {
    final String path =
        "/latest/game/assets/ux/tft/stageicons/heraldupcoming.png";
    logger.logDEBUG("building Herald icon Url ...");
    try {
      return API.rawDataDragonUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Herald icon URL ...");
      return "";
    }
  }

  String getCriticIcon() {
    final String path = "/latest/game/assets/ux/floatingtext/criticon.png";
    logger.logDEBUG("building Critic icon Url ...");
    try {
      return API.rawDataDragonUrl + path;
    } catch (e) {
      logger.logDEBUG("Error to build Critic icon URL ...");
      return "";
    }
  }
}
