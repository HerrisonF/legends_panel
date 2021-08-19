import 'package:get/get.dart';
import 'package:legends_panel/app/data/http/config/dio_client.dart';
import 'package:legends_panel/app/data/http/config/dio_state.dart';
import 'package:legends_panel/app/data/model/spectator/spectator.dart';
import 'package:legends_panel/app/data/model/userTier.dart';
import 'package:logger/logger.dart';

class ParticipantProvider {

  DioClient _dioClient = DioClient();
  Logger _logger = Logger();

  Future<RxList<UserTier>> getUserTier(String encryptedSummonerId) async {
    final String path = "/lol/league/v4/entries/by-summoner/$encryptedSummonerId";
    _logger.i("Getting Summoner Tier");
    try{
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
    final String path = "/latest/plugins/rcp-fe-lol-static-assets/global/default/images/ranked-mini-regalia/${tier.toLowerCase()}.png";
    _logger.i("building Image Tier Url ...");
    try{
      return _dioClient.rawDragonBaseUrl + path;
    }catch(e){
      _logger.i("Error to build Tier Image URL ... $e");
      return "";
    }
  }

  String getChampionBadgeUrl(String championId, String version) {
    final String path = "/cdn/$version/img/champion/$championId.png";
    _logger.i("building Image Champion URL...");
    try{
      return _dioClient.riotDragonBaseUrl + path;
    }catch(e){
      _logger.i("Error to build Image Champion Url $e");
      return "";
    }
  }

  String getSpellBadgeUrl(String spellName, String version){
    final String path = "/cdn/$version/img/spell/$spellName.png";
    _logger.i("building Image Spell Url ...");
    try{
      return _dioClient.riotDragonBaseUrl + path;
    }catch(e){
      _logger.i("Error to build Spell Image URL ... $e");
      return "";
    }
  }

  Future<Spectator> getSpectator(String userId) async {
    final String path = "/lol/spectator/v4/active-games/by-summoner/$userId";
    _logger.i("Fetching Current Game ...");
    try{
      final response = await _dioClient.get(path);
      if(response.state == CustomState.SUCCESS){
        return Spectator.fromJson(response.result.data);
      }
    }catch(e){
      _logger.i("Error fetching Current Game $e");
      return Spectator();
    }
    _logger.i("No current game found ...");
    return Spectator();
  }

}