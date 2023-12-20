import 'package:legends_panel/app/core/http_configuration/api_paths_endpoints.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/modules/current_game/domain/current_game_spectator/current_game_spectator.dart';

class CurrentGameRepository {
  late Logger logger;
  late HttpServices httpServices;

  CurrentGameRepository({
    required this.logger,
    required this.httpServices,
  });

  Future<CurrentGameSpectator> getCurrentGameExists(
      String encryptedSummonerId, String keyRegion) async {
    final String path =
        "/lol/spectator/v4/active-games/by-summoner/$encryptedSummonerId";
    logger.logDEBUG("Getting currentGame ...");
    try {
      final response = await httpServices.get(
        url: API.riotBaseUrl(keyRegion),
        path: path,
        origin: "CURRENTGAMEREPOSITORYP",
      );

      return response.fold((l) {
        logger.logDEBUG("Error to get Current game");
        return CurrentGameSpectator();
      }, (r) {
        logger.logDEBUG("Current game exist ...");
        return CurrentGameSpectator.fromJson(r.data);
      });
    } catch (e) {
      logger.logDEBUG("Error to get Current game");
      return CurrentGameSpectator();
    }
  }
}
