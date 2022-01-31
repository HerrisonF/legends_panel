import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/profile_controller/profile_controller.dart';
import 'package:legends_panel/app/data/repository/data_analysis_repository/data_analysis_repository.dart';
import 'package:legends_panel/app/model/data_analysis/data_analysis_model.dart';
import 'package:legends_panel/app/model/data_analysis/game_time_line_model.dart';
import 'package:legends_panel/app/model/data_analysis/participant_and_event.dart';
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

  ParticipantAndEvent participantAndEvents = ParticipantAndEvent();

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
    if (_profileController.isUserGreaterThanGold() && isOnSoloRanked() && championIsGreaterThanEighteen()) {
      gameTimeLineModel =
          await dataAnalysisRepository.getGameTimeLine(matchId, keyRegion);
      buildModelForAnalytics(gameTimeLineModel);
    }
  }

  static const MAX_LEVEL_CHAMPION = 18;

  bool championIsGreaterThanEighteen(){
    return participant.champLevel == MAX_LEVEL_CHAMPION;
  }

  bool isOnSoloRanked() {
    return mapMode.description.toLowerCase().contains('ranked solo');
  }

  buildModelForAnalytics(GameTimeLineModel gameTimeLineModel) {
    participantIdOnTimeLine = getParticipantIdOnTimeLineByPUUID(participant);
    setGameFrames();
    setChampion();
    setWinOrLose();
    setChampionPosition();
    setChampionBuild();
    setRunes();
    setSpells();
    saveDataOnFirebase();
  }

  setRunes(){
    dataAnalysisModel.statisticOnPosition.statisticRune.perk = participant.perk;
  }

  setSpells(){
    dataAnalysisModel.statisticOnPosition.statisticSpell.spell.spellId1 = participant.summoner1Id.toString();
    dataAnalysisModel.statisticOnPosition.statisticSpell.spell.spellId2 = participant.summoner2Id.toString();
  }

  saveDataOnFirebase() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference champions = firestore.collection('champions');
    //agora preciso verificar na arvore o id do champion e verificar se o champion que está
    //sendo buildado é o mesmo recuperado para poder concatenar valores ou criar um novo
    addChampion(champions);
  }

  Future<void> addChampion(CollectionReference champions) {
    return champions.doc(dataAnalysisModel.collectionChampionId.toString()).set
        (dataAnalysisModel.toJson())
        .then((value) => print("Champion Adicionado"))
        .catchError((error) => print("Failed to add champion: $error"));
  }

  setChampionBuild() {
    //procurar pelos 3 primeiros itens fechados
    //provavelmente terei que procurar pelo tempo da partida até localizar
    for (GameEvent gameEvent in participantAndEvents.gameEvent) {
      if (gameEvent.boughtItem()) {
        Item item = Item();
        item.id = gameEvent.itemId.toString();
        var itemTemp = dataAnalysisModel
            .statisticOnPosition.statisticBuild.coreItems.items
            .where((element) => element.id.toString() == item.id.toString());
        if (itemTemp.length > 0) {
        } else {
          dataAnalysisModel.statisticOnPosition.statisticBuild.coreItems.items
              .add(item);
        }
      }
      if (gameEvent.levelUp()) {
        Skill skill = Skill();
        skill.skillSlot = gameEvent.skillSlot.toString();
        dataAnalysisModel.statisticOnPosition.statisticSkill.skillsOrder
            .add(skill);
      }
    }
  }

  setWinOrLose() {
    dataAnalysisModel.amountWinLoseStatistic.setWinOrLose(participant.win);
  }

  setChampionPosition() {
    var positions = dataAnalysisModel.positions.where((element) =>
        element.toLowerCase() == participant.individualPosition.toString().toLowerCase());
    if (positions.length > 0) {
    } else {
      dataAnalysisModel.positions.add(participant.individualPosition);
    }
  }

  setGameFrames() {
    for (Frame frame in gameTimeLineModel.gameInfo.frames) {
      var participant = frame.participantFrames.where((element) =>
          element.participantId.toString() ==
          participantIdOnTimeLine.toString());
      var event = frame.events.where((element) =>
          element.participantId.toString() ==
          participantIdOnTimeLine.toString());

      if (participant.length > 0) {
        participantAndEvents.participantFrame.add(participant.first);
      }
      if (event.length > 0) {
        participantAndEvents.gameEvent.addAll(event);
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
