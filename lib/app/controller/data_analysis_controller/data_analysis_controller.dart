import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/profile_controller/profile_controller.dart';
import 'package:legends_panel/app/data/repository/data_analysis_repository/data_analysis_repository.dart';
import 'package:legends_panel/app/model/data_analysis/data_analysis_model.dart';
import 'package:legends_panel/app/model/data_analysis/game_time_line_model.dart';
import 'package:legends_panel/app/model/general/champion.dart';
import 'package:legends_panel/app/model/general/match_detail.dart';

class DataAnalysisController {
  MatchDetail matchDetail = MatchDetail();
  Champion champion = Champion();
  Participant participant = Participant();
  Participant selectedParticipant = Participant();
  DataAnalysisRepository dataAnalysisRepository = DataAnalysisRepository();
  GameTimeLineModel gameTimeLineModel = GameTimeLineModel();
  DataAnalysisModel dataAnalysisModel = DataAnalysisModel();
  String participantIdOnTimeLine = "";

  List<Frame> gameFrames = [];

  final ProfileController _profileController = Get.find<ProfileController>();
  final MasterController _masterController = Get.find<MasterController>();

  getGameTimeLine(
    String matchId,
    String keyRegion,
    Participant participant,
  ) async {
    this.participant = participant;
    if (_profileController.isUserGreaterThanGold()) {
      gameTimeLineModel =
          await dataAnalysisRepository.getGameTimeLine(matchId, keyRegion);
      buildModelForAnalytics(gameTimeLineModel);
    }
    //Procurar os dados necessários na timeline
    // e montar o objeto de análise de build
    // mas monta-lo aplicando algumas regras de intervalo, elo, posicao, etc
    //e enviar para a nuvem
    // quando o cara entrar na tela de build, ira puxar do firebase
  }

  buildModelForAnalytics(GameTimeLineModel gameTimeLineModel) {
    selectedParticipant = getCurrentUser();
    participantIdOnTimeLine =
        getParticipantIdOnTimeLineByPUUID(selectedParticipant);
    setGameFrames();
    setChampion();
    setWinOrLose();
    setChampionPosition();
    setTotalGames();

  }

  setTotalGames(){
    dataAnalysisModel.totalGames++;
  }

  setChampionPosition() {
    var positions = dataAnalysisModel.positions.where(
        (element) => element.toLowerCase() == participant.individualPosition);
    if(positions.length > 0){

    }else{
      dataAnalysisModel.positions.add(participant.individualPosition);
    }
  }

  setGameFrames() {
    for (Frame frame in gameTimeLineModel.gameInfo.frames) {
      var participant = frame.participantFrames
          .where((element) => element.participantId == participantIdOnTimeLine);
      if (participant.length > 0) {
        gameFrames.add(frame);
      }
    }
  }

  setWinOrLose() {
    if (participant.win) {
      dataAnalysisModel.amountWinLoseStatistic.amountWin++;
    } else {
      dataAnalysisModel.amountWinLoseStatistic.amountLoss++;
    }
  }

  setChampion() {
    dataAnalysisModel.champion =
        _masterController.getChampionById(selectedParticipant.championId);
    dataAnalysisModel.collectionChampionId =
        dataAnalysisModel.champion.detail.id;
  }

  Participant getCurrentUser() {
    return matchDetail.matchInfo.participants
        .where((element) => element.summonerId == participant.summonerId)
        .first;
  }

  String getParticipantIdOnTimeLineByPUUID(Participant participant) {
    var participants = gameTimeLineModel.gameInfo.participants
        .where((element) => element.puuId == participant.puuid);
    if (participants.length > 0) {
      return participants.first.participantId;
    } else {
      return "";
    }
  }
}
