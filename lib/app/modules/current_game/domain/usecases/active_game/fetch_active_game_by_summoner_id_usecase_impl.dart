import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/modules/current_game/data/repositories/active_game_search_respository.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_info_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/active_game/fetch_active_game_by_summoner_id_usecase.dart';

class FetchActiveGameBySummonerIDUsecaseImpl
    extends FetchActiveGameBySummonerIDUsecase {
  late ActiveGameSearchRepository activeGameSearchRepository;

  FetchActiveGameBySummonerIDUsecaseImpl({
    required this.activeGameSearchRepository,
  });

  @override
  Future<Either<bool, ActiveGameInfoModel>> call({
    required String summonerId,
    required String region,
  }) async {
    final result = await activeGameSearchRepository.fetchActiveGame(
      summonerId: summonerId,
      region: region,
    );
    return result.fold(
      (l) => Left(false),
      (r) => Right(r),
    );
  }
}
