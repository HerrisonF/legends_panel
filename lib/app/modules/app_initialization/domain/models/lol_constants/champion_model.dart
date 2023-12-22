import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/image_model.dart';

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
  dynamic attack;
  dynamic defense;
  dynamic magic;
  dynamic difficulty;

  InformationModel({
    required this.attack,
    required this.defense,
    required this.magic,
    required this.difficulty,
  });

  factory InformationModel.empty() {
    return InformationModel(
      attack: 0,
      defense: 0,
      magic: 0,
      difficulty: 0,
    );
  }
}

class StatsModel {
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

  factory StatsModel.empty() {
    return StatsModel(
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
