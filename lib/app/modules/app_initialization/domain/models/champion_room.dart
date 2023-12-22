import '../../data/dtos/lol_constants/champion_dto.dart';

class ChampionRoom {
  DateTime actualDate = DateTime.now();
  String lastDate = "";
  List<Champion> champions = [];

  ChampionRoom();

  ChampionRoom.fromJson(Map<String, dynamic> json){
    lastDate = json['lastDate']??"";
    champions = json['champions'];
  }

  Map<String, dynamic> toJson()=> {
    'lastDate': lastDate.toString(),
    'champions': champions,
  };

  bool needToLoadVersionFromWeb(){
    var timeDifference = actualDate.difference(lastDate.isEmpty ? DateTime.now() : DateTime.parse(lastDate));
    return timeDifference.inHours > 24;
  }

}