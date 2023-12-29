import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/champion_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/champion_stats_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/game_language_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/game_mode_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/game_version_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/group_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/image_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/information_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/item_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/item_mother_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/lol_constants_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/mapa_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/perk_style_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/queue_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/summoner_spell_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/tree_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/repositories/splash_repository/splash_repository_local.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/champion_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/champion_stats_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/game_language_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/game_mode_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/game_version_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/group_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/image_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/item_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/item_mother_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/lol_constants_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/mapa_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/perk_style_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/queue_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/summoner_spell.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/tree_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepositoryLocalImpl extends SplashRepositoryLocal {
  late SharedPreferences sharedPreferences;

  static const origin = "SplashRepository-Queues-local";

  SplashRepositoryLocalImpl({
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, LolConstantsModel>> fetchLolConstantsLocal() async {
    try {
      String? response = sharedPreferences.getString('LOL_CONSTANTS_KEY');

      if (response != null) {
        Map<String, dynamic> json = jsonDecode(response);
        LolConstantsDTO dto = LolConstantsDTO.fromJson(json);
        LolConstantsModel lolConstantsModel = LolConstantsModel(
          perks: dto.perksDTO
              .map(
                (e) => PerkStyleModel(
                  id: e.id,
                  key: e.key,
                  icon: e.icon,
                  name: e.name,
                  slotModels: e.slotsDTO
                      .map(
                        (e) => SlotsModel(
                          runeModels: e.runeDTOs
                              .map((e) => RuneModel(
                                    id: e.id,
                                    key: e.key,
                                    icon: e.icon,
                                    name: e.name,
                                    shortDesc: e.shortDesc,
                                    longDesc: e.longDesc,
                                  ))
                              .toList(),
                        ),
                      )
                      .toList(),
                ),
              )
              .toList(),
          queues: dto.queuesDTO
              .map((e) => QueueModel(
                    queueId: e.queueId,
                    map: e.map,
                    description: e.description,
                    notes: e.notes,
                  ))
              .toList(),
          versions: dto.versionsDTO
              .map(
                (e) => GameVersionModel(
                  version: e.version,
                ),
              )
              .toList(),
          gameModes: dto.gameModesDTO
              .map(
                (e) => GameModeModel(
                  description: e.description,
                  gameMode: e.gameMode,
                ),
              )
              .toList(),
          champions: dto.championsDTO
              .map(
                (e) => ChampionModel(
                  version: e.version,
                  id: e.id,
                  key: e.key,
                  name: e.name,
                  title: e.title,
                  blurb: e.blurb,
                  info: InformationModel(
                    attack: e.info!.attack,
                    defense: e.info!.defense,
                    magic: e.info!.magic,
                    difficulty: e.info!.difficulty,
                  ),
                  image: ImageModel(
                    full: e.image!.full,
                    group: e.image!.group,
                    h: e.image!.h,
                    sprite: e.image!.sprite,
                    w: e.image!.w,
                    x: e.image!.x,
                    y: e.image!.y,
                  ),
                  tags: e.tags,
                  partype: e.partype,
                  stats: ChampionStatsModel(
                    hp: e.stats!.hp,
                    hpperlevel: e.stats!.hpperlevel,
                    mp: e.stats!.mp,
                    mpperlevel: e.stats!.mpperlevel,
                    movespeed: e.stats!.movespeed,
                    mpregen: e.stats!.mpregen,
                    armor: e.stats!.armor,
                    armorperlevel: e.stats!.armorperlevel,
                    attackdamage: e.stats!.attackdamage,
                    attackdamageperlevel: e.stats!.attackdamageperlevel,
                    attackrange: e.stats!.attackrange,
                    attackspeed: e.stats!.attackspeed,
                    attackspeedperlevel: e.stats!.attackspeedperlevel,
                    crit: e.stats!.crit,
                    critperlevel: e.stats!.critperlevel,
                    hpregen: e.stats!.hpregen,
                    hpregenperlevel: e.stats!.hpregenperlevel,
                    mpregenperlevel: e.stats!.mpregenperlevel,
                    spellblock: e.stats!.spellblock,
                    spellblockperlevel: e.stats!.spellblockperlevel,
                  ),
                ),
              )
              .toList(),
          maps: dto.mapasDTO
              .map(
                (e) => MapaModel(
                  mapName: e.mapName,
                  mapaId: e.mapId,
                  notes: e.notes,
                ),
              )
              .toList(),
          itemMotherModel: ItemMotherModel(
            trees: dto.itemMotherDTO.trees
                .map(
                  (e) => TreeModel(
                    header: e.header,
                    tags: e.tags!.toList(),
                  ),
                )
                .toList(),
            groups: dto.itemMotherDTO.groups
                .map((e) => GroupModel(id: e.id))
                .toList(),
            items: dto.itemMotherDTO.items
                .map(
                  (e) => ItemModel(
                    tags: e.tags!.toList(),
                    maps: MapsModel(
                        b11: e.maps!.b11,
                        b12: e.maps!.b12,
                        b21: e.maps!.b21,
                        b22: e.maps!.b22,
                        b30: e.maps!.b30),
                  ),
                )
                .toList(),
          ),
          spells: dto.spellsDTO
              .map(
                (e) => SummonerSpell(
                  description: e.description,
                  image: ImageModel(
                    sprite: e.image!.sprite,
                    x: e.image!.x,
                    w: e.image!.w,
                    h: e.image!.h,
                    group: e.image!.group,
                    full: e.image!.full,
                    y: e.image!.y,
                  ),
                  name: e.name,
                  tooltip: e.tooltip,
                  maxRank: e.maxRank,
                  effectBurn: e.effectBurn.toList(),
                  id: e.id,
                  key: e.key,
                  cooldownBurn: e.cooldownBurn,
                  rangeBurn: e.rangeBurn,
                  maxAmmo: e.maxAmmo,
                  modes: e.modes.toList(),
                  summonerLevel: e.summonerLevel,
                ),
              )
              .toList(),
          gameLanguages: dto.gameLanguagesDTO
              .map(
                (e) => GameLanguageModel(
                  language: e.language,
                ),
              )
              .toList(),
        );
        lolConstantsModel.setRankedConstants();
        return Right(lolConstantsModel);
      } else {
        return Left(
          Failure(message: "As constants não foram encontradas localmente."),
        );
      }
    } catch (e) {
      return Left(
        Failure(
          message: 'Falha na busca local pelas constantes.',
          error: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> saveLolConstants({
    required LolConstantsModel lolConstantsModel,
  }) async {
    try {
      LolConstantsDTO lolConstantsDTO = LolConstantsDTO(
        perksDTO: lolConstantsModel.perks!
            .map(
              (e) => PerkStyleDTO(
                id: e.id,
                key: e.key,
                icon: e.icon,
                name: e.name,
                slotsDTO: e.slotModels
                    .map(
                      (e) => SlotsDTO(
                        runeDTOs: e.runeModels
                            .map((e) => RuneDTO(
                                  id: e.id,
                                  key: e.key,
                                  icon: e.icon,
                                  name: e.name,
                                  shortDesc: e.shortDesc,
                                  longDesc: e.longDesc,
                                ))
                            .toList(),
                      ),
                    )
                    .toList(),
              ),
            )
            .toList(),
        spellsDTO: lolConstantsModel.spells!
            .map(
              (e) => SummonerSpellDTO(
                id: e.id,
                name: e.name,
                description: e.description,
                tooltip: e.tooltip,
                maxRank: e.maxRank,
                cooldownBurn: e.cooldownBurn,
                effectBurn: e.effectBurn,
                key: e.key,
                summonerLevel: e.summonerLevel,
                modes: e.modes,
                maxAmmo: e.maxAmmo,
                rangeBurn: e.rangeBurn,
                image: ImageDTO(
                  full: e.image!.full,
                  sprite: e.image!.sprite,
                  group: e.image!.group,
                  x: e.image!.x,
                  y: e.image!.y,
                  w: e.image!.w,
                  h: e.image!.h,
                ),
              ),
            )
            .toList(),
        gameLanguagesDTO: lolConstantsModel.gameLanguages!
            .map(
              (e) => GameLanguageDTO(
                language: e.language,
              ),
            )
            .toList(),
        itemMotherDTO: ItemMotherDTO(
          items: lolConstantsModel.itemMotherModel!.items
              .map(
                (e) => ItemDTO(
                  maps: MapsDTO(
                    b30: e.maps!.b30,
                    b22: e.maps!.b22,
                    b21: e.maps!.b21,
                    b12: e.maps!.b12,
                    b11: e.maps!.b11,
                  ),
                  name: e.name,
                  image: ImageDTO(
                    full: e.image!.full,
                    sprite: e.image!.sprite,
                    group: e.image!.group,
                    x: e.image!.x,
                    y: e.image!.y,
                    w: e.image!.w,
                    h: e.image!.h,
                  ),
                  description: e.description,
                  tags: e.tags,
                  plaintext: e.plaintext,
                  into: e.into,
                  gold: GoldDTO(
                    total: e.gold!.total,
                    sell: e.gold!.sell,
                    purchasable: e.gold!.purchasable,
                    base: e.gold!.base,
                  ),
                  colloq: e.colloq,
                  stats: StatsDTO(
                    flatMovementSpeedMod: e.stats!.flatMovementSpeedMod,
                  ),
                ),
              )
              .toList(),
          groups: lolConstantsModel.itemMotherModel!.groups
              .map(
                (e) => GroupDTO(id: e.id),
              )
              .toList(),
          trees: lolConstantsModel.itemMotherModel!.trees
              .map(
                (e) => TreeDTO(
                  tags: e.tags,
                  header: e.header,
                ),
              )
              .toList(),
        ),
        mapasDTO: lolConstantsModel.maps!
            .map(
              (e) => MapaDTO(
                mapId: e.mapaId,
                mapName: e.mapName,
                notes: e.notes,
              ),
            )
            .toList(),
        championsDTO: lolConstantsModel.champions!
            .map(
              (e) => ChampionDTO(
                version: e.version,
                id: e.id,
                key: e.key,
                name: e.name,
                title: e.title,
                stats: ChampionStatsDTO(
                  armor: e.stats.armor,
                  armorperlevel: e.stats.armorperlevel,
                  attackdamage: e.stats.attackdamage,
                  attackdamageperlevel: e.stats.attackdamageperlevel,
                  attackrange: e.stats.attackrange,
                  attackspeed: e.stats.attackspeed,
                  attackspeedperlevel: e.stats.attackspeedperlevel,
                  crit: e.stats.crit,
                  critperlevel: e.stats.critperlevel,
                  hp: e.stats.hp,
                  hpperlevel: e.stats.hpperlevel,
                  hpregen: e.stats.hpregen,
                  hpregenperlevel: e.stats.hpregenperlevel,
                  movespeed: e.stats.movespeed,
                  mp: e.stats.mp,
                  mpperlevel: e.stats.mpperlevel,
                  mpregen: e.stats.mpregen,
                  mpregenperlevel: e.stats.mpregenperlevel,
                  spellblock: e.stats.spellblock,
                  spellblockperlevel: e.stats.spellblockperlevel,
                ),
                partype: e.partype,
                image: ImageDTO(
                  full: e.image.full,
                  sprite: e.image.sprite,
                  group: e.image.group,
                  x: e.image.x,
                  y: e.image.y,
                  w: e.image.w,
                  h: e.image.h,
                ),
                info: InformationDTO(
                  attack: e.info.attack,
                  defense: e.info.defense,
                  magic: e.info.magic,
                  difficulty: e.info.difficulty,
                ),
                blurb: e.blurb,
                tags: e.tags,
              ),
            )
            .toList(),
        gameModesDTO: lolConstantsModel.gameModes!
            .map(
              (e) => GameModeDTO(
                gameMode: e.gameMode,
                description: e.description,
              ),
            )
            .toList(),
        versionsDTO: lolConstantsModel.versions!
            .map(
              (e) => GameVersionDTO(
                version: e.version,
              ),
            )
            .toList(),
        queuesDTO: lolConstantsModel.queues!
            .map(
              (e) => QueueDto(
                queueId: e.queueId,
                map: e.map,
                description: e.description,
                notes: e.notes,
              ),
            )
            .toList(),
      );

      final response = await sharedPreferences.setString(
        'LOL_CONSTANTS_KEY',
        jsonEncode(lolConstantsDTO.toJson()),
      );

      return Right(response);
    } catch (e) {
      return Left(
        Failure(
          message: 'Falha ao salvar os LOLConstants localmente.',
          error: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> fetchRegisterDate() async {
    try {
      final result = sharedPreferences.getInt('LAST_REGISTER_DATE');
      return Right(result ?? 0);
    } catch (e) {
      return Left(
        Failure(
          message: "Erro ao recuperar a data.",
          error: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> saveRegisterDate() async {
    try {
      bool result = await sharedPreferences.setInt(
        'LAST_REGISTER_DATE',
        DateTime.now().millisecondsSinceEpoch,
      );
      return Right(result);
    } catch (e) {
      return Left(
        Failure(
          message: "Erro ao salvar a data.",
          error: e.toString(),
        ),
      );
    }
  }
}
