import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_customization_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_perk_model.dart';

class ActiveGameParticipantModel {
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
  });
}
