import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_banned_champion_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_participant_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/summoner_identification/summoner_profile_model.dart';

class ActiveGameInfoModel {
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
  List<ActiveGameBannedChampionModel> activeGameBannedChampions;

  /// The queue type (queue types are documented on the Game Constants page)
  int gameQueueConfigId;

  /// The participant information
  List<ActiveGameParticipantModel> activeGameParticipants;

  ///Items que não são buscados na API. Apenas são usados na transição de dados
  ///dentro da aplicação.

  SummonerProfileModel? summonerProfileModel;

  ///

  ActiveGameInfoModel({
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

  setSummonerProfile(SummonerProfileModel summonerProfileModel){
    this.summonerProfileModel = summonerProfileModel;
  }
}
