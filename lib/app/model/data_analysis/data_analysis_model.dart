import 'package:legends_panel/app/model/general/match_detail.dart';

class ChampionStatistic {
  String championId = "";
  List<PositionData> positions = [];

  ChampionStatistic();

  ChampionStatistic.fromJson(Map<String, dynamic> json) {
    if (json["positions"] != null) {
      json["positions"].forEach((element) {
        positions.add(PositionData.fromJson(element));
      });
    }
    championId = json['championId'] ?? "";
  }

  Map<String, dynamic> toJson() => {
        'positions': positions.map((e) => e.toJson()).toList(),
        'championId': championId,
      };
}

class PositionData {
  String name = "";
  int amountPick = 0;
  List<BuildOnPosition> builds = [];

  PositionData.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    amountPick = json['amountPick'] ?? 0;
    if (json["builds"] != null) {
      json["builds"].forEach((element) {
        builds.add(BuildOnPosition.fromJson(element));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        'builds': builds.map((e) => e.toJson()).toList(),
        'name': name,
        'amountPick': amountPick,
      };

  PositionData();
}

class BuildOnPosition {
  String identify = "";
  int amountPick = 0;
  int amountWin = 0;
  SelectedSkill selectedSkill = SelectedSkill();
  SelectedSpell selectedSpell = SelectedSpell();
  SelectedBuild selectedBuild = SelectedBuild();
  SelectedRune selectedRune = SelectedRune();

  BuildOnPosition();

  BuildOnPosition.fromJson(Map<String, dynamic> json) {
    selectedSkill = SelectedSkill.fromJson(json["selectedSkill"]);
    selectedBuild = SelectedBuild.fromJson(json["selectedBuild"]);
    selectedRune = SelectedRune.fromJson(json['selectedRune']);
    selectedSpell = SelectedSpell.fromJson(json['selectedSpell']);
    amountPick = json['amountPick'] ?? 0;
    amountWin = json['amountWin'] ?? 0;
  }

  Map<String, dynamic> toJson() => {
        'selectedSkill': selectedSkill.toJson(),
        'selectedSpell': selectedSpell.toJson(),
        'selectedBuild': selectedBuild.toJson(),
        'selectedRune': selectedRune.toJson(),
        'amountPick': amountPick,
        'amountWin': amountWin,
      };
}

class SelectedRune {
  Perk perk = Perk();

  SelectedRune();

  SelectedRune.fromJson(Map<String, dynamic> json) {
    perk = Perk.fromJson(json['perk']);
  }

  Map<String, dynamic> toJson() => {
        'perk': perk.toJson(),
      };
}

class SelectedBuild {
  SelectedItems selectedItems = SelectedItems();
  SelectedBuild();

  SelectedBuild.fromJson(Map<String, dynamic> json) {
    selectedItems = SelectedItems.fromJson(json["selectedItems"]);
  }

  Map<String, dynamic> toJson() => {
        'selectedItems': selectedItems.toJson(),
      };
}

class SelectedItems {
  List<Item> items = [];

  SelectedItems();

  SelectedItems.fromJson(Map<String, dynamic> json) {
    if (json["items"] != null) {
      json["items"].forEach((element) {
        items.add(Item.fromJson(element));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        'items': items.map((e) => e.toJson()).toList(),
      };
}

class Item {
  String id = "";

  Item();

  Item.fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? "";
  }

  Map<String, dynamic> toJson() => {
        'id': id,
      };
}

class SelectedSpell {
  Spell spell = Spell();

  SelectedSpell();

  SelectedSpell.fromJson(Map<String, dynamic> json) {
    spell = Spell.fromJson(json['spell']);
  }

  Map<String, dynamic> toJson() => {
        'spell': spell.toJson(),
      };
}

class Spell {
  String spellId1 = "";
  String spellId2 = "";

  Spell();

  Spell.fromJson(Map<String, dynamic> json) {
    spellId1 = json['spellId1'] ?? "";
    spellId2 = json['spellId2'] ?? "";
  }

  Map<String, dynamic> toJson() => {
        'spellId1': spellId1,
        'spellId2': spellId2,
      };
}

class SelectedSkill {
  List<Skill> skillsOrder = [];

  SelectedSkill();

  SelectedSkill.fromJson(Map<String, dynamic> json) {
    if (json["skillsOrder"] != null) {
      json["skillsOrder"].forEach((element) {
        skillsOrder.add(Skill.fromJson(element));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        'skillsOrder': skillsOrder.map((e) => e.toJson()).toList(),
      };
}

class Skill {
  String skillSlot = "";

  Skill();

  Skill.fromJson(Map<String, dynamic> json) {
    skillSlot = json["skillSlot"] ?? "";
  }

  Map<String, dynamic> toJson() => {
        'skillSlot': skillSlot,
      };
}
