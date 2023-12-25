class ActiveGameBannedChampionDTO {
  /// The turn during which the champion was banned
  int pickTurn;

  /// The ID of the banned champion
  int championId;

  /// The ID of the team that banned the champion
  int teamId;

  ActiveGameBannedChampionDTO({
    required this.pickTurn,
    required this.championId,
    required this.teamId,
  });

  factory ActiveGameBannedChampionDTO.fromJson(Map<String, dynamic> json) {
    return ActiveGameBannedChampionDTO(
      pickTurn: json['pickTurn'] ?? 0,
      championId: json['championId'] ?? 0,
      teamId: json['teamId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pickTurn': pickTurn,
      'championId': championId,
      'teamId': teamId,
    };
  }
}
