class ChampionMastery {
  dynamic championId = 0;
  dynamic championLevel = 0;
  dynamic championPoints = 0;
  dynamic lastPlayTime = 0;
  dynamic championPointsSinceLastLevel = 0;
  dynamic championPointsUntilNextLevel = 0;
  dynamic chestGranted = false;
  dynamic tokensEarned = 0;
  dynamic summonerId = "";

  ChampionMastery();

  ChampionMastery.fromJson(Map<String, dynamic> json){
    championId = json['championId']??0;
    championLevel = json['championLevel']??0;
    championPoints = json['championPoints']??0;
    lastPlayTime = json['lastPlayTime']??0;
    championPointsSinceLastLevel = json['championPointsSinceLastLevel']??0;
    championPointsUntilNextLevel = json['championPointsUntilNextLevel']??0;
    chestGranted = json['chestGranted']?? false;
    tokensEarned = json['tokensEarned']?? 0;
    summonerId = json['summonerId']??"";
  }

  @override
  String toString() {
    return 'ChampionMastery{championId: $championId, championLevel: $championLevel, championPoints: $championPoints, lastPlayTime: $lastPlayTime, championPointsSinceLastLevel: $championPointsSinceLastLevel, championPointsUntilNextLevel: $championPointsUntilNextLevel, chestGranted: $chestGranted, tokensEarned: $tokensEarned, summonerId: $summonerId}';
  }
}
