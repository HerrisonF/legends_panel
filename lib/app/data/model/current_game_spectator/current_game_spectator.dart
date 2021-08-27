import 'package:legends_panel/app/data/model/current_game_spectator/current_game_banned_champion.dart';
import 'package:legends_panel/app/data/model/current_game_spectator/current_game_participant.dart';

class CurrentGameSpectator {
  int gameId = 0;
  String gameType = "";
  int gameStartTime = 0;
  int mapId = 0;
  int gameLength = 0;
  String platformId = "";
  String gameMode = "";
  List<CurrentGameBannedChampion> bannedChampions = [];
  int gameQueueConfigId = 0;
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
