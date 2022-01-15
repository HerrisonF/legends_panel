import 'package:legends_panel/app/data/provider/data_analysis_provider/data_analysis_provider.dart';
import 'package:legends_panel/app/model/data_analysis/game_time_line_model.dart';

class DataAnalysisRepository {

  DataAnalysisProvider dataAnalysisProvider = DataAnalysisProvider();

  Future<GameTimeLineModel> getGameTimeLine(String matchId, String keyRegion){
    return dataAnalysisProvider.getGameTimeLine(matchId, keyRegion);
  }

}