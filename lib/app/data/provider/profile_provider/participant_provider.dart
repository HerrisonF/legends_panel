import 'package:get/get.dart';
import 'package:legends_panel/app/data/http/config/dio_client.dart';
import 'package:legends_panel/app/data/http/config/dio_state.dart';
import 'package:legends_panel/app/data/http/config/riot_and_raw_dragon_urls.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_spectator.dart';
import 'package:legends_panel/app/model/general/user_tier.dart';
import 'package:logger/logger.dart';

class ParticipantProvider {

  Logger _logger = Logger();

  Future<RxList<UserTier>> getUserTier(String encryptedSummonerId, String region) async {
    final String path = "/lol/league/v4/entries/by-summoner/$encryptedSummonerId";
    _logger.i("Getting Summoner Tier");
    try{
      DioClient _dioClient = DioClient(url: RiotAndRawDragonUrls.riotBaseUrl(region));
      final response = await _dioClient.get(path);
      RxList<UserTier> listTier  = RxList<UserTier>();
      if(response.state == CustomState.SUCCESS){
        if(response.result.data != null){
          for(dynamic tier in response.result.data){
            listTier.add(UserTier.fromJson(tier));
          }
        }
        return listTier;
      }
      _logger.i("UserTier not found ...");
      return listTier;
    }catch(e){
      _logger.i("Error to get UserTier ... $e");
      return RxList<UserTier>();
    }
  }

  String getUserTierImage(String tier){
    _logger.i("building Image Tier Url ...");
    try{
      return "images/ranked_mini_emblems/${tier.toLowerCase()}.png";
    }catch(e){
      _logger.i("Error to build Tier Image URL ... $e");
      return "";
    }
  }

  String getChampionBadgeUrl(String championId, String version) {
    _logger.i("building Image Champion URL... $championId # $version");
    final String path = "/cdn/$version/img/champion/$championId.png";
    try{
      return RiotAndRawDragonUrls.riotDragonUrl + path;
    }catch(e){
      _logger.i("Error to build Image Champion Url $e");
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

  String getPositionUrl(String position, String version) {
    final String path = "/latest/plugins/rcp-fe-lol-clash/global/default/assets/images/position-selector/positions/icon-position-${position.toLowerCase()}.png";
    _logger.i("building Image Positon URL...");
    try{
      return RiotAndRawDragonUrls.rawDataDragonUrl + path;
    }catch(e){
      _logger.i("Error to build Image Position Url $e");
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

  Future<CurrentGameSpectator> getSpectator(String userId, String region) async {
    final String path = "/lol/spectator/v4/active-games/by-summoner/$userId";
    _logger.i("Fetching Current Game ...");
    try{
      DioClient _dioClient = DioClient(url: RiotAndRawDragonUrls.riotBaseUrl(region));
      final response = await _dioClient.get(path);
      if(response.state == CustomState.SUCCESS){
        return CurrentGameSpectator.fromJson(response.result.data);
      }
    }catch(e){
      _logger.i("Error fetching Current Game $e");
      return CurrentGameSpectator();
    }
    _logger.i("No current game found ...");
    return CurrentGameSpectator();
  }

  String getPerkUrl(String iconName){
    //perk-images/Styles/Precision/LethalTempo/LethalTempoTemp.png
    final String path = "/cdn/img/$iconName";
    _logger.i("building Image Perk Url ...");
    try{
      return RiotAndRawDragonUrls.riotDragonUrl + path;
    }catch(e){
      _logger.i("Error to build Perk Image URL ...");
      return "";
    }
  }

}