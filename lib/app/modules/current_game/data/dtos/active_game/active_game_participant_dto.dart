import 'package:legends_panel/app/modules/current_game/data/dtos/active_game/active_game_customization_dto.dart';
import 'package:legends_panel/app/modules/current_game/data/dtos/active_game/active_game_perk_dto.dart';

class ActiveGameParticipantDTO {

  String puuid;

  /// The ID of the champion played by this participant
  int championId;

  /// Perks/Runes Reforged Information
  ActiveGamePerkDTO perk;

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
  List<ActiveGameCustomizationDTO> gameCustomizations;

  ActiveGameParticipantDTO({
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

  factory ActiveGameParticipantDTO.fromJson(Map<String, dynamic> json) {
    return ActiveGameParticipantDTO(
      championId: json['championId'] ?? 0,
      puuid: json['puuid'] ?? "",
      perk: ActiveGamePerkDTO.fromJson(json['perks']),
      profileIconId: json['profileIconId'] ?? 0,
      bot: json['bot'] ?? false,
      teamId: json['teamId'] ?? 0,
      summonerName: json['summonerName'] ?? "",
      summonerId: json['summonerId'] ?? "",
      spell1Id: json['spell1Id'] ?? "",
      spell2Id: json['spell2Id'] ?? "",
      gameCustomizations: json['gameCustomizationObjects'] != null
          ? (json['gameCustomizationObjects'] as List<dynamic>).map<ActiveGameCustomizationDTO>((gameCustomization) =>
              ActiveGameCustomizationDTO.fromJson(gameCustomization)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'championId': championId,
      'perks': perk.toJson(),
      'puuid' : puuid,
      'profileIconId': profileIconId,
      'bot': bot,
      'teamId': teamId,
      'summonerName': summonerName,
      'summonerId': summonerId,
      'spell1Id': spell1Id,
      'spell2Id': spell2Id,
      'gameCustomizationObjects':
          gameCustomizations.map((gameCustom) => gameCustom.toJson()).toList(),
    };
  }
}
