import 'package:legends_panel/app/data/http/config/riot_and_raw_dragon_urls.dart';
import 'package:logger/logger.dart';

class GeneralVisionProvider {

  Logger _logger = Logger();

  String getBaronIcon(){
    final String path = "/images/site/summoner/icon-baron-b.png";
    _logger.i("building Image Baron Url ...");
    try{
      return RiotAndRawDragonUrls.opGGUrl + path;
    }catch(e){
      _logger.i("Error to build Baron Image URL ...");
      return "";
    }
  }

  String getDragonIcon(){
    final String path = "/images/site/summoner/icon-dragon-b.png";
    _logger.i("building Image Dragon Url ...");
    try{
      return RiotAndRawDragonUrls.opGGUrl + path;
    }catch(e){
      _logger.i("Error to build Dragon Image URL ...");
      return "";
    }
  }

  String getTowerIcon(){
    final String path = "/images/site/summoner/icon-tower-b.png";
    _logger.i("building Image Tower Url ...");
    try{
      return RiotAndRawDragonUrls.opGGUrl + path;
    }catch(e){
      _logger.i("Error to build Tower Image URL ...");
      return "";
    }
  }

  String getKillIcon(){
    final String path = "/images/site/summoner/icon-kda.png";
    _logger.i("building Image Kill Url ...");
    try{
      return RiotAndRawDragonUrls.opGGUrl + path;
    }catch(e){
      _logger.i("Error to build Kill Image URL ...");
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

}