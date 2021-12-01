class LolVersion {

  DateTime actualDate = DateTime.now();
  String lastDate = "";
  String actualVersion = "";
  List<String> versions = [];

  LolVersion();

  LolVersion.fromJson(Map<String, dynamic> json){
    lastDate = json['lastDate']??"";
    actualVersion = json['actualVersion']??"";
    if(json['versions']!= null){
      for(String version in json['versions']){
        versions.add(version);
      }
    }
  }

  Map<String, dynamic> toJson ()=> {
    'lastDate' : actualDate.toString(),
    'actualVersion': actualVersion,
    'versions': versions,
  };

  bool needToLoadVersionFromWeb(){
    var timeDifference = actualDate.difference(lastDate.isEmpty ? DateTime.now() : DateTime.parse(lastDate));
    return timeDifference.inHours > 24;
  }

}