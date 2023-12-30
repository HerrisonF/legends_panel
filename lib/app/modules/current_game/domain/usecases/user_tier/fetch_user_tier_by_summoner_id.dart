import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/user_tier_entries/league_entry_model.dart';

abstract class FetchUserTierBySummonerIdUsecase {
  Future<Either<Failure, List<LeagueEntryModel>>> call({
    required String summonerId,
    required String region,
  });
}
