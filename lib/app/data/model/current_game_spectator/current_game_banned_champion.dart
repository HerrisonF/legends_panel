class CurrentGameBannedChampion {

  int pickTurn = 0;
  int championId = 0;
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