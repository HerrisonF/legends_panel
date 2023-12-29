import 'package:flutter/material.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/active_game/fetch_active_game_by_summoner_id_usecase.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/summoner_identification/fetch_puuid_and_summonerID_from_riot_usecase.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/summoner_identification/fetch_summoner_profile_by_puuid_usecase.dart';

class ActiveGameSearchController {
  late final FetchPUUIDAndSummonerIDFromRiotUsecase
      fetchPUUIDAndSummonerIDFromRiotUsecase;
  late final FetchActiveGameBySummonerIDUsecase
      fetchActiveGameBySummonerIDUsecase;
  late final FetchSummonerProfileByPUUIDUsecase
      fetchSummonerProfileByPUUIDUsecase;
  late final Function goToGameResultPageCallback;

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

  ActiveGameSearchController({
    required this.fetchPUUIDAndSummonerIDFromRiotUsecase,
    required this.fetchActiveGameBySummonerIDUsecase,
    required this.fetchSummonerProfileByPUUIDUsecase,
    required this.goToGameResultPageCallback,
  });

  _startUserLoading() {
    isLoadingUser.value = true;
  }

  _stopUserLoading() {
    isLoadingUser.value = false;
  }

  searchActiveGame({
    required String summonerName,
    required String tag,
  }) async {
    _startUserLoading();
    final result = await fetchPUUIDAndSummonerIDFromRiotUsecase(
      summonerName: summonerName,
      tagLine: tag,
    );
    result.fold(
      (_) => _showMessageUserIsNotInAGame(),
      (summonerIdentification) async {
        /// Depois de ter a identificação, posso procurar pelo jogo em andamento.
        final result = await fetchSummonerProfileByPUUIDUsecase(
          puuid: summonerIdentification.puuid,
          region: selectedRegion.value,
        );
        result.fold(
          (_) => _showMessageUserIsNotInAGame(),
          (profile) async {
            final result = await fetchActiveGameBySummonerIDUsecase(
              summonerId: profile.id,
              region: selectedRegion.value,
            );
            result.fold(
              (_) => _showMessageUserIsNotInAGame(),
              (gameInfo) {
                /// Todos os dados foram encontrados. Então posso levar o usuário
                /// para a tela de resultados. A tela que irá montar a visualização
                /// do jogo ativo que foi encontrado.
                gameInfo.setSummonerProfile(profile);
                gameInfo.setSummonerIdentification(summonerIdentification);
                goToGameResultPageCallback(gameInfo);
                _stopUserLoading();
              },
            );
          },
        );
      },
    );
  }

  _showMessageUserIsNotInAGame() {
    _stopUserLoading();
    isShowingMessageUserIsNotPlaying.value = true;
    Future.delayed(Duration(seconds: 3)).then((value) {
      isShowingMessageUserIsNotPlaying.value = false;
    });
  }
}
