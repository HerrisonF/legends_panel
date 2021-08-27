class User {
  String id = "";
  String accountId = "";
  String puuid = "";
  String name = "";
  int profileIconId = 0;
  int revisionDate = 0;
  int summonerLevel = 0;

  User();

  User.fromJson(Map<String, dynamic> json)
      : id = json['id']??"",
        accountId = json['accountId']??"",
        puuid = json['puuid']??"",
        name = json['name']??"",
        profileIconId = int.parse(json['profileIconId']!.toString()),
        revisionDate = int.parse(json['revisionDate']!.toString()),
        summonerLevel = int.parse(json['summonerLevel']!.toString());

  Map<String, dynamic> toJson() => {
    'id' : id,
    'accountId' : accountId,
    'puuid' : puuid,
    'name' : name,
    'profileIconId' : profileIconId,
    'revisionDate' : revisionDate,
    'summonerLevel' : summonerLevel,
  };

  @override
  String toString() {
    return "id: $id, accountId: $accountId, puuid: $puuid, profileIconId: $profileIconId, revisionDate: $revisionDate, summonerLevel: $summonerLevel";
  }
}
