import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/core/http_configuration/api_endpoints.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/champion_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/game_language_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/game_mode_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/game_version_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/group_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/item_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/mapa_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/perk_style_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/queue_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/summoner_spell_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/tree_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/repositories/splash_repository/splash_repository.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/champion_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/champion_stats_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/game_language_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/game_mode_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/game_version_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/group_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/image_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/item_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/item_mother_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/mapa_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/perk_style_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/queue_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/summoner_spell.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/tree_model.dart';

class SplashRepositoryRemoteImpl extends SplashRepository {
  late HttpServices httpServices;

  static const origin = "SplashRepository-Queues-Remote";

  SplashRepositoryRemoteImpl({
    required this.httpServices,
  });

  @override
  Future<Either<Failure, List<QueueModel>>> fetchQueues() async {
    try {
      final response = await httpServices.get(
        url: API.riotStaticDataUrl,
        path: '/docs/lol/queues.json',
        origin: origin,
      );

      return response.fold(
        (l) => Left(l),
        (r) {
          List<QueueModel> queues = [];
          r.data.forEach(
            (queue) {
              QueueDto dto = QueueDto.fromJson(queue);
              queues.add(
                QueueModel(
                  description: dto.description,
                  map: dto.map,
                  notes: dto.notes,
                  queueId: dto.queueId,
                ),
              );
            },
          );

          return Right(queues);
        },
      );
    } catch (e) {
      return Left(
        Failure(
          message: 'Falha na busca remota de QUEUES.',
          error: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<GameVersionModel>>> fetchVersions() async {
    try {
      final response = await httpServices.get(
        url: API.riotDragonUrl,
        path: '/api/versions.json',
        origin: origin,
      );

      return response.fold(
        (l) => Left(l),
        (r) {
          List<GameVersionModel> gameVersions = [];
          r.data.forEach((item) {
            GameVersionDTO dto = GameVersionDTO.fromJsonRemote(item);
            gameVersions.add(
              GameVersionModel(
                version: dto.version,
              ),
            );
          });

          return Right(gameVersions);
        },
      );
    } catch (e) {
      return Left(
        Failure(
          message: 'Falha na busca remota de VERSÕES.',
          error: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<MapaModel>>> fetchMaps() async {
    try {
      final response = await httpServices.get(
        url: API.riotStaticDataUrl,
        path: '/docs/lol/maps.json',
        origin: origin,
      );
      List<MapaModel> mapas = [];

      response.fold((l) => Left(l), (r) {
        r.data.forEach(
          (queue) {
            MapaDTO dto = MapaDTO.fromJson(queue);
            mapas.add(
              MapaModel(
                notes: dto.notes,
                mapaId: dto.mapId,
                mapName: dto.mapName,
              ),
            );
          },
        );
      });

      return Right(mapas);
    } catch (e) {
      return Left(
        Failure(
          message: 'Falha na busca remota de MAPAS.',
          error: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<GameModeModel>>> fetchGameModes() async {
    try {
      final response = await httpServices.get(
        url: API.riotStaticDataUrl,
        path: '/docs/lol/gameModes.json',
        origin: origin,
      );
      List<GameModeModel> gameModes = [];

      response.fold((l) => Left(l), (r) {
        r.data.forEach(
          (queue) {
            GameModeDTO dto = GameModeDTO.fromJson(queue);
            gameModes.add(
              GameModeModel(
                gameMode: dto.gameMode,
                description: dto.description,
              ),
            );
          },
        );
      });

      return Right(gameModes);
    } catch (e) {
      return Left(
        Failure(
          message: 'Falha na busca remota de GAMEMODES.',
          error: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<GameLanguageModel>>> fetchGameLanguages() async {
    try {
      final response = await httpServices.get(
        url: API.riotDragonUrl,
        path: '/cdn/languages.json',
        origin: origin,
      );

      return response.fold(
        (l) => Left(l),
        (r) {
          List<GameLanguageModel> gameLanguages = [];
          r.data.forEach((item) {
            GameLanguageDTO dto = GameLanguageDTO.fromJsonRemote(item);
            gameLanguages.add(
              GameLanguageModel(
                language: dto.language,
              ),
            );
          });

          return Right(gameLanguages);
        },
      );
    } catch (e) {
      return Left(
        Failure(
          message: 'Falha na busca remota de LINGUAGENS.',
          error: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ChampionModel>>> fetchChampions({
    required String version,
    required String language,
  }) async {
    try {
      final response = await httpServices.get(
        url: API.riotDragonUrl,
        path: '/cdn/$version/data/$language/champion.json',
        origin: origin,
      );

      return response.fold(
        (l) => Left(l),
        (r) {
          List<ChampionModel> champions = [];

          r.data["data"].values.forEach(
            (champion) {
              ChampionDTO dto = ChampionDTO.fromJson(champion);
              champions.add(
                ChampionModel(
                  tags: dto.tags,
                  version: dto.version,
                  image: dto.image != null
                      ? ImageModel(
                          full: dto.image!.full,
                          group: dto.image!.group,
                          h: dto.image!.h,
                          sprite: dto.image!.sprite,
                          w: dto.image!.w,
                          x: dto.image!.x,
                          y: dto.image!.y,
                        )
                      : ImageModel.empty(),
                  id: dto.id,
                  blurb: dto.blurb,
                  info: dto.info != null
                      ? InformationModel(
                          attack: dto.info!.attack,
                          defense: dto.info!.defense,
                          difficulty: dto.info!.difficulty,
                          magic: dto.info!.magic,
                        )
                      : InformationModel.empty(),
                  key: dto.key,
                  name: dto.name,
                  partype: dto.partype,
                  stats: dto.stats != null
                      ? ChampionStatsModel(
                          hp: dto.stats!.hp,
                          hpperlevel: dto.stats!.hpperlevel,
                          mp: dto.stats!.mp,
                          mpperlevel: dto.stats!.mpperlevel,
                          movespeed: dto.stats!.movespeed,
                          mpregen: dto.stats!.mpregen,
                          armor: dto.stats!.armor,
                          armorperlevel: dto.stats!.armorperlevel,
                          attackdamage: dto.stats!.attackdamage,
                          attackdamageperlevel: dto.stats!.attackdamageperlevel,
                          attackrange: dto.stats!.attackrange,
                          attackspeed: dto.stats!.attackspeed,
                          attackspeedperlevel: dto.stats!.attackspeedperlevel,
                          crit: dto.stats!.crit,
                          critperlevel: dto.stats!.critperlevel,
                          hpregen: dto.stats!.hpregen,
                          hpregenperlevel: dto.stats!.hpregenperlevel,
                          mpregenperlevel: dto.stats!.mpregenperlevel,
                          spellblock: dto.stats!.spellblock,
                          spellblockperlevel: dto.stats!.spellblockperlevel,
                        )
                      : ChampionStatsModel.empty(),
                  title: dto.title,
                ),
              );
            },
          );

          return Right(champions);
        },
      );
    } catch (e) {
      return Left(
        Failure(
          message: 'Falha na busca remota de CHAMPIONS.',
          error: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ItemMotherModel>> fetchItems({
    required String version,
    required String language,
  }) async {
    try {
      final response = await httpServices.get(
        url: API.riotDragonUrl,
        path: '/cdn/$version/data/$language/item.json',
        origin: origin,
      );

      return response.fold(
        (l) => Left(l),
        (r) {
          List<ItemModel> items = [];
          List<GroupModel> groups = [];
          List<TreeModel> trees = [];

          r.data["data"].values.forEach((element) {
            ItemDTO itemDTO = ItemDTO.fromJson(element);
            items.add(
              ItemModel(
                stats: StatsItemModel(
                  flatMovementSpeedMod: itemDTO.stats!.flatMovementSpeedMod,
                ),
                name: itemDTO.name,
                image: ImageModel(
                  full: itemDTO.image!.full,
                  group: itemDTO.image!.group,
                  h: itemDTO.image!.h,
                  sprite: itemDTO.image!.sprite,
                  w: itemDTO.image!.w,
                  x: itemDTO.image!.x,
                  y: itemDTO.image!.y,
                ),
                tags: itemDTO.tags,
                description: itemDTO.description,
                colloq: itemDTO.colloq,
                gold: GoldModel(
                  base: itemDTO.gold!.base,
                  purchasable: itemDTO.gold!.purchasable,
                  sell: itemDTO.gold!.sell,
                  total: itemDTO.gold!.total,
                ),
                into: itemDTO.into,
                maps: MapsModel(
                  b11: itemDTO.maps!.b11,
                  b12: itemDTO.maps!.b12,
                  b21: itemDTO.maps!.b21,
                  b22: itemDTO.maps!.b22,
                  b30: itemDTO.maps!.b30,
                ),
                plaintext: itemDTO.plaintext,
              ),
            );
          });

          r.data["groups"].forEach((element) {
            GroupDTO groupDTO = GroupDTO.fromJson(element);
            groups.add(
              GroupModel(id: groupDTO.id),
            );
          });

          r.data["tree"].forEach((element) {
            TreeDTO treeDTO = TreeDTO.fromJson(element);
            trees.add(
              TreeModel(
                tags: treeDTO.tags,
                header: treeDTO.header,
              ),
            );
          });

          return Right(
            ItemMotherModel(
              items: items,
              groups: groups,
              trees: trees,
            ),
          );
        },
      );
    } catch (e) {
      return Left(
        Failure(
          message: 'Falha na busca remota de ITEMS.',
          error: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<SummonerSpell>>> fetchSummonerSpells({
    required String version,
    required String language,
  }) async {
    try {
      final response = await httpServices.get(
        url: API.riotDragonUrl,
        path: '/cdn/$version/data/$language/summoner.json',
        origin: origin,
      );

      return response.fold(
        (l) => Left(l),
        (r) {
          List<SummonerSpell> spells = [];

          r.data["data"].values.forEach((element) {
            SummonerSpellDTO dto = SummonerSpellDTO.fromJson(element);
            spells.add(
              SummonerSpell(
                summonerLevel: dto.summonerLevel,
                modes: dto.modes,
                maxAmmo: dto.maxAmmo,
                rangeBurn: dto.rangeBurn,
                cooldownBurn: dto.cooldownBurn,
                description: dto.description,
                image: dto.image != null
                    ? ImageModel(
                        y: dto.image!.y,
                        x: dto.image!.x,
                        w: dto.image!.w,
                        sprite: dto.image!.sprite,
                        h: dto.image!.h,
                        group: dto.image!.group,
                        full: dto.image!.full,
                      )
                    : ImageModel.empty(),
                name: dto.name,
                key: dto.key,
                id: dto.id,
                effectBurn: dto.effectBurn,
                maxRank: dto.maxRank,
                tooltip: dto.tooltip,
              ),
            );
          });

          return Right(spells);
        },
      );
    } catch (e) {
      return Left(
        Failure(
          message: 'Falha na busca remota de SUMMONER SPELLS.',
          error: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<PerkStyleModel>>> fetchSummonerRunes({
    required String version,
    required String region,
  }) async {
    final String path = "/cdn/$version/data/$region/runesReforged.json";

    List<PerkStyleModel> models = [];

    try {
      final response = await httpServices.get(
        url: API.riotDragonUrl,
        path: path,
        origin: origin,
      );

      return response.fold((l) {
        return Left(l);
      }, (r) {
        r.data.forEach((element) {
          PerkStyleDTO dto = PerkStyleDTO.fromJson(element);
          PerkStyleModel model = PerkStyleModel(
            id: dto.id,
            key: dto.key,
            icon: dto.icon,
            name: dto.name,
            slotModels: dto.slotsDTO
                .map(
                  (e) => SlotsModel(
                    runeModels: e.runeDTOs
                        .map(
                          (a) => RuneModel(
                            id: a.id,
                            key: a.key,
                            icon: a.icon,
                            name: a.name,
                            shortDesc: a.shortDesc,
                            longDesc: a.longDesc,
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          );

          models.add(model);
        });

        return Right(models);
      });
    } catch (e) {
      return Left(
        Failure(
          message: 'Falha na busca remota de SUMMONER PERKS.',
          error: e.toString(),
        ),
      );
    }
  }
}
