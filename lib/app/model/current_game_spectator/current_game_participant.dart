import 'package:legends_panel/app/model/current_game_spectator/current_game_banned_champion.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_customization.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_perk.dart';

class CurrentGameParticipant {
  int championId = -1;
  CurrentGamePerk perks = CurrentGamePerk();
  int profileIconId = -1;
  bool bot = false;
  int teamId = 0;
  String summonerName = "";
  String summonerId = "";
  int spell1Id = -1;
  int spell2Id = -1;
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
