import 'package:legends_panel/app/data/http/config/dio_client.dart';
import 'package:legends_panel/app/data/http/config/dio_state.dart';
import 'package:legends_panel/app/data/http/config/riot_and_raw_dragon_urls.dart';
import 'package:legends_panel/app/model/general/champion_with_spell.dart';
import 'package:logger/logger.dart';

class BuildPageProvider {

  Logger _logger = Logger();

  String getChampionImage(String championId, String version) {
    final String path = "/cdn/$version/img/champion/$championId.png";
    _logger.i("building Image Champion for mastery URL...");
    try{
      return RiotAndRawDragonUrls.riotDragonUrl + path;
    }catch(e){
      _logger.i("Error to build Image Champion for mastery Url $e");
      return "";
    }
  }

  String getChampionSpellImage(String spellName, String version){
    final String path = "/cdn/$version/img/spell/$spellName.png";
    _logger.i("building spell image champion...");
    try{
      return RiotAndRawDragonUrls.riotDragonUrl + path;
    }catch(e){
      _logger.i("Error to build spell image champion $e");
      return "";
    }
  }

  String getPerkStyleUrl(String perkStyle){
    final String path = "/images/lol/perkStyle/$perkStyle.png";
    _logger.i("building Image Perk Style Url ...");
    try{
      return RiotAndRawDragonUrls.opGGUrl + path;
    }catch(e){
      _logger.i("Error to build Perk Style Image URL ...");
      return "";
    }
  }

  String getSpellBadgeUrl(String spellName, String version){
    final String path = "/cdn/$version/img/spell/$spellName.png";
    _logger.i("building Image Spell Url ...");
    try{
      return RiotAndRawDragonUrls.riotDragonUrl + path;
    }catch(e){
      _logger.i("Error to build Spell Image URL ... $e");
      return "";
    }
  }

  String getItemUrl(String itemId, String version) {
    final String path = "/cdn/$version/img/item/$itemId.png";
    _logger.i("building Image Item URL...");
    try{
      return RiotAndRawDragonUrls.riotDragonUrl + path;
    }catch(e){
      _logger.i("Error to build Image Item Url $e");
      return "";
    }
  }

  String getPerkUrl(String perk){
    final String path = "/images/lol/perk/$perk.png";
    _logger.i("building Image Perk Url ...");
    try{
      return RiotAndRawDragonUrls.opGGUrl + path;
    }catch(e){
      _logger.i("Error to build Perk Image URL ...");
      return "";
    }
  }

  String getPerkShardUrl(String perk){
    final String path = "/images/lol/perkShard/$perk.png";
    _logger.i("building Image Perk shard Url ...");
    try{
      return RiotAndRawDragonUrls.opGGUrl + path;
    }catch(e){
      _logger.i("Error to build Perk shard Image URL ...");
      return "";
    }
  }

  Future<ChampionWithSpell> getChampionForSpell(String championName, String version) async{
    final String path = "/cdn/$version/data/en_US/champion/$championName.json";
    _logger.i("Getting champion spell json ...");
    try{
      DioClient _dioClient = DioClient(url: RiotAndRawDragonUrls.riotDragonUrl);
      final response = await _dioClient.get(path);
      if(response.state == CustomState.SUCCESS){
        _logger.i("Success getting champion spell ...");
        return ChampionWithSpell.fromJson(response.result.data);
      }
    }catch(e){
      _logger.i("Error to get champion spell $e");
      return ChampionWithSpell();
    }
    _logger.i("champion spell not exists ...");
    return ChampionWithSpell();
  }

}