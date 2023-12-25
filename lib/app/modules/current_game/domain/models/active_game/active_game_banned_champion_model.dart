class ActiveGameBannedChampionModel {
  /// The turn during which the champion was banned
  int pickTurn = 0;

  /// The ID of the banned champion
  int championId = 0;

  /// The ID of the team that banned the champion
  int teamId = 0;

  ActiveGameBannedChampionModel({
    required this.pickTurn,
    required this.championId,
    required this.teamId,
  });
}
