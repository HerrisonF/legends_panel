class SummonerIdentificationDTO {
  String puuid;
  String gameName;
  String tagLine;

  SummonerIdentificationDTO({
    required this.puuid,
    required this.gameName,
    required this.tagLine,
  });

  factory SummonerIdentificationDTO.fromJson(Map<String, dynamic> json) {
    return SummonerIdentificationDTO(
      puuid: json['puuid'] ?? "",
      tagLine: json['tagLine'] ?? "",
      gameName: json['gameName'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'puuid': this.puuid,
      'tagLine' : this.tagLine,
      'gameName' : this.gameName,
    };
  }
}