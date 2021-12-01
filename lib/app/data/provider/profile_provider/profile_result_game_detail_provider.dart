import 'package:legends_panel/app/data/http/config/dio_client.dart';
import 'package:legends_panel/app/data/http/config/dio_state.dart';
import 'package:legends_panel/app/model/general/match_detail.dart';
import 'package:logger/logger.dart';

class ProfileResultGameDetailProvider {

  Logger _logger = Logger();

  // Future<MatchDetail> getMatchDetail(String matchId) async{
  //   final String path = "/lol/match/v4/matches/$matchId";
  //   _logger.i("Getting match detail ...");
  //   try{
  //     final response = await _dioClient.get(path);
  //     if(response.state == CustomState.SUCCESS){
  //       if(response.result.data != null){
  //         return MatchDetail.fromJson(response.result.data);
  //       }
  //     }
  //     return MatchDetail();
  //   }catch(e){
  //     _logger.i("Error to Get match Detail $e");
  //     return MatchDetail();
  //   }
  // }

}