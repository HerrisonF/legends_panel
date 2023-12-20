import 'package:legends_panel/app/core/http_configuration/api_paths_ednpoints.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/model/data_analysis/game_time_line_model.dart';

class GameTimeLineRepository {
  late Logger logger;
  late HttpServices httpServices;

  GameTimeLineRepository({
    required this.logger,
    required this.httpServices,
  });

  Future<GameTimeLineModel> getGameTimeLine(
      String matchId, String keyRegion) async {
    final String path = "/lol/match/v5/matches/${keyRegion}_$matchId/timeline";
    logger.logDEBUG("Getting game time line ...");
    try {
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

      final response = await httpServices.get(
        url: url,
        path: path,
        origin: "GAME_TIME_LINE_REPOSITORY",
      );

      return response.fold((l) {
        logger.logDEBUG("Error to get game time line");
        return GameTimeLineModel();
      }, (r) {
        logger.logDEBUG("Success to get game time line...");
        return GameTimeLineModel.fromJson(r.data);
      });

    } catch (e) {
      logger.logDEBUG("Error to get game time line");
      return GameTimeLineModel();
    }
  }
}
