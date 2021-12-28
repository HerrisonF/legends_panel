import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/current_game_controller/current_game_result_controller.dart';
import 'package:legends_panel/app/model/current_game_spectator/current_game_spectator.dart';
import 'package:legends_panel/app/data/repository/current_game_repository/current_game_respository.dart';
import 'package:legends_panel/app/routes/app_routes.dart';

class CurrentGameController extends GetxController {
  final CurrentGameResultController _currentGameResultController =
      Get.put(CurrentGameResultController());
  final MasterController masterController = Get.find<MasterController>();
  final CurrentGameRepository _currentGameRepository = CurrentGameRepository();
  final TextEditingController userNameInputController = TextEditingController();

  Rx<bool> isLoadingUser = false.obs;
  Rx<bool> isShowingMessage = false.obs;
  Rx<bool> isShowingMessageUserIsNotPlaying = false.obs;
  CurrentGameSpectator currentGameForASpectator = CurrentGameSpectator();

  _startUserLoading() {
    isLoadingUser(true);
  }

  _stopUserLoading() {
    isLoadingUser(false);
  }

  String getLastStoredRegionForCurrentGame() {
    if (masterController.storedRegion.lastStoredCurrentGameRegion.isEmpty) {
      return 'NA';
    }
    return masterController.storedRegion.lastStoredCurrentGameRegion;
  }

  setAndSaveActualRegion(String region) {
    masterController.storedRegion.lastStoredCurrentGameRegion = region;
    masterController.saveActualRegion();
  }

  processCurrentGame() async {
    _startUserLoading();
    String keyRegion = getKeyFromARegion();
    await getCurrentUserOnCloud(keyRegion);
    checkWhetherGameExist();
  }

  void checkWhetherGameExist() {
    if (userExist()) {
      _checkCurrentGameExistOnRegion(
          masterController.storedRegion.lastStoredCurrentGameRegion);
    } else {
      _showMessageUserNotFound();
    }
  }

  getCurrentUserOnCloud(String keyRegion) async {
    await masterController.getCurrentUserOnCloud(
        userNameInputController.text, keyRegion);
  }

  String getKeyFromARegion() {
    return masterController.storedRegion.getKeyFromRegion(
        masterController.storedRegion.lastStoredCurrentGameRegion)!;
  }

  bool userExist() => masterController.userForCurrentGame.id.isNotEmpty;

  _checkCurrentGameExistOnRegion(String region) async {
    await _getCurrentGame(region);
    if (userIsPlaying()) {
      _pushToCurrentResultGamePage(region);
      _stopUserLoading();
      userNameInputController.clear();
    } else {
      _showMessageUserIsNotInAGame();
    }
  }

  _getCurrentGame(String region) async {
    currentGameForASpectator =
        await _currentGameRepository.getCurrentGameExists(
            masterController.userForCurrentGame.id,
            masterController.storedRegion.getKeyFromRegion(region)!);
  }

  bool userIsPlaying() {
    return currentGameForASpectator.gameId > 0;
  }

  _pushToCurrentResultGamePage(String region) {
    _currentGameResultController.startController(
        currentGameForASpectator, region);
    Get.toNamed(Routes.PROFILE_SUB);
  }

  _showMessageUserNotFound() {
    _stopUserLoading();
    isShowingMessage(true);
    Future.delayed(Duration(seconds: 3)).then((value) {
      isShowingMessage(false);
    });
  }

  _showMessageUserIsNotInAGame() {
    _stopUserLoading();
    isShowingMessageUserIsNotPlaying(true);
    Future.delayed(Duration(seconds: 3)).then((value) {
      isShowingMessageUserIsNotPlaying(false);
    });
  }
}
