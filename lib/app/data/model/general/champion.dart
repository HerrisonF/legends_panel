class Champion {
  String type = "";
  String format = "";
  String version = "";
  Detail detail = Detail();

  Champion();

  Champion.fromJson(Map<String, dynamic> json, name) {
    type = json['type'] ?? "";
    format = json['format'] ?? "";
    version = json['version'] ?? "";
    detail = json[name] != null ? Detail.fromJson(json[name]) : Detail();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['format'] = this.format;
    data['version'] = this.version;
    data['data'] = this.detail.toJson();
    return data;
  }

  @override
  String toString() {
    return 'Champion{type: $type, format: $format, version: $version, detail: $detail}';
  }
}

class Detail {
  String version = "";
  String id = "";
  String key = "";
  String name = "";
  String title = "";
  String blurb = "";
  Information info = Information();
  Image image = Image();
  List<String> tags = [];
  String partype = "";
  Stats stats = Stats();

  Detail();

  Detail.fromJson(Map<String, dynamic> json) {
    version = json['version'] ?? "";
    id = json['id'] ?? "";
    key = json['key'] ?? "";
    name = json['name'] ?? "";
    title = json['title'] ?? "";
    blurb = json['blurb'] ?? "";
    info = json['info'] != null ? Information.fromJson(json['info']) : Information();
    image = json['image'] != null ? Image.fromJson(json['image']) : Image();
    if(json['tags'] != null){
      json['tags'].map((tag) => tags.add(tag));
    }
    partype = json['partype'];
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : Stats();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this.version;
    data['id'] = this.id;
    data['key'] = this.key;
    data['name'] = this.name;
    data['title'] = this.title;
    data['blurb'] = this.blurb;
    data['info'] = this.info.toJson();
    data['image'] = this.image.toJson();
    data['tags'] = this.tags;
    data['partype'] = this.partype;
    data['stats'] = this.stats.toJson();

    return data;
  }

  @override
  String toString() {
    return 'Detail{version: $version, id: $id, key: $key, name: $name, title: $title, blurb: $blurb, info: $info, image: $image, tags: $tags, partype: $partype, stats: $stats}';
  }
}

class Information {
  dynamic attack = 0;
  dynamic defense = 0;
  dynamic magic = 0;
  dynamic difficulty = 0;

  Information();

  Information.fromJson(Map<String, dynamic> json) {
    attack = json['attack'] ?? 0;
    defense = json['defense'] ?? 0;
    magic = json['magic'] ?? 0;
    difficulty = json['difficulty'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attack'] = this.attack;
    data['defense'] = this.defense;
    data['magic'] = this.magic;
    data['difficulty'] = this.difficulty;
    return data;
  }

  @override
  String toString() {
    return 'Information{attack: $attack, defense: $defense, magic: $magic, difficulty: $difficulty}';
  }
}

class Image {
  String full = "";
  String sprite = "";
  String group = "";
  dynamic x = 0;
  dynamic y = 0;
  dynamic w = 0;
  dynamic h = 0;

  Image();

  Image.fromJson(Map<String, dynamic> json) {
    full = json['full']??"";
    sprite = json['sprite']??"";
    group = json['group']??"";
    x = json['x']?? 0;
    y = json['y']??0;
    w = json['w']??0;
    h = json['h']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full'] = this.full;
    data['sprite'] = this.sprite;
    data['group'] = this.group;
    data['x'] = this.x;
    data['y'] = this.y;
    data['w'] = this.w;
    data['h'] = this.h;
    return data;
  }

  @override
  String toString() {
    return 'Image{full: $full, sprite: $sprite, group: $group, x: $x, y: $y, w: $w, h: $h}';
  }
}

class Stats {
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

  Stats();

  Stats.fromJson(Map<String, dynamic> json) {
    hp = json['hp']??0;
    hpperlevel = json['hpperlevel']??0;
    mp = json['mp']??0;
    mpperlevel = json['mpperlevel']??0;
    movespeed = json['movespeed']??0;
    armor = json['armor']??0;
    armorperlevel = json['armorperlevel']??0;
    spellblock = json['spellblock']??0;
    spellblockperlevel = json['spellblockperlevel']??0;
    attackrange = json['attackrange']??0;
    hpregen = json['hpregen']??0;
    hpregenperlevel = json['hpregenperlevel']??0;
    mpregen = json['mpregen']??0;
    mpregenperlevel = json['mpregenperlevel']??0;
    crit = json['crit']??0;
    critperlevel = json['critperlevel']??0;
    attackdamage = json['attackdamage']??0;
    attackdamageperlevel = json['attackdamageperlevel']??0;
    attackspeedperlevel = json['attackspeedperlevel']??0;
    attackspeed = json['attackspeed']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hp'] = this.hp;
    data['hpperlevel'] = this.hpperlevel;
    data['mp'] = this.mp;
    data['mpperlevel'] = this.mpperlevel;
    data['movespeed'] = this.movespeed;
    data['armor'] = this.armor;
    data['armorperlevel'] = this.armorperlevel;
    data['spellblock'] = this.spellblock;
    data['spellblockperlevel'] = this.spellblockperlevel;
    data['attackrange'] = this.attackrange;
    data['hpregen'] = this.hpregen;
    data['hpregenperlevel'] = this.hpregenperlevel;
    data['mpregen'] = this.mpregen;
    data['mpregenperlevel'] = this.mpregenperlevel;
    data['crit'] = this.crit;
    data['critperlevel'] = this.critperlevel;
    data['attackdamage'] = this.attackdamage;
    data['attackdamageperlevel'] = this.attackdamageperlevel;
    data['attackspeedperlevel'] = this.attackspeedperlevel;
    data['attackspeed'] = this.attackspeed;
    return data;
  }

  @override
  String toString() {
    return 'Stats{hp: $hp, hpperlevel: $hpperlevel, mp: $mp, mpperlevel: $mpperlevel, movespeed: $movespeed, armor: $armor, armorperlevel: $armorperlevel, spellblock: $spellblock, spellblockperlevel: $spellblockperlevel, attackrange: $attackrange, hpregen: $hpregen, hpregenperlevel: $hpregenperlevel, mpregen: $mpregen, mpregenperlevel: $mpregenperlevel, crit: $crit, critperlevel: $critperlevel, attackdamage: $attackdamage, attackdamageperlevel: $attackdamageperlevel, attackspeedperlevel: $attackspeedperlevel, attackspeed: $attackspeed}';
  }
}
