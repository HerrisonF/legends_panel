class ChampionStatsModel {
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

  ChampionStatsModel({
    required this.hp,
    required this.hpperlevel,
    required this.mp,
    required this.mpperlevel,
    required this.movespeed,
    required this.mpregen,
    required this.armor,
    required this.armorperlevel,
    required this.attackdamage,
    required this.attackdamageperlevel,
    required this.attackrange,
    required this.attackspeed,
    required this.attackspeedperlevel,
    required this.crit,
    required this.critperlevel,
    required this.hpregen,
    required this.hpregenperlevel,
    required this.mpregenperlevel,
    required this.spellblock,
    required this.spellblockperlevel,
  });

  factory ChampionStatsModel.empty() {
    return ChampionStatsModel(
      hp: 0,
      hpperlevel: 0,
      mp: 0,
      mpperlevel: 0,
      movespeed: 0,
      mpregen: 0,
      armor: 0,
      armorperlevel: 0,
      attackdamage: 0,
      attackdamageperlevel: 0,
      attackrange: 0,
      attackspeed: 0,
      attackspeedperlevel: 0,
      crit: 0,
      critperlevel: 0,
      hpregen: 0,
      hpregenperlevel: 0,
      mpregenperlevel: 0,
      spellblock: 0,
      spellblockperlevel: 0,
    );
  }
}