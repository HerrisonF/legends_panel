import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/modules/current_game/data/repositories/active_game_search_respository.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/summoner_identification/summoner_identification_model.dart';

import 'fetch_puuid_and_summonerID_from_riot_usecase.dart';

/// Agora a identificação do lol é feita pelo nome + tag.
/// ATT de 11/2023.
class FetchPUUIDAndSummonerIDFromRiotUsecaseImpl
    extends FetchPUUIDAndSummonerIDFromRiotUsecase {
  late ActiveGameSearchRepository activeGameSearchRepository;

  FetchPUUIDAndSummonerIDFromRiotUsecaseImpl({
    required this.activeGameSearchRepository,
  });

  @override
  Future<Either<bool, SummonerIdentificationModel>> call({
    required String summonerName,
    required String tagLine,
  }) async {
    final result = await activeGameSearchRepository.fetchSummonerIdentification(
      summonerName: summonerName.replaceAll(" ", ''),
      tagLine: tagLine.replaceAll(" ", ''),
    );

    return result.fold(
      (l) => Left(false),
      (r) => Right(r),
    );
  }
}
