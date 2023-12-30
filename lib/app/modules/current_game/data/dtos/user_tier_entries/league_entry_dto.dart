class LeagueEntryDTO {
  String leagueId;
  String summonerId;
  String summonerName;
  String queueType;
  String tier;
  String rank;
  int leaguePoints;
  int wins;
  int losses;
  bool hotStreak;
  bool veteran;
  bool freshBlood;
  bool inactive;

  LeagueEntryDTO({
    required this.leagueId,
    required this.summonerId,
    required this.summonerName,
    required this.queueType,
    required this.tier,
    required this.rank,
    required this.leaguePoints,
    required this.wins,
    required this.losses,
    required this.hotStreak,
    required this.veteran,
    required this.freshBlood,
    required this.inactive,
});

  factory LeagueEntryDTO.fromJson(Map<String, dynamic> json) {
    return LeagueEntryDTO(
      leagueId: json['leagueId'] ?? "",
      summonerId: json['summonerId'] ?? "",
      summonerName: json['summonerName'] ?? "",
      queueType: json['queueType'] ?? "",
      tier: json['tier'] ?? "",
      rank: json['rank'] ?? "",
      leaguePoints: json['leaguePoints'] ?? 0,
      wins: json['wins'] ?? 0,
      losses: json['losses'] ?? 0,
      hotStreak: json['hotStreak'] ?? false,
      veteran: json['veteran'] ?? false,
      freshBlood: json['freshBlood'] ?? false,
      inactive: json['inactive'] ?? false,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'leagueId' : leagueId,
      'summonerId' : summonerId,
      'summonerName' : summonerName,
      'queueType' :queueType,
      'tier' : tier,
      'rank' : rank,
      'leaguePoints' : leaguePoints,
      'wins' : wins,
      'losses' : losses,
      'hotStreak' : hotStreak,
      'veteran' : veteran,
      'freshBlood' : freshBlood,
      'inactive' : inactive,
    };
  }
}
