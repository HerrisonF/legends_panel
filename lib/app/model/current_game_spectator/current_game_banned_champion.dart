class CurrentGameBannedChampion {

  /// The turn during which the champion was banned
  int pickTurn = 0;
  /// The ID of the banned champion
  int championId = 0;
  /// The ID of the team that banned the champion
  int teamId = 0;

  CurrentGameBannedChampion();

  CurrentGameBannedChampion.fromJson(Map<String, dynamic> json){
    pickTurn = json['pickTurn'] ?? 0;
    championId = json['championId'] ?? 0;
    teamId = json['teamId'] ?? 0;
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = Map<String, dynamic>();
    data['pickTurn'] = pickTurn;
    data['championId'] = championId;
    data['teamId'] = teamId;
    return data;
  }

  @override
  String toString() {
    return 'BannedChampion{pickTurn: $pickTurn, championId: $championId, teamId: $teamId}';
  }
}