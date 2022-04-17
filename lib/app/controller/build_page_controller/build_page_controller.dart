import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/data/repository/build_page_repository/build_page_repository.dart';
import 'package:legends_panel/app/model/general/champion.dart';
import 'package:legends_panel/app/model/general/champion_room.dart';

import '../../layers/presentation/controllers/lol_version_controller.dart';

class BuildPageController {
  Rx<bool> isLoading = false.obs;

  final BuildPageRepository buildPageRepository = BuildPageRepository();
  final TextEditingController searchEditingController = TextEditingController();
  final LolVersionController _lolVersionController =
      GetIt.I.get<LolVersionController>();

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

  cleanSearch() {
    searchEditingController.clear();
    this.searchedChampion.clear();
    this.searchedChampion.addAll(championRoom.champions);
  }

  String getChampionImage(String championId) {
    return buildPageRepository.getChampionImage(
      championId,
      _lolVersionController.cachedLolVersion.getLatestVersion(),
    );
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
