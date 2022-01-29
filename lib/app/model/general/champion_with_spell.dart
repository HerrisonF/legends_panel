class ChampionWithSpell {
  dynamic type = "";
  dynamic format = "";
  dynamic version = "";
  ChampionWithSpellDetail championWithSpellDetail = ChampionWithSpellDetail();

  ChampionWithSpell();

  ChampionWithSpell.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? "";
    format = json['format'] ?? "";
    version = json['version'] ?? "";
    if (json['data'] != null) {
      for (final name in json['data'].keys) {
        championWithSpellDetail = ChampionWithSpellDetail.fromJson(json['data'][name.toString()]);
      }
    }
  }
}

class ChampionWithSpellDetail {
  dynamic id = "";
  dynamic key = "";
  dynamic name = "";
  dynamic title = "";
  ImageChamp imageChamp = ImageChamp();
  List<Skin> skins = [];
  dynamic lore = "";
  dynamic blurb = "";
  List<dynamic> allyTips = [];
  List<dynamic> enemyTips = [];
  List<dynamic> tags = [];
  dynamic parType = "";
  ChampInfo champInfo = ChampInfo();
  ChampStats champStats = ChampStats();
  List<Spell> spells = [];
  Passive passive = Passive();

  ChampionWithSpellDetail();

  ChampionWithSpellDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    key = json['key'] ?? "";
    name = json['name'] ?? "";
    title = json['title'] ?? "";
    imageChamp = ImageChamp.fromJson(json['image']);
    if (json['skins'] != null) {
      json['skins'].forEach((element) {
        skins.add(Skin.fromJson(element));
      });
    }
    lore = json['lore'] ?? "";
    blurb = json['blurb'] ?? "";
    if (json['allytips'] != null) {
      json['allytips'].forEach(
        (e) {
          allyTips.add(e.toString());
        },
      );
    }
    if (json['enemytips'] != null) {
      json['enemytips'].forEach((e) {
        enemyTips.add(e.toString());
      });
    }
    if (json['tags'] != null) {
      json['tags'].forEach((e) {
        tags.add(e.toString());
      });
    }
    parType = json['partype'] ?? "";
    champInfo = ChampInfo.fromJson(json['info']);
    champStats = ChampStats.fromJson(json['stats']);
    if (json['spells'] != null) {
      json['spells'].forEach((e) {
        spells.add(Spell.fromJson(e));
      });
    }
    passive = Passive.fromJson(json['passive']);
  }
}

class ImageChamp {
  dynamic full = "";
  dynamic sprite = "";
  dynamic group = "";
  dynamic x = 0;
  dynamic y = 0;
  dynamic w = 0;
  dynamic h = 0;

  ImageChamp();

  ImageChamp.fromJson(Map<String, dynamic> json) {
    full = json['full'] ?? "";
    sprite = json['sprite'] ?? "";
    group = json['group'] ?? "";
    x = json['x'] ?? 0;
    y = json['y'] ?? 0;
    w = json['w'] ?? 0;
    h = json['h'] ?? 0;
  }
}

class Skin {
  dynamic id = "";
  dynamic num = 0;
  dynamic name = "";
  dynamic chromas = false;

  Skin();

  Skin.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    num = json['num'] ?? 0;
    name = json['name'] ?? "";
    chromas = json['chromas'] ?? false;
  }
}

class ChampInfo {
  dynamic attack = 0;
  dynamic defense = 0;
  dynamic magic = 0;
  dynamic difficulty = 0;

  ChampInfo();

  ChampInfo.fromJson(Map<String, dynamic> json) {
    attack = json['attack'] ?? 0;
    defense = json['defense'] ?? 0;
    magic = json['magic'] ?? 0;
    difficulty = json['difficulty'] ?? 0;
  }
}

