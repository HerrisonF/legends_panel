class UserTier {
  String leagueId = "";
  String summonerId = "";
  String summonerName = "";
  String queueType = "";
  String tier = "";
  String rank = "";
  dynamic leaguePoints = 0;
  dynamic wins = 0;
  dynamic losses = 0;
  bool hotStreak = false;
  bool veteran = false;
  bool freshBlood = false;
  bool inactive = false;
  String winRate = "";

  UserTier();

  UserTier.fromJson(Map<String, dynamic> json){
    leagueId = json['leagueId']??"failed";
    summonerId = json['summonerId']??"failed";
    summonerName = json['summonerName']??"failed";
    queueType = json['queueType']??"failed";
    tier = json['tier']??"failed";
    rank = json['rank']??"failed";
    leaguePoints = json['leaguePoints']??0;
    wins = json['wins']??0;
    losses = json['losses']??0;
    hotStreak = json['hotStreak']??false;
    veteran = json['veteran']??false;
    freshBlood = json['freshBlood']??false;
    inactive = json['inactive']??false;
  }

  @override
  String toString() {
    return 'UserTier{leagueId: $leagueId, summonerId: $summonerId, summonerName: $summonerName, queueType: $queueType, tier: $tier, rank: $rank, leaguePoints: $leaguePoints, wins: $wins, losses: $losses, hotStreak: $hotStreak, veteran: $veteran, freshBlood: $freshBlood, inactive: $inactive}';
  }
}