import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/image_dto.dart';

class ChampionDTO {
  String version;
  String id;
  String key;
  String name;
  String title;
  String blurb;
  InformationDTO? info;
  ImageDTO? image;
  List<String> tags;
  String partype;
  StatsDTO? stats;

  ChampionDTO({
    required this.version,
    required this.id,
    required this.key,
    required this.name,
    required this.title,
    required this.stats,
    required this.partype,
    required this.image,
    required this.info,
    required this.blurb,
    required this.tags,
  });

  factory ChampionDTO.fromJson(Map<String, dynamic> json) {
    return ChampionDTO(
      version: json['version'] ?? "",
      id: json['id'] ?? "",
      key: json['key'] ?? "",
      name: json['name'] ?? "",
      title: json['title'] ?? "",
      blurb: json['blurb'] ?? "",
      info: json['info'] != null ? InformationDTO.fromJson(json['info']) : null,
      image: json['image'] != null ? ImageDTO.fromJson(json['image']) : null,
      tags: json['tags'] != null ? (json['tags'] as List<dynamic>).cast<String>() : [],
      partype: json['partype'] ?? "",
      stats: json['stats'] != null ? StatsDTO.fromJson(json['stats']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': this.version,
      'id': this.id,
      'key': this.key,
      'name': this.name,
      'title': this.title,
      'blurb': this.blurb,
      'info': this.info?.toJson(),
      'image': this.image?.toJson(),
      'tags': this.tags,
      'partype': this.partype,
      'stats': this.stats?.toJson(),
    };
  }
}

class InformationDTO {
  dynamic attack;
  dynamic defense;
  dynamic magic;
  dynamic difficulty;

  InformationDTO({
    required this.attack,
    required this.defense,
    required this.magic,
    required this.difficulty,
  });

  factory InformationDTO.fromJson(Map<String, dynamic> json) {
    return InformationDTO(
      attack: json['attack'] ?? 0,
      defense: json['defense'] ?? 0,
      magic: json['magic'] ?? 0,
      difficulty: json['difficulty'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attack': this.attack,
      'defense': this.defense,
      'magic': this.magic,
      'difficulty': this.difficulty,
    };
  }
}

class StatsDTO {
  dynamic hp;
  dynamic hpperlevel;
  dynamic mp;
  dynamic mpperlevel;
  dynamic movespeed;
  dynamic armor;
  dynamic armorperlevel;
  dynamic spellblock;
  dynamic spellblockperlevel;
  dynamic attackrange;
  dynamic hpregen;
  dynamic hpregenperlevel;
  dynamic mpregen;
  dynamic mpregenperlevel;
  dynamic crit;
  dynamic critperlevel;
  dynamic attackdamage;
  dynamic attackdamageperlevel;
  dynamic attackspeedperlevel;
  dynamic attackspeed;

  StatsDTO({
    required this.spellblockperlevel,
    required this.spellblock,
    required this.mpregenperlevel,
    required this.hpregenperlevel,
    required this.hpregen,
    required this.critperlevel,
    required this.crit,
    required this.attackspeedperlevel,
    required this.attackspeed,
    required this.attackrange,
    required this.attackdamageperlevel,
    required this.attackdamage,
    required this.armorperlevel,
    required this.armor,
    required this.mpregen,
    required this.movespeed,
    required this.mpperlevel,
    required this.mp,
    required this.hpperlevel,
    required this.hp,
  });

  factory StatsDTO.fromJson(Map<String, dynamic> json) {
    return StatsDTO(
      hp: json['hp'] ?? 0,
      hpperlevel: json['hpperlevel'] ?? 0,
      mp: json['mp'] ?? 0,
      mpperlevel: json['mpperlevel'] ?? 0,
      movespeed: json['movespeed'] ?? 0,
      armor: json['armor'] ?? 0,
      armorperlevel: json['armorperlevel'] ?? 0,
      spellblock: json['spellblock'] ?? 0,
      spellblockperlevel: json['spellblockperlevel'] ?? 0,
      attackrange: json['attackrange'] ?? 0,
      hpregen: json['hpregen'] ?? 0,
      hpregenperlevel: json['hpregenperlevel'] ?? 0,
      mpregen: json['mpregen'] ?? 0,
      mpregenperlevel: json['mpregenperlevel'] ?? 0,
      crit: json['crit'] ?? 0,
      critperlevel: json['critperlevel'] ?? 0,
      attackdamage: json['attackdamage'] ?? 0,
      attackdamageperlevel: json['attackdamageperlevel'] ?? 0,
      attackspeedperlevel: json['attackspeedperlevel'] ?? 0,
      attackspeed: json['attackspeed'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hp': this.hp,
      'hpperlevel': this.hpperlevel,
      'mp': this.mp,
      'mpperlevel': this.mpperlevel,
      'movespeed': this.movespeed,
      'armor': this.armor,
      'armorperlevel': this.armorperlevel,
      'spellblock': this.spellblock,
      'spellblockperlevel': this.spellblockperlevel,
      'attackrange': this.attackrange,
      'hpregen': this.hpregen,
      'hpregenperlevel': this.hpregenperlevel,
      'mpregen': this.mpregen,
      'mpregenperlevel': this.mpregenperlevel,
      'crit': this.crit,
      'critperlevel': this.critperlevel,
      'attackdamage': this.attackdamage,
      'attackdamageperlevel': this.attackdamageperlevel,
      'attackspeedperlevel': this.attackspeedperlevel,
      'attackspeed': this.attackspeed,
    };
  }
}
