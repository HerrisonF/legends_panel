import 'package:get/get.dart';
import 'package:legends_panel/app/data/http/config/dio_client.dart';
import 'package:legends_panel/app/data/http/config/dio_state.dart';
import 'package:legends_panel/app/model/general/champion_mastery.dart';
import 'package:legends_panel/app/model/general/match_detail.dart';
import 'package:legends_panel/app/model/general/user_tier.dart';
import 'package:logger/logger.dart';

class ProfileProvider {

  DioClient _dioClient = DioClient();
  Logger _logger = Logger();

  String getProfileImage(String version, String profileIconId){
    final String path = "/cdn/$version/img/profileicon/$profileIconId.png";
    _logger.i("building Image profile Url ...");
    try{
      return _dioClient.riotDragonBaseUrl + path;
    }catch(e){
      _logger.i("Error to build Image Profile URL ... $e");
      return "";
    }
  }

  Future<RxList<UserTier>> getUserTier(String encryptedSummonerId, String region) async {
    final String path = "/lol/league/v4/entries/by-summoner/$encryptedSummonerId";
    _logger.i("Getting Summoner Tier");
    try{
      DioClient _dioClient = DioClient(region: region);
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

  Future<RxList<ChampionMastery>> getChampionMastery(String summonerId, String region) async {
    final String path  = "/lol/champion-mastery/v4/champion-masteries/by-summoner/$summonerId";
    _logger.i("Getting Champion Mastery");
    try{
      DioClient _dioClient = DioClient(region: region.isEmpty ? "BR1" : region);
      final response = await _dioClient.get(path);
      RxList<ChampionMastery> championMasteryList = RxList<ChampionMastery>();
      if(response.state == CustomState.SUCCESS){
        if(response.result.data != null){
          for(dynamic championMastery in response.result.data){
            championMasteryList.add(ChampionMastery.fromJson(championMastery));
          }
        }
      }
      return championMasteryList;
    }catch(e){
      _logger.i("Error to get Champion Mastery");
      return RxList<ChampionMastery>();
    }
  }

  String getChampionImage(String championId) {
    final String path = "/cdn/img/champion/splash/${championId}_0.jpg";
    _logger.i("building Image Champion for mastery URL...");
    try{
      return _dioClient.riotDragonBaseUrl + path;
    }catch(e){
      _logger.i("Error to build Image Champion for mastery Url $e");
      return "";
    }
  }

  String getCircularChampionImage(String championId) {
    final String path = "/cdn/11.22.1/img/champion/$championId.png";
    _logger.i("building Image Champion for mastery URL...");
    try{
      return _dioClient.riotDragonBaseUrl + path;
    }catch(e){
      _logger.i("Error to build Image Champion for mastery Url $e");
      return "";
    }
  }

  String getMasteryImage(String championLevel) {
    final String path = "/latest/game/assets/ux/mastery/mastery_icon_$championLevel.png";
    _logger.i("building Image Champion for mastery URL...");
    try{
      return _dioClient.rawDragonBaseUrl + path;
    }catch(e){
      _logger.i("Error to build Image Champion for mastery Url $e");
      return "";
    }
  }

  Future<List<String>> getMatchListIds(String puuid, int start, int count, String region) async {
    final String path = "/lol/match/v5/matches/by-puuid/$puuid/ids";
    _logger.i("Getting MatchList ...");
    List<String> matchListId = [];
    DioClient tempDio = DioClient();
    if(region == "KR" || region == "RU" || region == "JP1" || region == "TR1" || region == "OC1"){
      tempDio = DioClient(asia: true);
    }
    if(region == "EUN1" || region == "EUW1" || region == "NA1"){
      tempDio = DioClient(europe: true);
    }

    if(region == "LA1" || region == "LA2" || region == "BR1" || region.isEmpty){
      tempDio = DioClient(americas: true);
    }

    final  params = {"start": "${start.toString()}", "count" : "${count.toString()}"};
    try{
      final response = await tempDio.get(path, params);
      if(response.state == CustomState.SUCCESS){
        if(response.result.data != null){
          for (String id in response.result.data){
            matchListId.add(id);
          }
          return matchListId;
        }
      }
      _logger.i("MatchList not found ...");
      return matchListId;
    }catch(e){
      _logger.i("Error to get MatchList $e");
      return matchListId;
    }
  }

  Future<MatchDetail> getMatchById(String matchId, String region) async {
    final String path = "/lol/match/v5/matches/$matchId";
    _logger.i("Getting Match by id ...");
    DioClient tempDio = DioClient();
    if(region == "KR" || region == "RU" || region == "JP1" || region == "TR1" || region == "OC1"){
      tempDio = DioClient(asia: true);
    }
    if(region == "EUN1" || region == "EUW1" || region == "NA1"){
      tempDio = DioClient(europe: true);
    }

    if(region == "LA1" || region == "LA2" || region == "BR1" || region.isEmpty){
      tempDio = DioClient(americas: true);
    }
    try{
      final response = await tempDio.get(path);
      if(response.state == CustomState.SUCCESS){
        if(response.result.data != null){
          return MatchDetail.fromJson(response.result.data);
        }
      }
      _logger.i("Match not found ...");
      return MatchDetail();
    }catch(e){
      _logger.i("Error to get MAtch by id $e");
      return MatchDetail();
    }
  }

}

