class SummonerIdentificationModel {
  String puuid;
  String gameName;
  String tagLine;

  SummonerIdentificationModel({
    required this.puuid,
    required this.gameName,
    required this.tagLine,
  });

  factory SummonerIdentificationModel.empty() {
    return SummonerIdentificationModel(
      puuid: "",
      gameName: "",
      tagLine: "",
    );
  }
}
