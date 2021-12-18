import 'dart:io';

class StoredRegion {
  String lastStoredCurrentGameRegion = "";
  String lastStoredProfileRegion = "";

  StoredRegion();

  StoredRegion.fromJson(Map<String, dynamic> json){
    lastStoredCurrentGameRegion = json['lastStoredCurrentGameRegion'];
    lastStoredProfileRegion = json['lastStoredProfileRegion'];
  }

  Map<String, dynamic> toJson() =>
      {
        'lastStoredCurrentGameRegion': lastStoredCurrentGameRegion,
        'lastStoredProfileRegion': lastStoredProfileRegion,
      };

  String? getKeyFromRegion(String region) {
    var _locationsKeys = {
      'BR': 'BR1',
      'EUN': 'EUN1',
      'EUW': 'EUW1',
      'JP': 'JP1',
      'KR': 'KR',
      'LA': 'LA1',
      'NA': 'NA1',
      'OC': 'OC1',
      'TR': 'TR1',
      'RU': 'RU'
    };
    return _locationsKeys[region];
  }

  String? getLocaleKey(){
    String locale = Platform.localeName;
    if(locale.isEmpty) {
      return "en_US";
    }
    return locale;
  }

  @override
  String toString() {
    return 'StoredRegion{lastStoredCurrentGameRegion: $lastStoredCurrentGameRegion, lastStoredProfileRegion: $lastStoredProfileRegion}';
  }
}