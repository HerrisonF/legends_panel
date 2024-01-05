import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_customization_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_perk_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/summoner_identification/summoner_identification_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/summoner_identification/summoner_profile_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/user_tier_entries/league_entry_model.dart';

class ActiveGameParticipantModel {
  String puuid;

  /// The ID of the champion played by this participant
  int championId;

  /// Perks/Runes Reforged Information
  ActiveGamePerkModel? perk;

  /// The ID of the profile icon used by this participant
  int profileIconId;

  /// Flag indicating whether or not this participant is a bot
  bool bot;

  /// The team ID of this participant, indicating the participant's team
  int teamId;

  /// The summoner name of this participant
  String summonerName;

  /// The encrypted summoner ID of this participant
  String summonerId;

  /// The ID of the first summoner spell used by this participant
  int spell1Id;

  /// The ID of the second summoner spell used by this participant
  int spell2Id;

  /// List of Game Customizations
  List<ActiveGameCustomizationModel> gameCustomizations;

  ///Items que não são buscados na API. Apenas são usados na transição de dados
  ///dentro da aplicação.

  SummonerProfileModel? summonerProfileModel;
  List<LeagueEntryModel>? leagueEntryModel;

  ///

  ActiveGameParticipantModel({
    required this.championId,
    required this.perk,
    required this.profileIconId,
    required this.bot,
    required this.teamId,
    required this.summonerName,
    required this.summonerId,
    required this.spell1Id,
    required this.spell2Id,
    required this.gameCustomizations,
    required this.puuid,
  });

  setSummonerProfile(SummonerProfileModel model) {
    this.summonerProfileModel = SummonerProfileModel(
      accountId: model.accountId,
      profileIconId: model.profileIconId,
      name: model.name,
      id: model.id,
      summonerLevel: model.summonerLevel,
    );
  }

  setSummonerIdentification(
    SummonerIdentificationModel summonerIdentificationModel,
  ) {
    this
        .summonerProfileModel!
        .setSummonerIdentification(summonerIdentificationModel);
  }

  String getSummonerName() {
    return summonerProfileModel != null &&
            summonerProfileModel!.summonerIdentificationModel != null
        ? summonerProfileModel!.summonerIdentificationModel!.gameName
        : summonerName;
  }

  /// É uma lista de entries que significa as rankes.
  /// Ex: Ranked solo -> master Ranked Flex -> Bronze.
  setLeagueEntriesModel(List<LeagueEntryModel> entries){
    this.leagueEntryModel = [];
    this.leagueEntryModel!.addAll(entries);
  }
}
