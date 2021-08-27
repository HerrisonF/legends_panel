import 'package:legends_panel/app/data/model/current_game_spectator/current_game_spectator.dart';
import 'package:legends_panel/app/data/provider/current_game_provider/current_game_provider.dart';

class CurrentGameRepository {

  final CurrentGameProvider _currentGameProvider = CurrentGameProvider();

  Future<CurrentGameSpectator> checkCurrentGameExists(String userId){
    return _currentGameProvider.checkCurrentGameExists(userId);
  }

}