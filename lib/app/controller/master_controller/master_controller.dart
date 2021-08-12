import 'package:get/get.dart';
import 'package:legends_panel/app/data/model/champion.dart';
import 'package:legends_panel/app/data/model/mapMode.dart';
import 'package:legends_panel/app/data/model/spectator/summoner_spell.dart';
import 'package:legends_panel/app/data/repository/master_repository.dart';

class MasterController {

  MasterRepository _masterRepository = MasterRepository();

  RxInt currentPageIndex = 0.obs;

  changeCurrentPageIndex(int newPageIndex){
    currentPageIndex(newPageIndex);
  }

  RxString lolVersion = "".obs;

  setLoLVersion(String version){
    this.lolVersion(version);
  }

  List<Champion> championList = <Champion>[];

  List<Spell> spellList = <Spell>[];

  List<MapMode> mapList = <MapMode>[];

  setChampionList(List<Champion> championList){
    this.championList.addAll(championList);
  }

  getChampionById(String championId){
    return championList.where((champ) => champ.detail.key.toString() == championId).first;
  }

  setSpellList(SummonerSpell summonerSpell){
    spellList.addAll(summonerSpell.spell);
  }

  getSpellById(String spellId){
    return spellList.where((spell) => spell.key.toString() == spellId).first;
  }

  setMapList(List<MapMode> maps){
    mapList.addAll(maps);
  }

  getMap(dynamic mapId){
    return mapList.where((map) => map.mapId == mapId).first;
  }

}