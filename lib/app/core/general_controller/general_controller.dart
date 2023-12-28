import 'package:flutter/material.dart';
import 'package:legends_panel/app/core/general_controller/general_repository.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/lol_constants_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/runesRoom.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/user.dart';

class GeneralController {
  ValueNotifier<int> currentPageIndex = ValueNotifier(0);

  User userForCurrentGame = User();
  User userForProfile = User();
  RunesRoom runesRoom = RunesRoom();
  late LolConstantsModel lolConstantsModel;
  late GeneralRepository generalRepository;

  Future<void> initialize() async {
    await getRunesRoom();
  }

  GeneralController({
    required this.generalRepository,
  });

  setLolConstants(LolConstantsModel lolConstantsModel) {
    this.lolConstantsModel = lolConstantsModel;
  }

  getUserTierImage(String tier) {
    //return _masterRepository.getUserTierImage(tier);
  }

  getRunesRoom() async {
    // runesRoom = await _masterRepository.getRunesRoomOnLocal();
    if (runesRoom.needToLoadVersionFromWeb()) {
      await getRunesRoomOnWeb();
    }
  }

  getRunesRoomOnWeb() async {
    // runesRoom = await _masterRepository.getRunesRoomOnWeb(
    //     storedRegion.getLocaleKey()!);
    // _masterRepository.saveRunesRoom(runesRoom.toJson());
  }

  // String getPerkSubStyleIconName(CurrentGamePerk perk) {
  //   PerkStyle perkStyle = PerkStyle();
  //   var currentPerk = runesRoom.perkStyle.where(
  //       (perkStyle) => perkStyle.id.toString() == perk.perkSubStyle.toString());
  //   if (currentPerk.length > 0) {
  //     perkStyle = currentPerk.first;
  //   }
  //   return perkStyle.icon;
  // }
  //
  // String getFirstPerkFromPerkStyle(CurrentGamePerk perk) {
  //   PerkStyle perkStyle = PerkStyle();
  //   var currentPerk = runesRoom.perkStyle.where(
  //       (perkStyle) => perkStyle.id.toString() == perk.perkStyle.toString());
  //   if (currentPerk.length > 0) {
  //     perkStyle = currentPerk.first;
  //   }
  //   Runes runes = Runes();
  //   var firstIcon;
  //   for (Slots slot in perkStyle.slots) {
  //     firstIcon = slot.runes
  //         .where((rune) => rune.id.toString() == perk.perkIds[0].toString());
  //     if (firstIcon.length > 0) {
  //       break;
  //     }
  //   }
  //
  //   if (firstIcon.length > 0) {
  //     runes = firstIcon.first;
  //   }
  //   return runes.icon;
  // }

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
