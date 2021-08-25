class MatchList {
  int startIndex = 0;
  int totalGames = 0;
  int endIndex = 0;
  List<Match> matches = [];

  MatchList(
      {this.startIndex = 0,
      this.totalGames = 0,
      this.endIndex = 0,
      this.matches = const []});

  MatchList.fromJson(Map<String, dynamic> json) {
    startIndex = json['startIndex'] ?? 0;
    totalGames = json['totalGames'] ?? 0;
    endIndex = json['endIndex'] ?? 0;
    if (json['matches'] != null) {
      json['matches'].forEach((match) {
        matches.add(Match.fromJson(match));
      });
    }
  }
}

class Match {
  int gameId = 0;
  String role = "";
  int season = 0;
  String platform = "";
  int champion = 0;
  int queue = 0;
  String lane = "";
  int timestamp = 0;

  Match({
    this.gameId = 0,
    this.role = "",
    this.season = 0,
    this.platform = "",
    this.champion = 0,
    this.queue = 0,
    this.lane = "",
    this.timestamp = 0,
  });

  Match.fromJson(Map<String, dynamic> json){
    gameId = json['gameId']??0;
    role = json['role']??"";
    season = json['season']??0;
    platform = json['platform']??"";
    champion = json['champion']??0;
    queue = json['queue']??0;
    lane = json['lane']??"";
    timestamp = json['timestamp']??0;
  }
}
