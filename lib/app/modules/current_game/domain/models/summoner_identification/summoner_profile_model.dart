import 'package:legends_panel/app/modules/current_game/domain/models/summoner_identification/summoner_identification_model.dart';

class SummonerProfileModel {
  String accountId;
  int profileIconId;
  String name;
  String id;
  String puuid;
  int summonerLevel;
  SummonerIdentificationModel? summonerIdentificationModel;

  SummonerProfileModel({
    required this.accountId,
    required this.profileIconId,
    required this.name,
    required this.id,
    required this.puuid,
    required this.summonerLevel,
  });

  setSummonerIdentification(
    SummonerIdentificationModel model,
  ) {
    this.summonerIdentificationModel = SummonerIdentificationModel(
      puuid: model.puuid,
      gameName: model.gameName,
      tagLine: model.tagLine,
    );
  }
}
