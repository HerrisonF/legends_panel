import 'package:flutter/material.dart';
import 'package:legends_panel/app/core/general_controller/general_repository.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/lol_constants_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/perk_style_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/user.dart';

class GeneralController {
  ValueNotifier<int> currentPageIndex = ValueNotifier(0);

  User userForCurrentGame = User();
  User userForProfile = User();
  late LolConstantsModel lolConstantsModel;
  late GeneralRepository generalRepository;

  GeneralController({
    required this.generalRepository,
  });

  setLolConstants(LolConstantsModel lolConstantsModel) {
    this.lolConstantsModel = lolConstantsModel;
  }

  getUserTierImage(String tier) {
    //return _masterRepository.getUserTierImage(tier);
  }

  String getPerkStyleBadgeUrl({required int perkId}) {
    PerkStyleModel? tempPerk = lolConstantsModel.getPerkById(perkId: perkId);
    String perkIconName = "";
    if (tempPerk != null) {
      perkIconName = tempPerk.icon;
    }
    return generalRepository.getPerkUrl(perkIconName);
  }

  changeCurrentPageIndex(int newPageIndex, BuildContext context) {
    FocusScope.of(context).unfocus();
    currentPageIndex.value = newPageIndex;
  }

  getCurrentUserOnCloud(String userName, String keyRegion) async {
    // userForCurrentGame =
    //     await _masterRepository.getUserOnCloud(userName, keyRegion);
  }

  getUserProfileOnCloud(String userName, String keyRegion) async {
    // userForProfile =
    //     await _masterRepository.getUserOnCloud(userName, keyRegion);
  }

  String getChampionBadgeUrl(int championId) {
    return generalRepository.getChampionBadgeUrl(
      championId: lolConstantsModel.getChampionById(championId)!.image.full,
      version: lolConstantsModel.getLatestLolVersion(),
    );
  }

  getSpellBadgeUrl(int spellId) {
    return generalRepository.getSpellBadgeUrl(
      version: lolConstantsModel.getLatestLolVersion(),
      spellName: lolConstantsModel.getSpellById(spellId)!.image!.full,
    );
  }
}
