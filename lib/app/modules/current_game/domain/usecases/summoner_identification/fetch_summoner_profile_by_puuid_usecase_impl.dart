import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/modules/current_game/data/repositories/active_game_search_respository.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/summoner_identification/summoner_profile_model.dart';

import 'fetch_summoner_profile_by_puuid_usecase.dart';

class FetchSummonerProfileByPUUIDUsecaseImpl
    extends FetchSummonerProfileByPUUIDUsecase {
  late final ActiveGameSearchRepository activeGameSearchRepository;

  FetchSummonerProfileByPUUIDUsecaseImpl({
    required this.activeGameSearchRepository,
  });

  @override
  Future<Either<bool, SummonerProfileModel>> call({
    required String puuid,
    required String region,
  }) async {
    final result = await activeGameSearchRepository.fetchSummonerProfile(
      puuid: puuid,
      region: region,
    );

    return result.fold(
      (l) => Left(false),
      (r) {
        return Right(r);
      },
    );
  }
}
