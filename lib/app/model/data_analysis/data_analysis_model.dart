class DataAnalysisModel {

  String collectionChampionId = "";
  List<String> positions = [];
  AmountStatistic amountWinLoseStatistic = AmountStatistic();
  StatisticOnPosition statisticOnPosition = StatisticOnPosition();

  DataAnalysisModel();

  //StatisticRune statisticRune = StatisticRune();

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

  //StatisticSpell statisticSpells = StatisticSpell();
  StatisticBuild statisticBuild = StatisticBuild();

  //StatisticRune statisticRune = StatisticRune();

  StatisticOnPosition();

  StatisticOnPosition.fromJson(Map<String, dynamic> json){
    statisticSkill = StatisticSkill.fromJson(json["statisticSkill"]);
    statisticBuild = StatisticBuild.fromJson(json["statisticBuild"]);
  }

  Map<String, dynamic> toJson() =>
      {
        'statisticSkill': statisticSkill.toJson(),
        'statisticBuild': statisticBuild.toJson(),
      };
}

// class StatisticRune {
//   RunesStyle option1 = RunesStyle();
//   RunesStyle option2 = RunesStyle();
//   double pickRateOption1 = 0;
//   double winRateOption1 = 0;
//   double pickRateOption2 = 0;
//   double winRateOption2 = 0;
//
//   setPickRate(RunesStyle runesStyle, bool win){
//     if(option1 == runesStyle){
//       pickRateOption1++;
//       if(win){
//         winRateOption1++;
//       }
//     }
//     if(option2 == runesStyle){
//       if(win){
//         winRateOption2++;
//       }
//     }
//   }
// }
//
// class RunesStyle{
//   dynamic id = "";
//   String key = "";
//   String icon = "";
//   String name = "";
//   String shortDesc = "";
//   String longDesc = "";
//
//   RunesStyle();
// }

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

// class StatisticSpell {
//   List<SpellOption> spellOptions = [];
// }
//
// class SpellOption {
//   String spellId1 = "";
//   String spellId2 = "";
//   double pickRate = 0;
//   double winRate = 0;
//
//   setPickRate(String spellId1, String spellId2){
//     if(this.spellId1 == spellId1 && this.spellId2 == spellId2){
//       pickRate ++;
//     }
//   }
//
//   setWinRate(bool win){
//     if(win){
//       winRate++;
//     }
//   }
//
// }
//
class StatisticSkill {
  //List<Skill> firstThreeSkills = [];
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

// String spellId = "";
// String name = "";
// String description = "";
//SpellImage spellImage = SpellImage();

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