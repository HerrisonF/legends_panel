import 'map_mode.dart';

class MapRoom {
  DateTime actualDate = DateTime.now();
  String lastDate = "";
  List<MapMode> maps = [];

  MapRoom();

  MapRoom.fromJson(Map<String, dynamic> json){
    lastDate = json['lastDate']??"";

  }

  Map<String, dynamic> toJson()=> {
    'lastDate': lastDate.toString(),
    'maps': maps,
  };

  bool needToLoadVersionFromWeb(){
    var timeDifference = actualDate.difference(lastDate.isEmpty ? DateTime.now() : DateTime.parse(lastDate));
    return timeDifference.inHours > 24;
  }
}