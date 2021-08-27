class SummonerSpell {
  String type = "";
  String version = "";
  List<Spell> spell = <Spell>[];

  SummonerSpell();

  SummonerSpell.fromJson(Map<String, dynamic> json){
    type = json['type']??"";
    version = json['version']??"";
    if(json['data'] != null){
      for (final name in json['data'].keys) {
        spell.add(Spell.fromJson(json['data'][name]));
      }
    }
  }

  @override
  String toString() {
    return 'SummonerSpell{type: $type, version: $version, spell: $spell}';
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

  @override
  String toString() {
    return 'Image{full: $full, sprite: $sprite, group: $group}';
  }
}