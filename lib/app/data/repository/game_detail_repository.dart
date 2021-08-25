import 'package:legends_panel/app/data/model/match_detail.dart';
import 'package:legends_panel/app/data/provider/game_detail_provider.dart';

class GameDetailRepository {

  GameDetailProvider _gameDetailProvider = GameDetailProvider();

  Future<MatchDetail> getMatchDetail(String matchId){
    return _gameDetailProvider.getMatchDetail(matchId);
  }

}