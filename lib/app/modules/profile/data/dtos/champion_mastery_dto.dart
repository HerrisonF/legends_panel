class ChampionMasteryDTO {
  String puuid;
  int championPointsUntilNextLevel;
  int championId;
  int lastPlayTime;
  int championLevel;
  int championPoints;
  int championPointsSinceLastLevel;
  int tokensEarned;

  ChampionMasteryDTO({
    required this.puuid,
    required this.championPointsUntilNextLevel,
    required this.championId,
    required this.lastPlayTime,
    required this.championLevel,
    required this.championPoints,
    required this.championPointsSinceLastLevel,
    required this.tokensEarned,
  });

  factory ChampionMasteryDTO.fromJson(Map<String, dynamic> json){
    return ChampionMasteryDTO(
      championId: json['championId'],
      puuid: json['puuid'],
      championLevel: json['championLevel'],
      championPoints: json['championPoints'],
      championPointsSinceLastLevel: json['championPointsSinceLastLevel'],
      championPointsUntilNextLevel: json['championPointsUntilNextLevel'],
      lastPlayTime: json['lastPlayTime'],
      tokensEarned: json['tokensEarned'],
    );
  }
}
