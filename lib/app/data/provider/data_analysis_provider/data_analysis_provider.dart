import 'package:legends_panel/app/data/http/config/dio_client.dart';
import 'package:legends_panel/app/data/http/config/dio_state.dart';
import 'package:legends_panel/app/data/http/config/riot_and_raw_dragon_urls.dart';
import 'package:legends_panel/app/model/data_analysis/game_time_line_model.dart';
import 'package:logger/logger.dart';

class DataAnalysisProvider {

  Logger _logger = Logger();

  Future<GameTimeLineModel> getGameTimeLine(String matchId, String keyRegion) async {
    final String path = "/lol/match/v5/matches/${keyRegion}_$matchId/timeline";
    _logger.i("Getting game time line ...");
    try{
      late DioClient tempDio;

      if(keyRegion == "KR" || keyRegion == "RU" || keyRegion == "JP1" || keyRegion == "TR1" || keyRegion == "OC1"){
        tempDio = DioClient(url: RiotAndRawDragonUrls.riotAsiaUrl);
      }
      if(keyRegion == "EUN1" || keyRegion == "EUW1" || keyRegion == "NA1"){
        tempDio = DioClient(url: RiotAndRawDragonUrls.riotEuropeUrl);
      }

      if(keyRegion == "LA1" || keyRegion == "BR1" || keyRegion.isEmpty){
        tempDio = DioClient(url: RiotAndRawDragonUrls.riotAmericasUrl);
      }
      final response = await tempDio.get(path);
      if(response.state == CustomState.SUCCESS){
        _logger.i("Success to get game time line...");
        return GameTimeLineModel.fromJson(response.result.data);
      }
    }catch(e){
      _logger.i("Error to get game time line $e");
      return GameTimeLineModel();
    }
    _logger.i("Game time line not exists ...");
    return GameTimeLineModel();
  }

}