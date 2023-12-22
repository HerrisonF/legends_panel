import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/game_language_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/game_mode_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/game_version_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/mapa_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/queue_model.dart';

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

  LolConstantsModel({
    this.queues,
    this.versions,
    this.maps,
    this.gameModes,
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

  String getMapQueueById(int queueId) {
    List<QueueModel> tempQueues =
        queues!.where((queue) => queue.queueId == queueId).toList();
    if (tempQueues.isNotEmpty) {
      return tempQueues.first.getQueueDescriptionWithoutGamesString();
    }
    return "";
  }
}
