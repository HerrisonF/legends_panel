class User {
  String id;
  String accountId;
  String puuid;
  String name;
  int profileIconId;
  int revisionDate;
  int summonerLevel;

  User({
    this.id = "",
    this.accountId = "",
    this.puuid = "",
    this.name = "",
    this.profileIconId = 0,
    this.revisionDate = 0,
    this.summonerLevel = 0,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        accountId = json['accountId'].toString(),
        puuid = json['puuid'].toString(),
        name = json['name'].toString(),
        profileIconId = int.parse(json['profileIconId'].toString()),
        revisionDate = int.parse(json['revisionDate'].toString()),
        summonerLevel = int.parse(json['summonerLevel'].toString());

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
