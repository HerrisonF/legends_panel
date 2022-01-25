import 'package:legends_panel/app/data/provider/build_page_provider/build_page_provider.dart';

class BuildPageRepository {

  final BuildPageProvider buildPageProvider = BuildPageProvider();

  String getChampionImage(String championId){
    return buildPageProvider.getChampionImage(championId);
  }

}