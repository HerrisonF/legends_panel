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
  final MasterController _masterController = Get.find<MasterController>();
  final CurrentGameRepository _currentGameRepository = CurrentGameRepository();
  final TextEditingController userNameInputController = TextEditingController();

  Rx<String> buttonMessage = "BUTTON_MESSAGE_SEARCH".tr.obs;
  Rx<bool> isLoadingUser = false.obs;
  Rx<bool> isShowingMessage = false.obs;
  CurrentGameSpectator currentGameSpectator = CurrentGameSpectator();

  _startUserLoading() {
    isLoadingUser(true);
  }

  _stopUserLoading() {
    isLoadingUser(false);
  }

  getUserFromCloud(String region) async {
    _startUserLoading();
    buttonMessage("SEARCHING".tr);
    await _masterController.getCurrentUserOnCloud(userNameInputController.text, region);
    if (_masterController.userCurrentGame.value.id.isNotEmpty) {
      _checkUserIsInCurrentGame(region);
    } else {
      _showUserNotFoundMessage();
    }
  }

  _checkUserIsInCurrentGame(String region) async {
    currentGameSpectator = await _currentGameRepository
        .checkCurrentGameExists(_masterController.userCurrentGame.value.id, region);
    if (gameExist()) {
      _pushToCurrentResultGame(region);
      _stopUserLoading();
      userNameInputController.clear();
    } else {
      _showUserIsNotInAGameMessage();
    }
  }

  bool gameExist() {
    return currentGameSpectator.gameId > 0;
  }

  _pushToCurrentResultGame(String region) {
    _currentGameResultController.startController(currentGameSpectator, region);
    Get.toNamed(Routes.PROFILE_SUB);
  }

  _showUserNotFoundMessage() {
    _stopUserLoading();
    isShowingMessage(true);
    buttonMessage("BUTTON_MESSAGE_USER_NOT_FOUND".tr);
    Future.delayed(Duration(seconds: 3)).then((value) {
      buttonMessage("BUTTON_MESSAGE_SEARCH".tr);
      isShowingMessage(false);
    });
  }

  _showUserIsNotInAGameMessage() {
    _stopUserLoading();
    isShowingMessage(true);
    buttonMessage("BUTTON_MESSAGE_GAME_NOT_FOUND".tr);
    Future.delayed(Duration(seconds: 3)).then((value) {
      buttonMessage("BUTTON_MESSAGE_SEARCH".tr);
      isShowingMessage(false);
    });
  }

  String getLoLVersion() {
    return _masterController.lolVersion;
  }
}
