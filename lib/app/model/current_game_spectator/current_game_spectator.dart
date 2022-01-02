import 'package:legends_panel/app/model/current_game_spectator/current_game_banned_champion.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_participant.dart';

class CurrentGameSpectator {

  /// The ID of the game
  int gameId = 0;
  /// The game type
  String gameType = "";
  /// The game start time represented in epoch milliseconds
  int gameStartTime = 0;
  /// The ID of the map
  int mapId = 0;
  /// The amount of time in seconds that has passed since the game started
  int gameLength = 0;
  /// The ID of the platform on which the game is being played
  String platformId = "";
  /// The game mode
  String gameMode = "";
  /// Banned champion information
  List<CurrentGameBannedChampion> bannedChampions = [];
  /// The queue type (queue types are documented on the Game Constants page)
  int gameQueueConfigId = 0;
  /// The participant information
  List<CurrentGameParticipant> currentGameParticipants = [];

  CurrentGameSpectator();

  CurrentGameSpectator.fromJson(Map<String, dynamic> json) {
    gameId = json['gameId'] ?? 0;
    gameType = json['gameType'] ?? "";
    gameStartTime = json['gameStartTime'] ?? 0;
    mapId = json['mapId'] ?? 0;
    gameLength = json['gameLength'] ?? 0;
    platformId = json['platformId'] ?? "";
    gameMode = json['gameMode'] ?? "";
    if (json['bannedChampions'] != null) {
      json['bannedChampions'].forEach((bannedChampion) {
        bannedChampions.add(CurrentGameBannedChampion.fromJson(bannedChampion));
      });
    }
    gameQueueConfigId = json['gameQueueConfigId'] ?? 0;
    if (json['participants'] != null) {
      json['participants'].forEach((participant) {
        currentGameParticipants.add(CurrentGameParticipant.fromJson(participant));
      });
    }
  }

  @override
  String toString() {
    return 'CurrentGameSpectator{gameId: $gameId, gameType: $gameType, gameStartTime: $gameStartTime, mapId: $mapId, gameLength: $gameLength, platformId: $platformId, gameMode: $gameMode, bannedChampions: $bannedChampions, gameQueueConfigId: $gameQueueConfigId, currentGameParticipants: $currentGameParticipants}';
  }
}
