import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/build_page_controller/build_page_controller.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/model/data_analysis/data_analysis_model.dart';
import 'package:legends_panel/app/model/general/champion.dart';
import 'package:legends_panel/app/model/general/champion_with_spell.dart';

class ChampionBuildBottomSheetController {
  Rx<bool> isLoading = false.obs;

  String collectionChampionId = "";

  ChampionStatistic championStatistic = ChampionStatistic();

  ChampionWithSpell championWithSpell = ChampionWithSpell();

  Champion champion = Champion();

  Rx<bool> isLoadingChampion = false.obs;

  List<PositionData> mostPositions = [];

  startLoadingChampion() {
    isLoadingChampion(true);
  }

  stopLoadingChampion() {
    isLoadingChampion(false);
  }

  final BuildPageController _buildPageController =
      Get.find<BuildPageController>();
  final MasterController _masterController = Get.find<MasterController>();

  startLoading() {
    isLoading(true);
  }

  stopLoading() {
    isLoading(false);
  }

  init(String championId) {
    clean();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference champions = firestore.collection('champions');
    startLoading();
    champions
        .doc(championId)
        .get()
        .then((value) => transformJson(value))
        .catchError(
      (error) {
        stopLoading();
        print("Failed to get champions: $error");
      },
    );
  }

  clean() {
    collectionChampionId = "";
    championStatistic = ChampionStatistic();
    champion = Champion();
    championWithSpell = ChampionWithSpell();
  }

  getChampionForSpell(String championId) async {
    champion = _getChampion(championId);

    championWithSpell =
        await _buildPageController.buildPageRepository.getChampionForSpell(
      champion.detail.id,
      _masterController.lolVersionController.cachedLolVersion.getLatestVersion(),
    );
    stopLoadingChampion();
  }

  String getChampionSpell(String championId, int index) {
    return _buildPageController.buildPageRepository.getChampionSpellImage(
      championWithSpell.championWithSpellDetail.spells[index - 1].id,
      _masterController.lolVersionController.cachedLolVersion.getLatestVersion(),
    );
  }

  getSpellKey(String spellSlot) {
    switch (spellSlot) {
      case '1':
        return "Q";
      case '2':
        return "W";
      case '3':
        return "E";
      case '4':
        return "R";
    }
  }

  String getSpellUrl(String spellId) {
    var spell = _masterController.getSpellById(spellId);
    if (spell.name.isNotEmpty) {
      return _buildPageController.buildPageRepository.getSpellBadgeUrl(
          spell.id, _masterController.lolVersionController.cachedLolVersion.getLatestVersion());
    } else {
      return "";
    }
  }

  String getPerkStyleUrl(String perkStyle) {
    return _buildPageController.buildPageRepository.getPerkStyleUrl(perkStyle);
  }

  String getPerkShard(String perkShard) {
    return _buildPageController.buildPageRepository.getPerkShard(perkShard);
  }

  String getItemUrl(String itemId) {
    return _buildPageController.buildPageRepository
        .getItemUrl(itemId, _masterController.lolVersionController.cachedLolVersion.getLatestVersion());
  }

  String getPerk(String perk) {
    return _buildPageController.buildPageRepository.getPerkUrl(perk);
  }

  Champion _getChampion(String championId) {
    return _masterController.getChampionById(championId);
  }

  transformJson(var value) async {
    mostPositions.clear();
    stopLoading();
    collectionChampionId = value.id.toString();
    championStatistic = ChampionStatistic.fromJson(value.data());
    _orderMostPlayedPositions();
    _orderMostUsedBuilds();
    setMostPlayedPosition();
    startLoadingChampion();
    await getChampionForSpell(collectionChampionId);
  }

  void _orderMostPlayedPositions() {
    championStatistic.positions
        .sort((a, b) => a.amountPick.compareTo(b.amountPick));
  }

  void _orderMostUsedBuilds() {
    championStatistic.positions[0].builds
        .sort((a, b) => a.amountPick.compareTo(b.amountPick));

    if (championStatistic.positions.length > 1) {
      for (PositionData pos in championStatistic.positions) {
        if (pos.role != championStatistic.positions[0].role) {
          mostPositions.add(pos);
          break;
        }
      }
    }
  }

  setMostPlayedPosition() {
    mostPositions.add(championStatistic.positions[0]);
  }
}
