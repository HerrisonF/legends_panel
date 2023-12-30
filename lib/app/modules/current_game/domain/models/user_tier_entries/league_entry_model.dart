class LeagueEntryModel {
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

  LeagueEntryModel({
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
}