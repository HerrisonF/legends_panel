import 'package:legends_panel/app/core/http_configuration/api_endpoints.dart';
import 'package:legends_panel/app/modules/current_game/data/repositories/active_game_result_repository/active_game_result_repository.dart';

class ActiveGameResultRepositoryImpl extends ActiveGameResultRepository {
  @override
  String getTierMiniEmblemUrl({
    required String tier,
  }) {
    final String path = "/latest/plugins/rcp-fe-lol-static-assets/"
        "global/default/images/ranked-mini-crests/${tier.toLowerCase()}.png";
    try {
      return API.rawDataDragonUrl + path;
    } catch (e) {
      return "";
    }
  }

  @override
  String getUnrankedTierMiniEmblemUrl() {
    return 'https://raw.communitydragon.org/latest/plugins/'
        'rcp-fe-lol-static-assets/global/default/images/'
        'ranked-mini-crests/unranked.png';
  }
}
