import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/champion_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/game_language_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/game_mode_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/game_version_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/item_mother_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/mapa_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/perk_style_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/queue_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/ranked_constants.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/summoner_spell.dart';

/// Essa classe é responsável por guardar todas as constantes do lol. Cada qual
/// com seu respectivo objeto.
/// Ao requisita-la, consigo ter todas as constantes necessárias para as demais
/// requisições.
class LolConstantsModel {
  List<QueueModel>? queues;
  List<GameVersionModel>? versions;
  List<MapaModel>? maps;
  List<GameModeModel>? gameModes;
  List<GameLanguageModel>? gameLanguages;
  List<ChampionModel>? champions;
  List<SummonerSpell>? spells;
  List<PerkStyleModel>? perks;
  ItemMotherModel? itemMotherModel;
  RankedConstants? rankedConstants;

  List<String> regions = [
    'BR1',
    'EUN1',
    'EUW1',
    'JP1',
    'KR',
    'LA1',
    'LA2',
    'NA1',
    'OC1',
    'TR1',
    'RU',
    'PH2',
    'SG2',
    'TH2',
    'TW2',
    'VN2',
  ];

  LolConstantsModel({
    this.queues,
    this.versions,
    this.maps,
    this.gameModes,
    this.champions,
    this.itemMotherModel,
    this.spells,
    this.gameLanguages,
    this.rankedConstants,
    this.perks,
  });

  setQueues(List<QueueModel> queues) {
    this.queues = [];
    this.queues!.addAll(queues);
  }

  setGameVersions(List<GameVersionModel> versions) {
    this.versions = [];
    this.versions!.addAll(versions);
  }

  setMaps(List<MapaModel> maps) {
    this.maps = [];
    this.maps!.addAll(maps);
  }

  setGameModes(List<GameModeModel> gameModes) {
    this.gameModes = [];
    this.gameModes!.addAll(gameModes);
  }

  setGameLanguages(List<GameLanguageModel> gameLanguages) {
    this.gameLanguages = [];
    this.gameLanguages!.addAll(gameLanguages);
  }

  setChampions(List<ChampionModel> champions) {
    this.champions = [];
    this.champions!.addAll(champions);
  }

  setItemMotherModel(ItemMotherModel itemMotherModel) {
    this.itemMotherModel = itemMotherModel;
  }

  setSummonerSpells(List<SummonerSpell> spells) {
    this.spells = [];
    this.spells!.addAll(spells);
  }

  setPerks(List<PerkStyleModel> perks) {
    this.perks = [];
    this.perks!.addAll(perks);
  }

  setRankedConstants() {
    rankedConstants = RankedConstants();
  }

  String getLatestLolVersion() {
    return versions!.first.version;
  }

  /// Se a localization do usuário não for encontrada nas constantes,então
  /// retorno o padrão en_US.
  String getLanguage(String localization) {
    List<GameLanguageModel> languages = gameLanguages!
        .where((element) => element.language == localization)
        .toList();
    if (languages.isNotEmpty) {
      return languages.first.language;
    }
    return "en_US";
  }

  ChampionModel? getChampionById(int id) {
    List<ChampionModel> championsTemp =
        champions!.where((element) => element.key == id.toString()).toList();
    if (championsTemp.isNotEmpty) {
      return championsTemp.first;
    }
    return null;
  }

  SummonerSpell? getSpellById(int spellId) {
    List<SummonerSpell> spellsTemp =
    spells!.where((element) => element.key == spellId.toString()).toList();
    if (spellsTemp.isNotEmpty) {
      return spellsTemp.first;
    }
    return null;
  }

  String getMapQueueById(int queueId) {
    List<QueueModel> tempQueues =
        queues!.where((queue) => queue.queueId == queueId).toList();
    if (tempQueues.isNotEmpty) {
      return tempQueues.first.getQueueDescriptionWithoutGamesString();
    }
    return "";
  }
}
