class ChampionModel {
  String version;
  String id;
  String key;
  String name;
  String title;
  String blurb;
  InformationModel info;
  ImageModel image;
  List<String> tags;
  String partype;
  StatsModel stats;

  ChampionModel({
    required this.version,
    required this.id,
    required this.key,
    required this.name,
    required this.title,
    required this.blurb,
    required this.info,
    required this.image,
    required this.tags,
    required this.partype,
    required this.stats,
  });
}

class InformationModel {
  double attack;
  double defense;
  double magic;
  double difficulty;

  InformationModel({
    required this.attack,
    required this.defense,
    required this.magic,
    required this.difficulty,
  });
}

class ImageModel {
  String full;
  String sprite;
  String group;
  double x;
  double y;
  double w;
  double h;

  ImageModel({
    required this.full,
    required this.sprite,
    required this.group,
    required this.x,
    required this.y,
    required this.w,
    required this.h,
  });
}

class StatsModel {
  double hp;
  double hpperlevel;
  double mp;
  double mpperlevel;
  double movespeed;
  double armor;
  double armorperlevel;
  double spellblock;
  double spellblockperlevel;
  double attackrange;
  double hpregen;
  double hpregenperlevel;
  double mpregen;
  double mpregenperlevel;
  double crit;
  double critperlevel;
  double attackdamage;
  double attackdamageperlevel;
  double attackspeedperlevel;
  double attackspeed;

  StatsModel({
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
}
