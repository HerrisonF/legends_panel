import 'package:legends_panel/app/data/model/spectator/banned_champion.dart';
import 'package:legends_panel/app/data/model/spectator/participant.dart';

class Spectator {
  int gameId = 0;
  String gameType = "";
  int gameStartTime = 0;
  int mapId = 0;
  int gameLength = 0;
  String platformId = "";
  String gameMode = "";
  List<BannedChampion> bannedChampions = [];
  int gameQueueConfigId = 0;
  List<Participant> participants = [];

  Spectator({
    this.gameId = 0,
    this.gameType = "",
    this.gameStartTime = 0,
    this.mapId = 0,
    this.gameLength = 0,
    this.platformId = "",
    this.gameMode = "",
    this.bannedChampions = const [],
    this.gameQueueConfigId = 0,
    this.participants = const [],
  });

  Spectator.fromJson(Map<String, dynamic> json) {
    gameId = json['gameId'] ?? 0;
    gameType = json['gameType'] ?? "";
    gameStartTime = json['gameStartTime'] ?? 0;
    mapId = json['mapId'] ?? 0;
    gameLength = json['gameLength'] ?? 0;
    platformId = json['platformId'] ?? "";
    gameMode = json['gameMode'] ?? "";
    if (json['bannedChampions'] != null) {
      json['bannedChampions'].forEach((bannedChampion) {
        bannedChampions.add(BannedChampion.fromJson(bannedChampion));
      });
    }
    gameQueueConfigId = json['gameQueueConfigId'] ?? 0;
    if (json['participants'] != null) {
      json['participants'].forEach((participant) {
        participants.add(Participant.fromJson(participant));
      });
    }
  }
}
