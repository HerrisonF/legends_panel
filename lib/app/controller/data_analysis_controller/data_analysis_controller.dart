import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/data/repository/data_analysis_repository/data_analysis_repository.dart';
import 'package:legends_panel/app/model/data_analysis/game_time_line_model.dart';
import 'package:legends_panel/app/model/general/champion.dart';
import 'package:legends_panel/app/model/general/match_detail.dart';

class DataAnalysisController {

  MatchDetail matchDetail = MatchDetail();
  Champion champion = Champion();
  Participant participant = Participant();
  DataAnalysisRepository dataAnalysisRepository = DataAnalysisRepository();
  GameTimeLineModel gameTimeLineModel = GameTimeLineModel();

  // final MasterController _masterController = Get.find<MasterController>();


  getGameTimeLine(String matchId, String keyRegion) async {
    gameTimeLineModel = await dataAnalysisRepository.getGameTimeLine(matchId, keyRegion);
    //Procurar os dados necessários na timeline
    // e montar o objeto de análise de build
    // mas monta-lo aplicando algumas regras de intervalo, elo, posicao, etc
    //e enviar para a nuvem
    // quando o cara entrar na tela de build, ira puxar do firebase

  }


}