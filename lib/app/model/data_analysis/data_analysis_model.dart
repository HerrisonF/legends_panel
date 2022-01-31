import 'package:legends_panel/app/model/general/match_detail.dart';

class DataAnalysisModel {

  String collectionChampionId = "";
  List<String> positions = [];
  AmountStatistic amountWinLoseStatistic = AmountStatistic();
  StatisticOnPosition statisticOnPosition = StatisticOnPosition();

  DataAnalysisModel();

  DataAnalysisModel.fromJson(Map<String, dynamic> json){
    if(json["positions"] != null){
      json["positions"].forEach((element){
        positions.add(element);
      });
    }
    amountWinLoseStatistic = AmountStatistic.fromJson(json["amountWinLoseStatistic"]);
    statisticOnPosition = StatisticOnPosition.fromJson(json["statisticOnPosition"]);
  }

  Map<String, dynamic> toJson() =>
      {
        'positions': positions.map((e) => e.toString()).toList(),
        'amountWinLoseStatistic': amountWinLoseStatistic.toJson(),
        'statisticOnPosition': statisticOnPosition.toJson(),
      };

}

class AmountStatistic {
  int total = 0;
  int amountWin = 0;
  int amountLoss = 0;

  //String againstChampId = "";

  AmountStatistic();

  setWinOrLose(bool win) {
    if (win) {
      this.amountWin++;
    } else {
      this.amountLoss++;
    }
    total ++;
  }

  AmountStatistic.fromJson(Map<String, dynamic> json){
    total = json["total"] ?? 0;
    amountWin = json["amountWin"] ?? 0;
    amountLoss = json["amountLoss"] ?? 0;
  }

  Map<String, dynamic> toJson() =>
      {
        'total': total,
        'amountWin': amountWin,
        'amountLoss': amountLoss,
      };
}

class StatisticOnPosition {
  StatisticSkill statisticSkill = StatisticSkill();

  StatisticSpell statisticSpell = StatisticSpell();
  StatisticBuild statisticBuild = StatisticBuild();
  StatisticRune statisticRune = StatisticRune();

  StatisticOnPosition();

  StatisticOnPosition.fromJson(Map<String, dynamic> json){
    statisticSkill = StatisticSkill.fromJson(json["statisticSkill"]);
    statisticBuild = StatisticBuild.fromJson(json["statisticBuild"]);
    statisticRune = StatisticRune.fromJson(json['statisticRune']);
    statisticSpell = StatisticSpell.fromJson(json['statisticSpell']);
  }

  Map<String, dynamic> toJson() =>
      {
        'statisticSkill': statisticSkill.toJson(),
        'statisticBuild': statisticBuild.toJson(),
        'statisticRune' : statisticRune.toJson(),
        'statisticSpell' : statisticSpell.toJson(),
      };
}

class StatisticRune {
  Perk perk = Perk();
  double pickRate = 0;
  double winRate = 0;

  StatisticRune();

  StatisticRune.fromJson(Map<String, dynamic> json){
    perk = Perk.fromJson(json['perk']);
    pickRate = json['pickRate'] ?? 0;
    winRate = json['winRate'] ?? 0;
  }

  Map<String, dynamic> toJson() => {
    'perk' : perk.toJson(),
    'pickRate' : pickRate,
    'winRate' : winRate,
  };
}

class StatisticBuild {
  //InitialItems initialItems = InitialItems();
  CoreItems coreItems = CoreItems();

  //Boots boots = Boots();

  StatisticBuild();

  StatisticBuild.fromJson(Map<String, dynamic> json){
    coreItems = CoreItems.fromJson(json["coreItems"]);
  }

  Map<String, dynamic> toJson() =>
      {
        'coreItems': coreItems.toJson(),
      };
}

// class InitialItems {
//   List<Item> items = [];
// }

class CoreItems {
  List<Item> items = [];

  CoreItems();

  CoreItems.fromJson(Map<String, dynamic> json){
    if(json["items"] != null){
      json["items"].forEach((element){
        items.add(Item.fromJson(element));
      });
    }
  }

  Map<String, dynamic> toJson() =>
      {
        'items': items.map((e) => e.toJson()).toList(),
      };
}

// class Boots {
//   Item items = Item();
// }

class Item {
  String id = "";

  Item();

  Item.fromJson(Map<String, dynamic> json){
    id = json["id"] ?? "";
  }

  // String name = "";
  // String description = "";
  // ItemImage image = ItemImage();

  Map<String, dynamic> toJson() =>
      {
        'id': id,
      };
}

// class ItemImage {
//   String full = "";
//   ItemImage();
// }

class StatisticSpell {
  Spell spell = Spell();

  StatisticSpell();

  StatisticSpell.fromJson(Map<String, dynamic> json){
    spell = Spell.fromJson(json['spell']);
  }

  Map<String, dynamic> toJson() => {
    'spell' : spell.toJson(),
  };
}

class Spell {
  String spellId1 = "";
  String spellId2 = "";
  double pickRate = 0;
  double winRate = 0;

  Spell();

  Spell.fromJson(Map<String, dynamic> json){
    spellId1 = json['spellId1'] ?? "";
    spellId2 = json['spellId2'] ?? "";
  }

  Map<String, dynamic> toJson() => {
    'spellId1' : spellId1,
    'spellId2' : spellId2,
  };

}

class StatisticSkill {
  List<Skill> skillsOrder = [];

  StatisticSkill();

  StatisticSkill.fromJson(Map<String, dynamic> json){
    if(json["skillsOrder"] != null){
      json["skillsOrder"].forEach((element){
        skillsOrder.add(Skill.fromJson(element));
      });
    }
  }

  Map<String, dynamic> toJson() =>
      {
        'skillsOrder': skillsOrder.map((e) => e.toJson()).toList(),
      };
}

class Skill {
  String skillSlot = "";

  Skill();

  Skill.fromJson(Map<String, dynamic> json){
    skillSlot = json["skillSlot"] ?? "";
  }

  Map<String, dynamic> toJson() =>
      {
        'skillSlot': skillSlot,
      };
}
//
// class SpellImage {
//   String full = "";
//
//   SpellImage();
// }