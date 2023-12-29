import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/champion_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/game_language_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/game_mode_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/game_version_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/item_mother_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/mapa_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/perk_style_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/queue_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/summoner_spell_dto.dart';

class LolConstantsDTO {
  List<QueueDto> queuesDTO;
  List<GameVersionDTO> versionsDTO;
  List<MapaDTO> mapasDTO;
  List<GameModeDTO> gameModesDTO;
  List<GameLanguageDTO> gameLanguagesDTO;
  List<ChampionDTO> championsDTO;
  List<SummonerSpellDTO> spellsDTO;
  ItemMotherDTO  itemMotherDTO;
  List<PerkStyleDTO> perksDTO;

  LolConstantsDTO({
    required this.queuesDTO,
    required this.versionsDTO,
    required this.mapasDTO,
    required this.gameModesDTO,
    required this.championsDTO,
    required this.itemMotherDTO,
    required this.spellsDTO,
    required this.gameLanguagesDTO,
    required this.perksDTO,
  });

  Map<String, dynamic> toJson() {
    return {
      'queues': queuesDTO.map((element) => element.toJson()).toList(),
      'versions': versionsDTO.map((element) => element.toJson()).toList(),
      'mapas': mapasDTO.map((element) => element.toJson()).toList(),
      'gameModes': gameModesDTO.map((element) => element.toJson()).toList(),
      'champions' : championsDTO.map((element) => element.toJson()).toList(),
      'itemMother' : itemMotherDTO.toJson(),
      'spells' : spellsDTO.map((element) => element.toJson()).toList(),
      'gameLanguages' : gameLanguagesDTO.map((element) => element.toJson()).toList(),
      'perks' : perksDTO.map((e) => e.toJson()).toList(),
    };
  }

  factory LolConstantsDTO.fromJson(Map<String, dynamic> json) {
    return LolConstantsDTO(
      queuesDTO: json['queues'].map<QueueDto>((element) => QueueDto.fromJson(element)).toList(),
      versionsDTO: json['versions'].map<GameVersionDTO>((element) => GameVersionDTO.fromJsonLocal(element)).toList(),
      mapasDTO: json['mapas'].map<MapaDTO>((element) => MapaDTO.fromJson(element)).toList(),
      gameModesDTO: json['gameModes'].map<GameModeDTO>((element) => GameModeDTO.fromJson(element)).toList(),
      championsDTO: json['champions'].map<ChampionDTO>((element) => ChampionDTO.fromJson(element)).toList(),
      gameLanguagesDTO: json['gameLanguages'].map<GameLanguageDTO>((element) => GameLanguageDTO.fromJsonLocal(element)).toList(),
      itemMotherDTO: ItemMotherDTO.fromJson(json['itemMother']),
      spellsDTO: json['spells'].map<SummonerSpellDTO>((element) => SummonerSpellDTO.fromJson(element)).toList(),
      perksDTO: json['perks'].map<PerkStyleDTO>((element) => PerkStyleDTO.fromJson(element)).toList(),
    );
  }
}