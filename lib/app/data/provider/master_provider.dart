import 'package:legends_panel/app/data/http/config/dio_client.dart';
import 'package:logger/logger.dart';

class MasterProvider {

  DioClient _dioClient = DioClient(riotDragon: true);
  Logger _logger = Logger();

  String getImageUrl(String championName, String version) {
    final String path = "/cdn/$version/img/champion/${championName.replaceAll(" ", "")}.png";
    _logger.i("building Image URL...");
    try{
        return _dioClient.riotDragonBaseUrl + path;
    }catch(e){
      _logger.i("Error to build Image Url $e");
      return "";
    }
  }
}
