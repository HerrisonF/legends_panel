class SummonerSpell {
  String type = "";
  String version = "";
  List<Spell> spell = <Spell>[];

  SummonerSpell(this.type, this.version, this.spell);

  SummonerSpell.fromJson(Map<String, dynamic> json){
    type = json['type'];
    version = json['version'];
    if(json['data'] != null){
      for (final name in json['data'].keys) {
        spell.add(Spell.fromJson(json['data'][name]));
      }
    }
  }
}

class Spell {
  String id = "";
  String name = "";
  String description = "";
  String key = "";
  Image image = Image();

  Spell(this.id, this.name, this.description, this.key, this.image);

  Spell.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    key = json['key'];
    image = Image.fromJson(json['image']);
  }
}

class Image {
  String full = "";
  String sprite = "";
  String group = "";

  Image({this.full = "", this.sprite = "", this.group = ""});

  Image.fromJson(Map<String, dynamic> json){
    full = json['full'];
    sprite = json['sprite'];
    group = json['group'];
  }

}