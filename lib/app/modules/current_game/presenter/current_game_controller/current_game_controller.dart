import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/core/routes/routes_path.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/master_page/master_controller.dart';
import 'package:legends_panel/app/modules/current_game/data/repositories/current_game_respository.dart';
import 'package:legends_panel/app/modules/current_game/domain/current_game_spectator/current_game_spectator.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_controller/current_game_result_controller.dart';

class CurrentGameController {
  final CurrentGameResultController _currentGameResultController =
      GetIt.I<CurrentGameResultController>();
  final MasterController masterController = GetIt.I<MasterController>();
  final CurrentGameRepository _currentGameRepository = CurrentGameRepository(
    logger: GetIt.I.get<Logger>(),
    httpServices: GetIt.I.get<HttpServices>(),
  );
  final TextEditingController userNameInputController = TextEditingController();

  ValueNotifier<bool> isLoadingUser = ValueNotifier(false);
  ValueNotifier<bool> isShowingMessage = ValueNotifier(false);
  ValueNotifier<bool> isShowingMessageUserIsNotPlaying = ValueNotifier(false);
  CurrentGameSpectator currentGameForASpectator = CurrentGameSpectator();

  _startUserLoading() {
    isLoadingUser.value = true;
  }

  _stopUserLoading() {
    isLoadingUser.value = false;
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

  processCurrentGame(BuildContext context) async {
    _startUserLoading();
    String keyRegion = getKeyFromARegion();
    await getCurrentUserOnCloud(keyRegion);
    checkWhetherGameExist(context);
  }

  void checkWhetherGameExist(BuildContext context) {
    if (userExist()) {
      _checkCurrentGameExistOnRegion(
          masterController.storedRegion.lastStoredCurrentGameRegion, context);
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

  _checkCurrentGameExistOnRegion(String region, BuildContext context) async {
    await _getCurrentGame(region);
    if (userIsPlaying()) {
      _pushToCurrentResultGamePage(region, context);
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

  _pushToCurrentResultGamePage(String region, BuildContext context) {
    _currentGameResultController.startController(
        currentGameForASpectator, region);
    context.push(RoutesPath.PROFILE_SUB);
  }

  _showMessageUserNotFound() {
    _stopUserLoading();
    isShowingMessage.value = true;
    Future.delayed(Duration(seconds: 3)).then((value) {
      isShowingMessage.value = false;
    });
  }

  _showMessageUserIsNotInAGame() {
    _stopUserLoading();
    isShowingMessageUserIsNotPlaying.value = true;
    Future.delayed(Duration(seconds: 3)).then((value) {
      isShowingMessageUserIsNotPlaying.value = false;
    });
  }
}
