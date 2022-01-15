import 'package:legends_panel/app/model/general/champion.dart';

class DataAnalysisModel {

  String collectionChampionId = "";
  Champion champion = Champion();
  String positions = "";
  int totalGames = 0;
  AmountStatistic amountVictory = AmountStatistic();
  AmountStatistic amountLoss = AmountStatistic();

}

class AmountStatistic{
  int total = 0;
  int amountWin = 0;
  int amountLoss = 0;
  String againstChampId = "";

  AmountStatistic();
}

class EstatisticOnPosition{
  StatisticSkill statisticSkill = StatisticSkill();
  StatisticSpell statisticSpells = StatisticSpell();
  StatisticBuild statisticBuild = StatisticBuild();
  StatisticRune statisticRune = StatisticRune();
}

class StatisticRune {
  RunesStyle option1 = RunesStyle();
  RunesStyle option2 = RunesStyle();
  double pickRateOption1 = 0;
  double winRateOption1 = 0;
  double pickRateOption2 = 0;
  double winRateOption2 = 0;

  setPickRate(RunesStyle runesStyle, bool win){
    if(option1 == runesStyle){
      pickRateOption1++;
      if(win){
        winRateOption1++;
      }
    }
    if(option2 == runesStyle){
      if(win){
        winRateOption2++;
      }
    }
  }
}

class RunesStyle{
  dynamic id = "";
  String key = "";
  String icon = "";
  String name = "";
  String shortDesc = "";
  String longDesc = "";

  RunesStyle();
}

class StatisticBuild {
 InitialItems initialItems = InitialItems();
 List<CoreItems> coreItems = [];
 List<Boots> boots = [];
}

class InitialItems {
  List<Item> option1 = [];
  List<Item> option2 = [];
  setInitialItemsPickRate(Item item, Item item2, bool win){
    if(item.id == option1[0].id && item2.id == option1[1].id){
      pickRateOption1++;
      if(win){
        winRateOption1++;
      }
    }
    if(item.id == option2[0].id && item2.id == option2[1].id){
      pickRateOption2++;
      if(win){
        winRateOption2++;
      }
    }
  }
  double pickRateOption1 = 0;
  double winRateOption1 = 0;
  double pickRateOption2 = 0;
  double winRateOption2 = 0;
}

class CoreItems {
  List<Item> option1 = [];
  List<Item> option2 = [];
  double pickRateOption1 = 0;
  double winRateOption1 = 0;
  double pickRateOption2 = 0;
  double winRateOption2 = 0;

  setCoreItemsPickRate(Item item, Item item2, Item item3, bool win){
    if(item.id == option1[0].id && item2.id == option1[1].id && item3.id == option1[3].id){
      pickRateOption1++;
      if(win){
        winRateOption1++;
      }
    }
    if(item.id == option1[0].id && item2.id == option1[1].id && item3.id == option1[3].id){
      pickRateOption2++;
      if(win){
        winRateOption2++;
      }
    }
  }
}

class Boots {
  Item option1 = Item();
  Item option2 = Item();
  double pickRateOption1 = 0;
  double winRateOption1 = 0;
  double pickRateOption2 = 0;
  double winRateOption2 = 0;

  setBootsPikRate(Item item, bool win){
    if(option1.id == item.id){
      pickRateOption1++;
      if(win){
        winRateOption1++;
      }
    }
    if(option2.id == item.id){
      pickRateOption2++;
      if(win){
        winRateOption2++;
      }
    }
  }
}

class Item{
  String id = "";
  String name = "";
  String description = "";
  ItemImage image = ItemImage();
}

class ItemImage {
  String full = "";
  ItemImage();
}

class StatisticSpell {
  List<SpellOption> spellOptions = [];
}

class SpellOption {
  String spellId1 = "";
  String spellId2 = "";
  double pickRate = 0;
  double winRate = 0;

  setPickRate(String spellId1, String spellId2){
    if(this.spellId1 == spellId1 && this.spellId2 == spellId2){
      pickRate ++;
    }
  }

  setWinRate(bool win){
    if(win){
      winRate++;
    }
  }

}

class StatisticSkill {
  List<Skill> firstThreeSkills = [];
  List<Skill> orderedSkillsLeveled = [];
}

class Skill {
  String spellId = "";
  String name = "";
  String description = "";
  SpellImage spellImage = SpellImage();
}

class SpellImage {
  String full = "";

  SpellImage();
}