class ChampStats {
  dynamic hp = 0;
  dynamic hpperlevel = 0;
  dynamic mp = 0;
  dynamic mpperlevel = 0;
  dynamic movespeed = 0;
  dynamic armor = 0;
  dynamic armorperlevel = 0;
  dynamic spellblock = 0;
  dynamic spellblockperlevel = 0;
  dynamic attackrange = 0;
  dynamic hpregen = 0;
  dynamic hpregenperlevel = 0;
  dynamic mpregen = 0;
  dynamic mpregenperlevel = 0;
  dynamic crit = 0;
  dynamic critperlevel = 0;
  dynamic attackdamage = 0;
  dynamic attackdamageperlevel = 0;
  dynamic attackspeedperlevel = 0;
  dynamic attackspeed = 0;

  ChampStats();

  ChampStats.fromJson(Map<String, dynamic> json) {
    hp = json['hp'] ?? 0;
    hpperlevel = json['hpperlevel'] ?? 0;
    mp = json['mp'] ?? 0;
    mpperlevel = json['mpperlevel'] ?? 0;
    movespeed = json['movespeed'] ?? 0;
    armor = json['armor'] ?? 0;
    armorperlevel = json['armorperlevel'] ?? 0;
    spellblock = json['spellblock'] ?? 0;
    spellblockperlevel = json['spellblockperlevel'] ?? 0;
    attackrange = json['attackrange'] ?? 0;
    hpregen = json['hpregen'] ?? 0;
    hpregenperlevel = json['hpregenperlevel'] ?? 0;
    mpregen = json['mpregen'] ?? 0;
    mpregenperlevel = json['mpregenperlevel'] ?? 0;
    crit = json['crit'] ?? 0;
    critperlevel = json['critperlevel'] ?? 0;
    attackdamage = json['attackdamage'] ?? 0;
    attackdamageperlevel = json['attackdamageperlevel'] ?? 0;
    attackspeed = json['attackspeed'] ?? 0;
    attackspeedperlevel = json['attackspeedperlevel'] ?? 0;
  }
}

class Spell {
  dynamic id = "";
  dynamic name = "";
  dynamic description = "";
  dynamic tooltip = "";
  LevelTip levelTip = LevelTip();
  dynamic maxrank = 0;
  List<dynamic> cooldown = [];
  dynamic cooldownBurn = "";
  List<dynamic> cost = [];
  dynamic costBurn = "";
  List<dynamic> range = [];
  dynamic rangeBurn = "";
  ImageChamp imageChamp = ImageChamp();
  dynamic resource = "";

  Spell();

  Spell.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
    description = json['description'] ?? "";
    tooltip = json['tooltip'] ?? "";
    levelTip = LevelTip.fromJson(json['leveltip']);
    maxrank = json['maxrank'] ?? "";
    if (json['cooldown'] != null) {
      json['cooldown'].forEach((e) {
        cooldown.add(e);
      });
    }
    cooldownBurn = json['cooldownBurn'] ?? "";
    if (json['cost'] != null) {
      json['cost'].forEach((e) {
        cost.add(e);
      });
    }
    costBurn = json['costBurn'] ?? "";
    if(json['range']!= null){
      json['range'].forEach((e){
        range.add(e);
      });
    }
    rangeBurn = json['rangeBurn'] ?? "";
    imageChamp = ImageChamp.fromJson(json['image']);
    resource = json['resource'] ?? "";
  }
}

class LevelTip {
  List<dynamic> label = [];
  List<dynamic> effect = [];

  LevelTip();

  LevelTip.fromJson(Map<String, dynamic> json){
    if(json['label'] != null){
      json['label'].forEach((e){
        label.add(e);
      });
    }
    if(json['effect'] != null){
      json['effect'].forEach((e){
        effect.add(e);
      });
    }
  }
}

class Passive {
  dynamic name = "";
  dynamic description = "";
  ImageChamp imageChamp = ImageChamp();

  Passive();

  Passive.fromJson(Map<String, dynamic> json){
    name = json['name'] ?? "";
    description = json['description'] ?? "";
    imageChamp = ImageChamp.fromJson(json['image']);
  }
}
