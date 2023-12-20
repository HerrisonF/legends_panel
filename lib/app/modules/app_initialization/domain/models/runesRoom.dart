class RunesRoom {
  List<PerkStyle> perkStyle = [];
  DateTime actualDate = DateTime.now();
  String lastDate = "";

  RunesRoom();

  RunesRoom.fromJson(Map<String, dynamic> json) {
    lastDate = json['lastDate'] ?? "";
    perkStyle.add(PerkStyle.fromJson(json['perkStyle']));
  }

  Map<String, dynamic> toJson() => {
        'perkStyle': perkStyle,
        'lastDate': lastDate.toString(),
      };

  bool needToLoadVersionFromWeb(){
    var timeDifference = actualDate.difference(lastDate.isEmpty ? DateTime.now() : DateTime.parse(lastDate));
    return timeDifference.inHours > 24;
  }

  @override
  String toString() {
    return 'RunesRoom{perkStyle: $perkStyle, actualDate: $actualDate, lastDate: $lastDate}';
  }
}

class PerkStyle {
  dynamic id = -1;
  String key = "";
  String icon = "";
  String name = "";
  List<Slots> slots = [];

  PerkStyle();

  PerkStyle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    icon = json['icon'];
    name = json['name'];
    if (json['slots'] != null) {
      json['slots'].forEach((element) {
        slots.add(Slots.fromJson(element));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'key': key,
        'icon': icon,
        'name': name,
        'slots': slots,
      };
}

class Slots {
  List<Runes> runes = [];

  Slots();

  Slots.fromJson(Map<String, dynamic> json) {
    if (json['runes'] != null) {
      json['runes'].forEach((element) {
        runes.add(Runes.fromJson(element));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        'runes': runes,
      };

  @override
  String toString() {
    return 'Slots{runes: $runes}';
  }
}

class Runes {
  dynamic id = "";
  String key = "";
  String icon = "";
  String name = "";
  String shortDesc = "";
  String longDesc = "";

  Runes();

  Runes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    icon = json['icon'];
    name = json['name'];
    shortDesc = json['shortDesc'];
    longDesc = json['longDesc'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'key': key,
        'icon': icon,
        'name': name,
        'shortDesc': shortDesc,
        'longDesc': longDesc,
      };

  @override
  String toString() {
    return 'Runes{id: $id, key: $key, icon: $icon, name: $name, shortDesc: $shortDesc, longDesc: $longDesc}';
  }
}
