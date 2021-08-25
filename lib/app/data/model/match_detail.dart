class MatchDetail {
  int gameId = 0;
  String platformId = "";
  int gameCreation = 0;
  int gameDuration = 0;
  int queueId = 0;
  int mapId = 0;
  int seasonId = 0;
  String gameVersion = "";
  String gameMode = "";
  String gameType = "";
  List<Team> teams = [];

  MatchDetail({
    this.gameId = 0,
    this.platformId = "",
    this.gameCreation = 0,
    this.gameDuration = 0,
    this.queueId = 0,
    this.mapId = 0,
    this.seasonId = 0,
    this.gameVersion = "",
    this.gameMode = "",
    this.gameType = "",
    this.teams = const [],
  });

  MatchDetail.fromJson(Map<String, dynamic> json) {
    gameId = json['gameId'] ?? 0;
    platformId = json['platformId'] ?? "";
    gameCreation = json['gameCreation'] ?? 0;
    gameDuration = json['gameDuration'] ?? 0;
    queueId = json['queueId'] ?? 0;
    mapId = json['mapId'] ?? 0;
    seasonId = json['seasonId'] ?? 0;
    gameVersion = json['gameVersion'] ?? "";
    gameMode = json['gameMode'] ?? "";
    gameType = json['gameType'] ?? "";
    if (json['teams'] != null) {
      json['teams'].forEach((team) {
        teams.add(Team.fromJson(team));
      });
    }
  }
}

class Team {
  int teamId = 0;
  String win = "";
  bool firstBlood = false;
  bool firstTower = false;
  bool firstInhibitor = false;
  bool firstBaron = false;
  bool firstDragon = false;
  bool firstRiftHerald = false;
  int towerKills = 0;
  int inhibitorKills = 0;
  int baronKills = 0;
  int dragonKills = 0;
  int vilemawKills = 0;
  int riftHeraldKills = 0;
  int dominionVictoryScore = 0;
  List<Ban> bans = [];

  Team.fromJson(Map<String, dynamic> json) {
    teamId = json['teamId'] ?? 0;
    win = json['win'] ?? "";
    firstBlood = json['firstBlood'] ?? false;
    firstTower = json['firstTower'] ?? false;
    firstInhibitor = json['firstInhibitor'] ?? false;
    firstBaron = json['firstBaron'] ?? false;
    firstDragon = json['firstDragon'] ?? false;
    firstRiftHerald = json['firstRiftHerald'] ?? false;
    towerKills = json['towerKills'] ?? 0;
    inhibitorKills = json['inhibitorKills'] ?? 0;
    baronKills = json['baronKills'] ?? 0;
    dragonKills = json['dragonKills'] ?? 0;
    vilemawKills = json['viewmawKills'] ?? 0;
    riftHeraldKills = json['riftHeraldKills'] ?? 0;
    dominionVictoryScore = json['dominionVictoryScore'] ?? 0;
    if (json['bans'] != null) {
      json['bans'].forEach((ban) {
        bans.add(Ban.fromJson(ban));
      });
    }
  }
}

class Ban {
  int championId = 0;
  int pickTurn = 0;

  Ban.fromJson(Map<String, dynamic> json) {
    championId = json['championId'] ?? 0;
    pickTurn = json['pickTurn'] ?? 0;
  }
}
