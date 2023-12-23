class ChampionStatsDTO {
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

  ChampionStatsDTO({
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

  factory ChampionStatsDTO.fromJson(Map<String, dynamic> json) {
    return ChampionStatsDTO(
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