class User {
  String id = "";
  String accountId = "";
  String puuid = "";
  String name = "";
  String region = "";
  String userTier = "";
  dynamic profileIconId = 0;
  dynamic revisionDate = 0;
  dynamic summonerLevel = 0;

  User();

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    accountId = json['accountId'];
    puuid = json['puuid'];
    name = json['name'];
    profileIconId = json['profileIconId'];
    revisionDate = json['revisionDate'];
    summonerLevel = json['summonerLevel'];
    region = json['region']??"";
    userTier = json['userTier']??"";
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'accountId' : accountId,
    'puuid' : puuid,
    'name' : name,
    'profileIconId' : profileIconId,
    'revisionDate' : revisionDate,
    'summonerLevel' : summonerLevel,
    'region': region,
    'userTier': userTier,
  };

  @override
  String toString() {
    return 'User{id: $id, accountId: $accountId, puuid: $puuid, name: $name, region: $region, profileIconId: $profileIconId, revisionDate: $revisionDate, summonerLevel: $summonerLevel}';
  }
}
