
import 'package:legends_panel/app/modules/current_game/domain/current_game_spectator/current_game_banned_champion.dart';
import 'package:legends_panel/app/modules/current_game/domain/current_game_spectator/current_game_customization.dart';
import 'package:legends_panel/app/modules/current_game/domain/current_game_spectator/current_game_perk.dart';

class CurrentGameParticipant {
  /// The ID of the champion played by this participant
  int championId = -1;
  /// Perks/Runes Reforged Information
  CurrentGamePerk perks = CurrentGamePerk();
  /// The ID of the profile icon used by this participant
  int profileIconId = -1;
  /// Flag indicating whether or not this participant is a bot
  bool bot = false;
  /// The team ID of this participant, indicating the participant's team
  int teamId = 0;
  /// The summoner name of this participant
  String summonerName = "";
  /// The encrypted summoner ID of this participant
  String summonerId = "";
  /// The ID of the first summoner spell used by this participant
  int spell1Id = -1;
  /// The ID of the second summoner spell used by this participant
  int spell2Id = -1;
  /// List of Game Customizations
  List<CurrentGameCustomization> gameCustomization = [];
  CurrentGameBannedChampion currentGameBannedChampion =
      CurrentGameBannedChampion();

  CurrentGameParticipant();

  CurrentGameParticipant.fromJson(Map<String, dynamic> json) {
    championId = json['championId'] ?? 0;
    if (json['perks'] != null) {
      perks = CurrentGamePerk.fromJson(json['perks']);
    }
    profileIconId = json['profileIconId'] ?? 0;
    bot = json['bot'] ?? false;
    teamId = json['teamId'] ?? 0;
    summonerName = json['summonerName'] ?? "";
    summonerId = json['summonerId'] ?? "";
    spell1Id = json['spell1Id'] ?? "";
    spell2Id = json['spell2Id'] ?? "";
    if (json['gameCustomizationObjects'] != null &&
        json['gameCustomizationObjects'].length > 0) {
      gameCustomization =
          json['gameCustomizationObjects'].forEach((gameCustomization) {
        gameCustomization
            .add(CurrentGameCustomization.fromJson(gameCustomization));
      });
    }
    if(json['currentGameBannedChampion']!= null)
      currentGameBannedChampion = json['currentGameBannedChampion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['championId'] = championId;
    data['perks'] = perks.toJson();
    data['profileIconId'] = profileIconId;
    data['bot'] = bot;
    data['teamId'] = teamId;
    data['summonerName'] = summonerName;
    data['summonerId'] = summonerId;
    data['spell1Id'] = spell1Id;
    data['spell2Id'] = spell2Id;
    data['gameCustomizationObjects'] =
        gameCustomization.map((gameCustom) => gameCustom.toJson()).toList();
    if(currentGameBannedChampion.championId>0)
      data['currentGameBannedChampion'] = currentGameBannedChampion;
    return data;
  }

  @override
  String toString() {
    return 'CurrentGameParticipant{championId: $championId, perks: $perks, profileIconId: $profileIconId, bot: $bot, teamId: $teamId, summonerName: $summonerName, summonerId: $summonerId, spell1Id: $spell1Id, spell2Id: $spell2Id, gameCustomization: $gameCustomization, currentGameBannedChampion: $currentGameBannedChampion}';
  }
}
