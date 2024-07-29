import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/champion_model.dart';

class ChampionMasteryModel {
  int championId;
  int championLevel;
  int championPoints;
  int lastPlayTime;
  int championPointsSinceLastLevel;
  int championPointsUntilNextLevel;
  int tokensEarned;
  ChampionModel? championModel;

  ChampionMasteryModel({
    required this.tokensEarned,
    required this.championPointsSinceLastLevel,
    required this.championPoints,
    required this.championLevel,
    required this.lastPlayTime,
    required this.championId,
    required this.championPointsUntilNextLevel,
  });

  setChampion(ChampionModel receivedChampion) {
    championModel = ChampionModel(
      version: receivedChampion.version,
      id: receivedChampion.id,
      key: receivedChampion.key,
      name: receivedChampion.name,
      title: receivedChampion.title,
      blurb: receivedChampion.blurb,
      info: receivedChampion.info,
      image: receivedChampion.image,
      tags: receivedChampion.tags,
      partype: receivedChampion.partype,
      stats: receivedChampion.stats,
    );
  }
}
