import 'package:legends_panel/app/modules/current_game/data/dtos/active_game/active_game_banned_champion_dto.dart';
import 'package:legends_panel/app/modules/current_game/data/dtos/active_game/active_game_participant_dto.dart';

class ActiveGameInfoDTO {
  /// The ID of the game
  int gameId;

  /// The game type
  String gameType;

  /// The game start time represented in epoch milliseconds
  int gameStartTime;

  /// The ID of the map
  int mapId;

  /// The amount of time in seconds that has passed since the game started
  int gameLength;

  /// The ID of the platform on which the game is being played
  String platformId;

  /// The game mode
  String gameMode;

  /// Banned champion information
  List<ActiveGameBannedChampionDTO> activeGameBannedChampions;

  /// The queue type (queue types are documented on the Game Constants page)
  int gameQueueConfigId;

  /// The participant information
  List<ActiveGameParticipantDTO> activeGameParticipants;

  ActiveGameInfoDTO({
    required this.gameId,
    required this.gameType,
    required this.gameStartTime,
    required this.mapId,
    required this.gameLength,
    required this.platformId,
    required this.gameMode,
    required this.activeGameBannedChampions,
    required this.gameQueueConfigId,
    required this.activeGameParticipants,
  });

  factory ActiveGameInfoDTO.fromJson(Map<String, dynamic> json) {
    return ActiveGameInfoDTO(
      gameId: json['gameId'] ?? 0,
      gameType: json['gameType'] ?? "",
      gameStartTime: json['gameStartTime'] ?? 0,
      mapId: json['mapId'] ?? 0,
      gameLength: json['gameLength'] ?? 0,
      platformId: json['platformId'] ?? "",
      gameMode: json['gameMode'] ?? "",
      gameQueueConfigId: json['gameQueueConfigId'] ?? 0,
      activeGameBannedChampions: json['bannedChampions']
          .map<ActiveGameBannedChampionDTO>((bannedChampion) =>
              ActiveGameBannedChampionDTO.fromJson(bannedChampion))
          .toList(),
      activeGameParticipants: json['participants']
          .map<ActiveGameParticipantDTO>((participant) => ActiveGameParticipantDTO.fromJson(participant))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'gameId': gameId,
        'gameType': gameType,
        'gameStartTime': gameStartTime,
        'mapId': mapId,
        'gameLength': gameLength,
        'platformId': platformId,
        'gameMode': gameMode,
        'gameQueueConfigId': gameQueueConfigId,
        'bannedChampions': activeGameBannedChampions.map((e) => e.toJson()),
        'participants': activeGameParticipants.map((e) => e.toJson()),
      };
}
