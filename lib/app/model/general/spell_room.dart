import 'package:legends_panel/app/model/current_game_spectator/current_game_summoner_spell.dart';

class SpellRoom {
  DateTime actualDate = DateTime.now();
  String lastDate = "";
  SummonerSpell summonerSpell = SummonerSpell();

  SpellRoom();

  SpellRoom.fromJson(Map<String, dynamic> json){
    lastDate = json['lastDate']??"";
    summonerSpell = json['summonerSpell'];
  }

  Map<String, dynamic> toJson()=> {
    'lastDate': lastDate.toString(),
    'summonerSpell': summonerSpell,
  };

  bool needToLoadVersionFromWeb(){
    var timeDifference = actualDate.difference(lastDate.isEmpty ? DateTime.now() : DateTime.parse(lastDate));
    return timeDifference.inHours > 24;
  }
}