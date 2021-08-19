import 'package:legends_panel/app/data/model/spectator/spectator.dart';
import 'package:legends_panel/app/data/provider/sub_profile_result_provider.dart';

class SubProfileResultRepository {

  final SubProfileResultProvider _subProfileResultProvider = SubProfileResultProvider();

  Future<Spectator> fetchCurrentGame(String userId){
    return _subProfileResultProvider.fetchCurrentGame(userId);
  }
}