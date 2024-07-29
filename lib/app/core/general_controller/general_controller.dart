import 'package:flutter/material.dart';
import 'package:legends_panel/app/core/general_controller/general_repository.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/champion_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/lol_constants_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/perk_style_model.dart';

class GeneralController {
  ValueNotifier<int> currentPageIndex = ValueNotifier(0);

  late LolConstantsModel lolConstantsModel;
  late GeneralRepository generalRepository;

  GeneralController({
    required this.generalRepository,
  });

  setLolConstants(LolConstantsModel lolConstantsModel) {
    this.lolConstantsModel = lolConstantsModel;
  }

  String getPerkStyleBadgeUrl({required int perkId}) {
    PerkStyleModel? tempPerk = lolConstantsModel.getPerkById(perkId: perkId);
    String perkIconName = "";
    if (tempPerk != null) {
      perkIconName = tempPerk.icon;
    }
    return generalRepository.getPerkUrl(perkIconName);
  }

  String getPerkDetailBadgeUrl({
    required String iconPath,
  }) {
    return generalRepository.getPerkDetailUrl(
      iconPath: iconPath,
    );
  }

  changeCurrentPageIndex(int newPageIndex, BuildContext context) {
    FocusScope.of(context).unfocus();
    currentPageIndex.value = newPageIndex;
  }

  String getChampionBadgeUrl(int championId) {
    ChampionModel? championModel = lolConstantsModel.getChampionById(championId);
    if(championModel != null) {
      return generalRepository.getChampionBadgeUrl(
        championId: championModel.image.full,
        version: lolConstantsModel.getLatestLolVersion(),
      );
    }
    return "";
  }

  String getChampionBigImage({required String championName}) {
    return generalRepository.getChampionBigImage(
      championName: championName,
    );
  }

  getSpellBadgeUrl(int spellId) {
    return generalRepository.getSpellBadgeUrl(
      version: lolConstantsModel.getLatestLolVersion(),
      spellName: lolConstantsModel.getSpellById(spellId)!.image!.full,
    );
  }

  String getItemUrl({
    required int itemId,
  }) {
    return generalRepository.getItemUrl(
      itemId: itemId,
      version: lolConstantsModel.getLatestLolVersion(),
    );
  }

  String getPositionUrl({
    required String position,
  }) {
    return generalRepository.getPositionUrl(
      position: position,
    );
  }

  bool checkPerkIsAssigned({
    required List<int> options,
    required int perkCorrente,
  }) {
    return options.contains(perkCorrente);
  }
}
