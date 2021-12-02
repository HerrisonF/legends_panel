class StoredRegion {
  String lastStoredCurrentGameRegion = "";
  String lastStoredProfileRegion = "";

  StoredRegion();

  StoredRegion.fromJson(Map<String, dynamic> json){
    lastStoredCurrentGameRegion = json['lastStoredCurrentGameRegion'];
    lastStoredProfileRegion = json['lastStoredProfileRegion'];
  }

  Map<String, dynamic> toJson()=>{
    'lastStoredCurrentGameRegion' : lastStoredCurrentGameRegion,
    'lastStoredProfileRegion' : lastStoredProfileRegion,
  };

}