import 'package:get/get.dart';
import 'package:legends_panel/app/data/model/match_detail.dart';
import 'package:legends_panel/app/data/repository/game_detail_repository.dart';

class GameDetailController {

  GameDetailRepository _gameDetailRepository = GameDetailRepository();

  Rx<MatchDetail> matchDetail = MatchDetail().obs;

  getMatchDetail(String gameId) async {
    matchDetail.value = await _gameDetailRepository.getMatchDetail(gameId);
    matchDetail.refresh();
  }

}