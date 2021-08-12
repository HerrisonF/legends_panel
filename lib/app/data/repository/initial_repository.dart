import 'package:legends_panel/app/data/model/champion.dart';
import 'package:legends_panel/app/data/model/mapMode.dart';
import 'package:legends_panel/app/data/model/spectator/summoner_spell.dart';
import 'package:legends_panel/app/data/provider/initial_provider.dart';

class InitialRepository {

  final InitialProvider _initialProvider = InitialProvider();

  Future<String> getLOLVersion() async {
    return _initialProvider.getLOLVersion();
  }

  Future<List<Champion>> getChampionList(String version) async {
    return _initialProvider.getChampionList(version);
  }

  Future<SummonerSpell> getSpellList(String version) async {
    return _initialProvider.getSpellList(version);
  }

  Future<List<MapMode>> getMapList() async {
    return _initialProvider.getMapList();
  }

}