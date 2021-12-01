class SummonerSpell {
  String type = "";
  String version = "";
  List<Spell> spells = <Spell>[];

  SummonerSpell();

  SummonerSpell.fromJson(Map<String, dynamic> json){
    type = json['type']??"";
    version = json['version']??"";
    if(json['data'] != null){
      for (final name in json['data'].keys) {
        spells.add(Spell.fromJson(json['data'][name]));
      }
    }
  }

  Map<String, dynamic> toJson()=> {
    'type': type,
    'version' : version,
    'spell' : spells,
  };

  @override
  String toString() {
    return 'SummonerSpell{type: $type, version: $version, spell: $spells}';
  }
}

class Spell {
  String id = "";
  String name = "";
  String description = "";
  String key = "";
  Image image = Image();

  Spell();

  Spell.fromJson(Map<String, dynamic> json){
    id = json['id']??"";
    name = json['name']??"";
    description = json['description']??"";
    key = json['key']??"";
    image = Image.fromJson(json['image']);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name' : name,
    'description' : description,
    'key' : key,
    'image' : image,
  };

  @override
  String toString() {
    return 'Spell{id: $id, name: $name, description: $description, key: $key, image: $image}';
  }
}

class Image {
  String full = "";
  String sprite = "";
  String group = "";

  Image();

  Image.fromJson(Map<String, dynamic> json){
    full = json['full']??"";
    sprite = json['sprite']??"";
    group = json['group']??"";
  }

  Map<String, dynamic> toJson() => {
    'full' : full,
    'sprite' : sprite,
    'group' : group,
  };

  @override
  String toString() {
    return 'Image{full: $full, sprite: $sprite, group: $group}';
  }
}