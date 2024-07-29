import 'package:legends_panel/app/modules/profile/domain/models/champion_mastery_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/summoner_identification/summoner_identification_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/user_tier_entries/league_entry_model.dart';

class SummonerProfileModel {
  String accountId;
  int profileIconId;
  String name;
  String id;
  int summonerLevel;
  SummonerIdentificationModel? summonerIdentificationModel;
  List<LeagueEntryModel>? leagueEntries;
  List<ChampionMasteryModel>? masteries;
  String? summonerId;
  String? selectedRegion;

  SummonerProfileModel({
    required this.accountId,
    required this.profileIconId,
    required this.id,
    this.name = "",
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

  setChampionMasteriesModel(List<ChampionMasteryModel> masteries){
    this.masteries = [];
    this.masteries!.addAll(masteries);
  }

  setChampionModelIntoMasteries(){

  }
}
