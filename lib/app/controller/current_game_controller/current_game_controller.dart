import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/controller/result_controllers/current_game_result_controller/current_game_result_controller.dart';
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
    if (masterController
        .storedRegion.value.lastStoredCurrentGameRegion.isEmpty) {
      return 'NA';
    }
    return masterController.storedRegion.value.lastStoredCurrentGameRegion;
  }

  saveActualRegion(String region) {
    masterController.saveActualRegion(region);
  }

  loadUserCurrentGame(String region) async {
    _startUserLoading();
    await masterController.getCurrentUserOnCloud(userNameInputController.text,
        masterController.storedRegion.value.getKeyFromRegion(region)!);
    if (userExist()) {
      _getUserPlayingOnRegion(region);
    } else {
      _showMessageUserNotFound();
    }
  }

  bool userExist() => masterController.userForCurrentGame.value.id.isNotEmpty;

  _getUserPlayingOnRegion(String region) async {
    currentGameForASpectator =
        await _currentGameRepository.checkCurrentGameExists(
            masterController.userForCurrentGame.value.id,
            masterController.storedRegion.value.getKeyFromRegion(region)!);
    if (userIsPlaying()) {
      _pushToCurrentResultGamePage(region);
      _stopUserLoading();
      userNameInputController.clear();
    } else {
      _showMessageUserIsNotInAGame();
    }
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
