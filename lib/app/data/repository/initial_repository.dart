import 'package:legends_panel/app/data/model/champion.dart';
import 'package:legends_panel/app/data/provider/initial_provider.dart';

class InitialRepository {

  final InitialProvider _initialProvider = InitialProvider();

  Future<String> getLOLVersion() async {
    return _initialProvider.getLOLVersion();
  }

  Future<List<Champion>> getChampionList(String version) async {
    return _initialProvider.getChampionList(version);
  }

}