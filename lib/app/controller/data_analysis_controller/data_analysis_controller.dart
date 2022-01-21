import 'package:get/get.dart';
import 'package:legends_panel/app/constants/string_constants.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/profile_controller/profile_controller.dart';
import 'package:legends_panel/app/data/repository/data_analysis_repository/data_analysis_repository.dart';
import 'package:legends_panel/app/model/data_analysis/data_analysis_model.dart';
import 'package:legends_panel/app/model/data_analysis/game_time_line_model.dart';
import 'package:legends_panel/app/model/general/champion.dart';
import 'package:legends_panel/app/model/general/map_mode.dart';
import 'package:legends_panel/app/model/general/match_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataAnalysisController {
  MatchDetail matchDetail = MatchDetail();
  Participant participant = Participant();
  DataAnalysisRepository dataAnalysisRepository = DataAnalysisRepository();
  GameTimeLineModel gameTimeLineModel = GameTimeLineModel();
  DataAnalysisModel dataAnalysisModel = DataAnalysisModel();
  String participantIdOnTimeLine = "";
  MapMode mapMode = MapMode();

  List<Frame> gameFrames = [];
  List<GameEvent> gameEvents = [];

  final ProfileController _profileController = Get.find<ProfileController>();
  final MasterController _masterController = Get.find<MasterController>();

  getGameTimeLine(
    String matchId,
    String keyRegion,
    Participant participant,
      MapMode mapMode,
  ) async {
    this.participant = participant;
    this.mapMode = mapMode;
    if (_profileController.isUserGreaterThanGold() && isOnSoloRanked()) {
      gameTimeLineModel =
          await dataAnalysisRepository.getGameTimeLine(matchId, keyRegion);
      buildModelForAnalytics(gameTimeLineModel);
    }
  }

  bool isOnSoloRanked(){
    return mapMode.description.toLowerCase().contains('ranked solo');
  }

  buildModelForAnalytics(GameTimeLineModel gameTimeLineModel) {
    participantIdOnTimeLine =
        getParticipantIdOnTimeLineByPUUID(participant);
    setGameFrames();
    setChampion();
    setWinOrLose();
    setChampionPosition();
    setChampionBuild();
    saveDataOnFirebase();

    //Até aqui tem o caminho construido, agora é apenas ajustar tudo e  os ToJson para salvar
  }

  saveDataOnFirebase(){
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference champions = firestore.collection('champions');
    addChampion(champions);
  }

  Future<void> addChampion(CollectionReference champions) {
    // Call the user's CollectionReference to add a new user
    return champions
        .add(DataAnalysisModel().toJson())
        .then((value) => print("Champion Adicionado"))
        .catchError((error) => print("Failed to add champion: $error"));
  }

  setChampionBuild(){
    //procurar pelos 3 primeiros itens fechados
    //provavelmente terei que procurar pelo tempo da partida até localizar
    for(Frame frame in gameFrames){
      for(GameEvent gameEvent in frame.events){
        if(gameEvent.boughtItem()){
          Item item = Item();
          item.id = gameEvent.itemId.toString();
          dataAnalysisModel.statisticOnPosition.statisticBuild.coreItems.items.add(item);
        }
        if(gameEvent.levelUp()){
          Skill skill = Skill();
          skill.skillSlot = gameEvent.skillSlot.toString();
          dataAnalysisModel.statisticOnPosition.statisticSkill.skillsOrder.add(skill);
        }
      }
    }
  }

  setWinOrLose(){
    dataAnalysisModel.amountWinLoseStatistic.setWinOrLose(participant.win);
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
          .where((element) => element.participantId.toString() == participantIdOnTimeLine.toString());
      if (participant.length > 0) {
        gameFrames.add(frame);
      }
    }
  }

  setChampion() {
    dataAnalysisModel.collectionChampionId = participant.championId.toString();
  }

  String getParticipantIdOnTimeLineByPUUID(Participant participant) {
    var participants = gameTimeLineModel.gameInfo.participants
        .where((element) => element.puuId == participant.puuid);
    if (participants.length > 0) {
      return participants.first.participantId.toString();
    } else {
      return "";
    }
  }
}
