class SummonerProfileDTO {
  String accountId;
  int profileIconId;
  String name;
  String id;
  String puuid;
  int summonerLevel;

  SummonerProfileDTO({
    required this.accountId,
    required this.profileIconId,
    required this.name,
    required this.id,
    required this.puuid,
    required this.summonerLevel,
  });

  factory SummonerProfileDTO.fromJson(Map<String, dynamic> json) {
    return SummonerProfileDTO(
      accountId: json['accountId'],
      profileIconId: json['profileIconId'],
      name: json['name'],
      id: json['id'],
      puuid: json['puuid'],
      summonerLevel: json['summonerLevel'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'accountId' : accountId,
      'profileIconId' : profileIconId,
      'name' : name,
      'id' : id,
      'puuid' : puuid,
      'summonerLevel' : summonerLevel,
    };
  }
}
