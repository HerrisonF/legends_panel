class ChampionDTO {
  String type;
  String format;
  String version;
  DetailDTO? detailDTO;

  ChampionDTO({
    required this.type,
    required this.format,
    required this.version,
    required this.detailDTO,
  });

  factory ChampionDTO.fromJson(Map<String, dynamic> json, name) {
    return ChampionDTO(
      type: json['type'] ?? "",
      format: json['format'] ?? "",
      version: json['version'] ?? "",
      detailDTO: json[name] != null ? DetailDTO.fromJson(json[name]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': this.type,
      'format': this.format,
      'version': this.version,
      'data': this.detailDTO?.toJson(),
    };
  }
}

class DetailDTO {
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
  StatsDTO stats;

  DetailDTO({
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

  factory DetailDTO.fromJson(Map<String, dynamic> json) {
    return DetailDTO(
      version: json['version'] ?? "",
      id: json['id'] ?? "",
      key: json['key'] ?? "",
      name: json['name'] ?? "",
      title: json['title'] ?? "",
      blurb: json['blurb'] ?? "",
      info: json['info'] ?? InformationDTO.fromJson(json['info']),
      image: json['image'] ?? ImageDTO.fromJson(json['image']),
      tags: json['tags'] ??
          (json['tags'] as List<dynamic>).map((tag) => tag as String).toList(),
      partype: json['partype'] ?? "",
      stats: json['stats'] ?? StatsDTO.fromJson(json['stats']),
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
      'stats': this.stats.toJson(),
    };
  }
}

class InformationDTO {
  double attack = 0;
  double defense = 0;
  double magic = 0;
  double difficulty = 0;

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

class ImageDTO {
  String full;
  String sprite;
  String group;
  double x;
  double y;
  double w;
  double h;

  ImageDTO({
    required this.full,
    required this.sprite,
    required this.group,
    required this.x,
    required this.y,
    required this.w,
    required this.h,
  });

  factory ImageDTO.fromJson(Map<String, dynamic> json) {
    return ImageDTO(
      full: json['full'] ?? "",
      sprite: json['sprite'] ?? "",
      group: json['group'] ?? "",
      x: json['x'] ?? 0,
      y: json['y'] ?? 0,
      w: json['w'] ?? 0,
      h: json['h'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full': this.full,
      'sprite': this.sprite,
      'group': this.group,
      'x': this.x,
      'y': this.y,
      'w': this.w,
      'h': this.h,
    };
  }
}

class StatsDTO {
  double hp = 0;
  double hpperlevel = 0;
  double mp = 0;
  double mpperlevel = 0;
  double movespeed = 0;
  double armor = 0;
  double armorperlevel = 0;
  double spellblock = 0;
  double spellblockperlevel = 0;
  double attackrange = 0;
  double hpregen = 0;
  double hpregenperlevel = 0;
  double mpregen = 0;
  double mpregenperlevel = 0;
  double crit = 0;
  double critperlevel = 0;
  double attackdamage = 0;
  double attackdamageperlevel = 0;
  double attackspeedperlevel = 0;
  double attackspeed = 0;

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
