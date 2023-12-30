import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/core/general_controller/general_repository.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/user_tier_entries/league_entry_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/usecases/user_tier/fetch_user_tier_by_summoner_id.dart';

class FetchUserTierBySummonerIdUsecaseImpl
    extends FetchUserTierBySummonerIdUsecase {
  late final GeneralRepository generalRepository;

  FetchUserTierBySummonerIdUsecaseImpl({
    required this.generalRepository,
  });

  @override
  Future<Either<Failure, List<LeagueEntryModel>>> call({
    required String summonerId,
    required String region,
  }) async {
    final result = await generalRepository.fetchLeagueEntries(
      encryptedSummonerId: summonerId.trim(),
      region: region,
    );

    return result.fold(
      (l) => Left(l),
      (r) {
        return Right(r);
      },
    );
  }
}
