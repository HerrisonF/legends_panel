import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/data/repository/build_page_repository/build_page_repository.dart';
import 'package:legends_panel/app/model/general/champion.dart';
import 'package:legends_panel/app/model/general/champion_room.dart';

class BuildPageController {
  Rx<bool> isLoading = false.obs;

  final BuildPageRepository buildPageRepository = BuildPageRepository();
  final TextEditingController searchEditingController = TextEditingController();
  final MasterController _masterController = Get.find<MasterController>();

  ChampionRoom championRoom = ChampionRoom();
  RxList<Champion> searchedChampion = RxList<Champion>();

  init(ChampionRoom championRoom) {
    this.championRoom = championRoom;
    this.searchedChampion.addAll(championRoom.champions);
  }

  startLoading() {
    isLoading(true);
  }

  stopLoading() {
    isLoading(false);
  }

  cleanSearch(){
    searchEditingController.clear();
    this.searchedChampion.clear();
    this.searchedChampion.addAll(championRoom.champions);
  }

  String getChampionImage(String championId) {
    return buildPageRepository.getChampionImage(championId, _masterController.lolVersion.actualVersion);
  }

  showChampionEqualsFromSearch(String value) {
    if (value.isEmpty) {
      this.searchedChampion.addAll(championRoom.champions);
    } else {
      searchedChampion.clear();
      searchedChampion.addAll(
        championRoom.champions.where(
          (element) => element.detail.name.toString().toLowerCase().contains(
                value.toLowerCase(),
              ),
        ),
      );
    }
  }
}
