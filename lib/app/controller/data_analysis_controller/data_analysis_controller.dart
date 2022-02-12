import 'package:get/get.dart';
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

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  ChampionStatistic championStatistic = ChampionStatistic();

  BuildOnPosition buildOnPosition = BuildOnPosition();

  String participantIdOnTimeLine = "";
  MapMode mapMode = MapMode();

  ParticipantAndEvent participantAndEvents = ParticipantAndEvent();

  final ProfileController _profileController = Get.find<ProfileController>();
  //final MasterController _masterController = Get.find<MasterController>();

  getGameTimeLine(
    String matchId,
    String keyRegion,
    Participant participant,
    MapMode mapMode,
  ) async {
    clean();
    this.participant = participant;
    this.mapMode = mapMode;
    if (_profileController.isUserGreaterThanGold() &&
        isOnSoloRanked() &&
        championIsGreaterThanEighteen()) {
      gameTimeLineModel =
          await dataAnalysisRepository.getGameTimeLine(matchId, keyRegion);
      buildModelForAnalytics(gameTimeLineModel);
    }
  }

  clean(){
    participant = Participant();
    gameTimeLineModel = GameTimeLineModel();
    championStatistic = ChampionStatistic();
    buildOnPosition = BuildOnPosition();
    participantIdOnTimeLine = "";
    mapMode = MapMode();
    participantAndEvents = ParticipantAndEvent();
  }

  static const MAX_LEVEL_CHAMPION = 17;

  bool championIsGreaterThanEighteen() {
    return participant.champLevel >= MAX_LEVEL_CHAMPION;
  }

  bool isOnSoloRanked() {
    return mapMode.description.toLowerCase().contains('ranked solo');
  }

  buildModelForAnalytics(GameTimeLineModel gameTimeLineModel) {
    cleanCache();
    participantIdOnTimeLine = getParticipantIdOnTimeLineByPUUID(participant);
    setGameFrames(); // procura os frames desse participante
    setChampionBuild();
    setRunes();
    setSpells();
    lookOnCloudForChampion();
  }

  cleanCache(){
    championStatistic = ChampionStatistic();
    buildOnPosition = BuildOnPosition();
    String participantIdOnTimeLine = "";
  }

  lookOnCloudForChampion() {
    CollectionReference champions = firestore.collection('champions');
    champions
        .doc(participant.championId.toString())
        .get()
        .then((champValue) => checkPositionsToAddStatistic(champValue))
        .catchError((error) => print("Failed to get champions: $error"));
  }

  checkPositionsToAddStatistic(var champValue) {
    if (champValue.data() != null) {
      championStatistic = ChampionStatistic.fromJson(champValue.data());
      bool hasPosition = false;
      for (int i = 0; i < championStatistic.positions.length - 1; i++) {
        if (championStatistic.positions[i].name.toLowerCase() ==
            participant.individualPosition.toString().toLowerCase()) {
          championStatistic.positions[i].amountPick++;
          hasPosition = true;
          _checkBuildIsIdentical(i);
        }
      }
      if (!hasPosition) {
        PositionData positionData = PositionData();
        positionData.name =
            participant.individualPosition.toString().toLowerCase();
        positionData.amountPick = 1;
        buildOnPosition.amountPick++;
        if(participant.win){
          buildOnPosition.amountWin++;
        }
        positionData.builds.add(buildOnPosition);
        championStatistic.championId = participant.championId.toString();
        championStatistic.positions.add(positionData);
      }
    } else {
      PositionData positionData = PositionData();
      positionData.name =
          participant.individualPosition.toString().toLowerCase();
      positionData.amountPick = 1;
      buildOnPosition.amountPick++;
      if(participant.win){
        buildOnPosition.amountWin++;
      }
      positionData.builds.add(buildOnPosition);
      championStatistic.championId = participant.championId.toString();
      championStatistic.positions.add(positionData);
    }
    _saveBuild();
  }

  _saveBuild() {
    CollectionReference champions = firestore.collection('champions');
    champions
        .doc(participant.championId.toString())
        .set(championStatistic.toJson())
        .then((value) => print("Champion salvo"))
        .onError((error, stackTrace) => print("erro ao salvar champion"));
  }

  _checkBuildIsIdentical(int index) {
    bool hasOneIdentical = false;
    for (int i = 0; i < championStatistic.positions[index].builds.length - 1; i++) {
      if (isDataIdentical(
          buildOnPosition, championStatistic.positions[index].builds[i])) {
        hasOneIdentical = true;
        _incrementCountBuildValueAndSave(index, i);
      }
    }
    if (!hasOneIdentical) {
      championStatistic.positions[index].builds.add(buildOnPosition);
    }
  }

  _incrementCountBuildValueAndSave(int index, index2) {
    championStatistic.positions[index].builds[index2].amountPick++;
    if(participant.win){
      championStatistic.positions[index].builds[index2].amountWin++;
    }
  }

  setRunes() {
    buildOnPosition.selectedRune.perk = participant.perk;
  }

  setSpells() {
    buildOnPosition.selectedSpell.spell.spellId1 =
        participant.summoner1Id.toString();
    buildOnPosition.selectedSpell.spell.spellId2 =
        participant.summoner2Id.toString();
  }

  bool isDataIdentical(
      BuildOnPosition localChampion, BuildOnPosition cloudChampion) {
    bool isIdentical = true;
    if (localChampion.selectedSpell.spell.spellId1 !=
        cloudChampion.selectedSpell.spell.spellId1) {
      print(
          "A spellId1 difere ${localChampion.selectedSpell.spell.spellId1} - ${cloudChampion.selectedSpell.spell.spellId1}");
      isIdentical = false;
    }

    if (localChampion.selectedSpell.spell.spellId2 !=
        cloudChampion.selectedSpell.spell.spellId2) {
      print(
          "A spellId2 difere ${localChampion.selectedSpell.spell.spellId2} - ${cloudChampion.selectedSpell.spell.spellId2}");
      isIdentical = false;
    }

    if (localChampion.selectedRune.perk.statPerks.defense !=
        cloudChampion.selectedRune.perk.statPerks.defense) {
      print(
          "A perk de defense difere ${localChampion.selectedRune.perk.statPerks.defense} - ${cloudChampion.selectedRune.perk.statPerks.defense}");
      isIdentical = false;
    }
    if (localChampion.selectedRune.perk.statPerks.flex !=
        cloudChampion.selectedRune.perk.statPerks.flex) {
      print(
          "A perk de flex difere ${localChampion.selectedRune.perk.statPerks.flex} - ${cloudChampion.selectedRune.perk.statPerks.flex}");
      isIdentical = false;
    }

    if (localChampion.selectedRune.perk.statPerks.offense !=
        localChampion.selectedRune.perk.statPerks.offense) {
      print(
          "A perk de offense difere ${localChampion.selectedRune.perk.statPerks.offense} - ${localChampion.selectedRune.perk.statPerks.offense}");
      isIdentical = false;
    }

    for (int i = 0; i < localChampion.selectedRune.perk.styles.length; i++) {
      if (localChampion.selectedRune.perk.styles[i].style !=
          cloudChampion.selectedRune.perk.styles[i].style) {
        print(
            "Style difere ${localChampion.selectedRune.perk.styles[i].style}  - ${cloudChampion.selectedRune.perk.styles[i].style}");
        isIdentical = false;
      }
      for (int i = 0;
          i < localChampion.selectedRune.perk.styles[i].selections.length - 1;
          i++) {
        if (localChampion.selectedRune.perk.styles[i].selections[i].perk !=
            cloudChampion.selectedRune.perk.styles[i].selections[i].perk) {
          print(
              "Selections perk difere ${localChampion.selectedRune.perk.styles[i].selections[i].perk}  - ${cloudChampion.selectedRune.perk.styles[i].selections[i].perk} ");
          isIdentical = false;
        }
        if (localChampion.selectedRune.perk.styles[i].selections[i].var1 !=
            cloudChampion.selectedRune.perk.styles[i].selections[i].var1) {
          print(
              "Selections var1 difere ${localChampion.selectedRune.perk.styles[i].selections[i].var1}  - ${cloudChampion.selectedRune.perk.styles[i].selections[i].var1}");
          isIdentical = false;
        }
        if (localChampion.selectedRune.perk.styles[i].selections[i].var2 !=
            cloudChampion.selectedRune.perk.styles[i].selections[i].var2) {
          print(
              "Selections var2 difere ${localChampion.selectedRune.perk.styles[i].selections[i].var2}  - ${cloudChampion.selectedRune.perk.styles[i].selections[i].var2} ");
          isIdentical = false;
        }
        if (localChampion.selectedRune.perk.styles[i].selections[i].var3 !=
            cloudChampion.selectedRune.perk.styles[i].selections[i].var3) {
          print(
              "Selections var3 difere ${localChampion.selectedRune.perk.styles[i].selections[i].var3}  - ${cloudChampion.selectedRune.perk.styles[i].selections[i].var3} ");
          isIdentical = false;
        }
      }
    }

    // obs: as skills podem diferenciar conforme o jogo, mas nem sempre a build.
    // isso é importante para verificar que talvez os dados tenham q ser mais
    // independentes um do outro

    for (int i = 0; i < localChampion.selectedSkill.skillsOrder.length; i++) {
      if (localChampion.selectedSkill.skillsOrder[i].skillSlot !=
          cloudChampion.selectedSkill.skillsOrder[i].skillSlot) {
        print(
            "A skill $i difere ${localChampion.selectedSkill.skillsOrder[i].skillSlot}  - ${cloudChampion.selectedSkill.skillsOrder[i].skillSlot}");
        isIdentical = false;
      }
    }

    for (int i = 0;
        i < localChampion.selectedBuild.selectedItems.items.length;
        i++) {
      if (localChampion.selectedBuild.selectedItems.items[i].id !=
          cloudChampion.selectedBuild.selectedItems.items[i].id) {
        print(
            "O item $i difere ${localChampion.selectedBuild.selectedItems.items[i].id}  - ${cloudChampion.selectedBuild.selectedItems.items[i].id}");
        isIdentical = false;
      }
    }

    return isIdentical;
  }

  setChampionBuild() {
    //procurar pelos 3 primeiros itens fechados
    //provavelmente terei que procurar pelo tempo da partida até localizar
    for (GameEvent gameEvent in participantAndEvents.gameEvent) {
      if (gameEvent.boughtItem()) {
        Item item = Item();
        item.id = gameEvent.itemId.toString();
        var itemTemp = buildOnPosition.selectedBuild.selectedItems.items
            .where((element) => element.id.toString() == item.id.toString());
        if (itemTemp.length > 0) {
        } else {
          buildOnPosition.selectedBuild.selectedItems.items.add(item);
        }
      }
      if (gameEvent.levelUp()) {
        Skill skill = Skill();
        skill.skillSlot = gameEvent.skillSlot.toString();
        buildOnPosition.selectedSkill.skillsOrder.add(skill);
      }
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
