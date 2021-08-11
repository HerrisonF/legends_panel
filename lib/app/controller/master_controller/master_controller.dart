import 'package:get/get.dart';
import 'package:legends_panel/app/data/model/champion.dart';
import 'package:legends_panel/app/data/repository/master_repository.dart';

class MasterController {

  MasterRepository _masterRepository = MasterRepository();

  RxInt currentPageIndex = 0.obs;

  changeCurrentPageIndex(int newPageIndex){
    currentPageIndex(newPageIndex);
  }

  RxString lolVersion = "".obs;

  setLoLVersion(String version){
    this.lolVersion(version);
  }

  List<Champion> championList = <Champion>[];

  setChampionList(List<Champion> championList){
    this.championList.addAll(championList);
  }

  String getImageUrl(String championId){
    //print("TESTE> ${championList[1].detail.key} - $championId");
    //return "";
    Champion champion = championList.where((champ) => champ.detail.key.toString() == championId).first;
    return _masterRepository.getImageUrl(champion.detail.name, lolVersion.value);
  }

}