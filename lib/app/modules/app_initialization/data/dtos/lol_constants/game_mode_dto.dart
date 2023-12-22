class GameModeDTO {
  String gameMode;
  String description;

  GameModeDTO({
    required this.gameMode,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'gameMode': gameMode,
      'descriptions': description,
    };
  }

  factory GameModeDTO.fromJson(Map<String, dynamic> json) {
    return GameModeDTO(
      gameMode: json['gameMode'] ?? 0,
      description: json['descriptions'] ?? '',
    );
  }
}
