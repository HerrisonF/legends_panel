import 'package:legends_panel/app/data/provider/build_page_provider/build_page_provider.dart';
import 'package:legends_panel/app/model/general/champion_with_spell.dart';

class BuildPageRepository {

  final BuildPageProvider buildPageProvider = BuildPageProvider();

  String getChampionImage(String championId, String version){
    return buildPageProvider.getChampionImage(championId, version);
  }

  String getChampionSpellImage(String spellName, String version){
    return buildPageProvider.getChampionSpellImage(spellName, version);
  }

  Future<ChampionWithSpell> getChampionForSpell(String championName, String version) async {
    return await buildPageProvider.getChampionForSpell(championName, version);
  }

  String getPerkStyleUrl(String perkStyle){
    return buildPageProvider.getPerkStyleUrl(perkStyle);
  }

  String getPerkUrl(String perk){
    return buildPageProvider.getPerkUrl(perk);
  }

  String getPerkShard(String perkShard){
    return buildPageProvider.getPerkShardUrl(perkShard);
  }

}