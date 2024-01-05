class ChampionMasteryDTO {
  String puuid;
  int championPointsUntilNextLevel;
  bool chestGranted;
  int championId;
  int lastPlayTime;
  int championLevel;
  String summonerId;
  int championPoints;
  int championPointsSinceLastLevel;
  int tokensEarned;

  ChampionMasteryDTO({
    required this.puuid,
    required this.championPointsUntilNextLevel,
    required this.chestGranted,
    required this.championId,
    required this.lastPlayTime,
    required this.summonerId,
    required this.championLevel,
    required this.championPoints,
    required this.championPointsSinceLastLevel,
    required this.tokensEarned,
  });

  factory ChampionMasteryDTO.fromJson(Map<String, dynamic> json){
    return ChampionMasteryDTO(
      summonerId: json['summonerId'],
      championId: json['championId'],
      puuid: json['puuid'],
      championLevel: json['championLevel'],
      championPoints: json['championPoints'],
      championPointsSinceLastLevel: json['championPointsSinceLastLevel'],
      championPointsUntilNextLevel: json['championPointsUntilNextLevel'],
      chestGranted: json['chestGranted'],
      lastPlayTime: json['lastPlayTime'],
      tokensEarned: json['tokensEarned'],
    );
  }
}
