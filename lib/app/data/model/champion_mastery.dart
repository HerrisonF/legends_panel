class ChampionMastery {
  int championId = 0;
  int championLevel = 0;
  int championPoints = 0;
  int lastPlayTime = 0;
  int championPointsSinceLastLevel = 0;
  int championPointsUntilNextLevel = 0;
  bool chestGranted = false;
  int tokensEarned = 0;
  String summonerId = "";

  ChampionMastery({
    this.championId = 0,
    this.championLevel = 0,
    this.championPoints = 0,
    this.lastPlayTime = 0,
    this.championPointsSinceLastLevel = 0,
    this.championPointsUntilNextLevel = 0,
    this.chestGranted = false,
    this.tokensEarned = 0,
    this.summonerId = "",
  });

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
}
