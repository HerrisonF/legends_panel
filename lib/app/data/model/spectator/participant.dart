import 'package:legends_panel/app/data/model/spectator/game_customization.dart';
import 'package:legends_panel/app/data/model/spectator/perk.dart';

class Participant {

  int championId = 0;
  List<Perk> perks = [];
  int profileIconId = 0;
  bool bot = false;
  int teamId = 0;
  String summonerName = "";
  String summonerId = "";
  int spell1Id = 0;
  int spell2Id = 0;
  List<GameCustomization> gameCustomization = [];

  Participant.fromJson(Map<String, dynamic> json){
    championId = json['championId'] ?? 0;
    if(json['perks'] != null){
      perks = json['perks'].forEach((perk){
        perk.add(Perk.fromJson(perk));
      });
    }
    profileIconId = json['profileIconId'] ?? 0;
    bot = json['bot'] ?? false;
    teamId = json['teamId'] ?? 0;
    summonerName = json['summonerName'] ?? "";
    summonerId = json['summonerId'] ?? "";
    spell1Id = json['spell1Id'] ?? "";
    spell2Id = json['spell2Id'] ?? "";
    if(json['gameCustomizationObjects'] != null){
      gameCustomization = json['gameCustomizationObjects'].forEach((gameCustomization){
        gameCustomization.add(GameCustomization.fromJson(gameCustomization));
      });
    }
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['championId'] = championId;
    data['perks'] = perks.map((perk) => perk.toJson()).toList();
    data['profileIconId'] = profileIconId;
    data['bot'] = bot;
    data['teamId'] = teamId;
    data['summonerName'] = summonerName;
    data['summonerId'] = summonerId;
    data['spell1Id'] = spell1Id;
    data['spell2Id'] = spell2Id;
    data['gameCustomizationObjects'] = gameCustomization.map((gameCustom) => gameCustom.toJson()).toList();

    return data;
  }

}