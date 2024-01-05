class ChampionMastery {
  int championId;
  int championLevel;
  int championPoints;
  int lastPlayTime;
  int championPointsSinceLastLevel;
  int championPointsUntilNextLevel;
  bool chestGranted;
  int tokensEarned;
  String summonerId;

  ChampionMastery({
    required this.tokensEarned,
    required this.championPointsSinceLastLevel,
    required this.championPoints,
    required this.championLevel,
    required this.summonerId,
    required this.lastPlayTime,
    required this.championId,
    required this.chestGranted,
    required this.championPointsUntilNextLevel,
  });
}
