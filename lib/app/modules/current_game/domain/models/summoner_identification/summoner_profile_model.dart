import 'package:legends_panel/app/modules/current_game/domain/models/summoner_identification/summoner_identification_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/user_tier_entries/league_entry_model.dart';

class SummonerProfileModel {
  String accountId;
  int profileIconId;
  String name;
  String id;
  String puuid;
  int summonerLevel;
  SummonerIdentificationModel? summonerIdentificationModel;

  /// Esses dados não são originais do objeto

  List<LeagueEntryModel>? leagueEntries;

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

  /// É uma lista de entries que significa as rankes.
  /// Ex: Ranked solo -> master Ranked Flex -> Bronze.
  setLeagueEntriesModel(List<LeagueEntryModel> entries){
    this.leagueEntries = [];
    this.leagueEntries!.addAll(entries);
  }
}
