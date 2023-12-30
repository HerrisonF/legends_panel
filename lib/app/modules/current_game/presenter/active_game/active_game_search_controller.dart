import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_participant_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/active_game/fetch_active_game_by_summoner_id_usecase.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/summoner_identification/fetch_puuid_and_summonerID_from_riot_usecase.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/summoner_identification/fetch_summoner_profile_by_puuid_usecase.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/user_tier/fetch_user_tier_by_summoner_id.dart';

class ActiveGameSearchController {
  late final FetchPUUIDAndSummonerIDFromRiotUsecase
      fetchPUUIDAndSummonerIDFromRiotUsecase;
  late final FetchActiveGameBySummonerIDUsecase
      fetchActiveGameBySummonerIDUsecase;
  late final FetchSummonerProfileByPUUIDUsecase
      fetchSummonerProfileByPUUIDUsecase;
  late final FetchUserTierBySummonerIdUsecase fetchUserTierBySummonerIdUsecase;
  late final Function goToGameResultPageCallback;

  ValueNotifier<bool> isLoadingUser = ValueNotifier(false);
  ValueNotifier<bool> isShowingMessageUserIsNotPlaying = ValueNotifier(false);
  ValueNotifier<String> selectedRegion = ValueNotifier('EUN1');
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
    required this.fetchUserTierBySummonerIdUsecase,
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
              (gameInfo) async {
                /// Todos os dados foram encontrados. Então posso levar o usuário
                /// para a tela de resultados. A tela que irá montar a visualização
                /// do jogo ativo que foi encontrado.
                gameInfo.setSummonerProfile(profile);
                gameInfo.setSummonerIdentification(summonerIdentification);

                /// Esse trecho serve para colocar o gameName do usuário
                /// pesquisado dentro do seu objeto.
                ActiveGameParticipantModel model = gameInfo
                    .activeGameParticipants
                    .where((element) =>
                        element.puuid == gameInfo.summonerProfileModel!.puuid)
                    .first;

                model.setSummonerProfile(profile);
                model.setSummonerIdentification(summonerIdentification);

                ///

                List<Future> futures = [];

                gameInfo.activeGameParticipants.forEach((participant) {
                  futures.add(
                    fetchUserTierBySummonerIdUsecase(
                      summonerId: participant.summonerId,
                      region: selectedRegion.value,
                    ).then(
                      (result) {
                        result.fold(
                          (l) => id,
                          (leagueEntries) =>
                              participant.setLeagueEntriesModel(leagueEntries),
                        );
                      },
                    ),
                  );
                });

                await Future.wait(futures).whenComplete(() {
                  _stopUserLoading();
                  goToGameResultPageCallback(gameInfo);
                });
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
      _stopUserLoading();
    });
  }
}
