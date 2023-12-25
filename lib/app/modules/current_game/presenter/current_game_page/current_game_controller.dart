import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:legends_panel/app/core/general_controller/general_controller.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/active_games/fetch_active_game_by_summoner_id_usecase.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/summoner_identification/fetch_puuid_and_summonerID_from_riot_usecase.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/summoner_identification/fetch_summoner_profile_by_puuid_usecase.dart';
import 'package:legends_panel/app/modules/current_game/presenter/current_game_page/current_game_result_controller.dart';

class CurrentGameController {
  final CurrentGameResultController _currentGameResultController =
      GetIt.I<CurrentGameResultController>();
  late final FetchPUUIDAndSummonerIDFromRiotUsecase
      fetchPUUIDAndSummonerIDFromRiotUsecase;
  late final FetchActiveGameBySummonerIDUsecase
      fetchActiveGameBySummonerIDUsecase;
  late final FetchSummonerProfileByPUUIDUsecase
      fetchSummonerProfileByPUUIDUsecase;
  late final GeneralController generalController;

  ValueNotifier<bool> isLoadingUser = ValueNotifier(false);
  ValueNotifier<bool> isShowingMessage = ValueNotifier(false);
  ValueNotifier<bool> isShowingMessageUserIsNotPlaying = ValueNotifier(false);
  ValueNotifier<String> selectedRegion = ValueNotifier('BR1');
  List<String> regions = [
    'BR1',
    'EUN1',
    'EUW1',
    'JP1',
    'KR',
    'LA1',
    'LA2',
    'NA1',
    'OC1',
    'TR1',
    'RU',
    'PH2',
    'SG2',
    'TH2',
    'TW2',
    'VN2',
  ];

  CurrentGameController({
    required this.fetchPUUIDAndSummonerIDFromRiotUsecase,
    required this.fetchActiveGameBySummonerIDUsecase,
    required this.fetchSummonerProfileByPUUIDUsecase,
    required this.generalController,
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
    _startUserLoading();
    final result = await fetchPUUIDAndSummonerIDFromRiotUsecase(
      summonerName: summonerName,
      tagLine: tag,
    );
    result.fold((_) {
      _showMessageUserIsNotInAGame();
    }, (r) async {
      /// Depois de ter a identificação, posso procurar pelo jogo em andamento.
      final result = await fetchSummonerProfileByPUUIDUsecase(
        puuid: r.puuid,
        region: selectedRegion.value,
      );
      result.fold(
        (_) => _showMessageUserIsNotInAGame(),
        (r) async {
          _stopUserLoading();
          final result = await fetchActiveGameBySummonerIDUsecase(
            summonerId: r.id,
            region: selectedRegion.value,
          );
          result.fold(
            (_) => id,
            (r) {
              print(r);
            },
          );
        },
      );
    });
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
    // if (userIsPlaying()) {
    //   _pushToCurrentResultGamePage(region, context);
    //   _stopUserLoading();
    //   //userNameInputController.clear();
    // } else {
    //   _showMessageUserIsNotInAGame();
    // }
  }

  _getCurrentGame(String region) async {
    // currentGameForASpectator =
    //     await _currentGameRepository.getCurrentGameExists(
    //         masterController.userForCurrentGame.id,
    //         masterController.storedRegion.getKeyFromRegion(region)!);
  }

  _pushToCurrentResultGamePage(String region, BuildContext context) {
    // _currentGameResultController.startController(
    //     currentGameForASpectator, region);
    // context.push(RoutesPath.PROFILE_SUB);
  }

  _showMessageUserIsNotInAGame() {
    _stopUserLoading();
    isShowingMessageUserIsNotPlaying.value = true;
    Future.delayed(Duration(seconds: 3)).then((value) {
      isShowingMessageUserIsNotPlaying.value = false;
    });
  }
}
