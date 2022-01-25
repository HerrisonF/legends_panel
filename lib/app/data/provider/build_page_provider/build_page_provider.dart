import 'package:legends_panel/app/data/http/config/riot_and_raw_dragon_urls.dart';
import 'package:logger/logger.dart';

class BuildPageProvider {

  Logger _logger = Logger();

  String getChampionImage(String championId) {
    final String path = "/cdn/11.22.1/img/champion/$championId.png";
    _logger.i("building Image Champion for mastery URL...");
    try{
      return RiotAndRawDragonUrls.riotDragonUrl + path;
    }catch(e){
      _logger.i("Error to build Image Champion for mastery Url $e");
      return "";
    }
  }

}