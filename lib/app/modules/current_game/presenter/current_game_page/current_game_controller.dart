import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:legends_panel/app/core/routes/routes_path.dart';
import 'package:legends_panel/app/modules/current_game/domain/current_game_spectator/current_game_spectator.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/fetch_puuid_and_summonerID_from_riot_usecase.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_page/current_game_result_controller.dart';

class CurrentGameController {
  final CurrentGameResultController _currentGameResultController =
      GetIt.I<CurrentGameResultController>();
  final FetchPUUIDAndSummonerIDFromRiotUsecase
      fetchPUUIDAndSummonerIDFromRiotUsecase;

  //final MasterController masterController = GetIt.I<MasterController>();

  ValueNotifier<bool> isLoadingUser = ValueNotifier(false);
  ValueNotifier<bool> isShowingMessage = ValueNotifier(false);
  ValueNotifier<bool> isShowingMessageUserIsNotPlaying = ValueNotifier(false);
  CurrentGameSpectator currentGameForASpectator = CurrentGameSpectator();

  CurrentGameController({
    required this.fetchPUUIDAndSummonerIDFromRiotUsecase,
  });

  _startUserLoading() {
    isLoadingUser.value = true;
  }

  _stopUserLoading() {
    isLoadingUser.value = false;
  }

  searchGoingOnGame({
    required String summonerName,
    required String tag,
  }) async {
    //_startUserLoading();
    final result = await fetchPUUIDAndSummonerIDFromRiotUsecase(
      summonerName: summonerName,
      tagLine: tag,
    );
    result.fold((l) {
      print(l.message);
    }, (r) {
      print(r);
    });
    //checkWhetherGameExist(context);
  }

  void checkWhetherGameExist(BuildContext context) {
    // if (userExist()) {
    //   _checkCurrentGameExistOnRegion(
    //       'na', context);
    // } else {
    //   _showMessageUserNotFound();
    // }
  }

  getCurrentUserOnCloud(String keyRegion) async {
    // await masterController.getCurrentUserOnCloud(
    //     userNameInputController.text, keyRegion);
  }

  //bool userExist() => masterController.userForCurrentGame.id.isNotEmpty;

  _checkCurrentGameExistOnRegion(String region, BuildContext context) async {
    await _getCurrentGame(region);
    if (userIsPlaying()) {
      _pushToCurrentResultGamePage(region, context);
      _stopUserLoading();
      //userNameInputController.clear();
    } else {
      _showMessageUserIsNotInAGame();
    }
  }

  _getCurrentGame(String region) async {
    // currentGameForASpectator =
    //     await _currentGameRepository.getCurrentGameExists(
    //         masterController.userForCurrentGame.id,
    //         masterController.storedRegion.getKeyFromRegion(region)!);
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
