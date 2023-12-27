import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/summoner_identification/summoner_profile_model.dart';

abstract class FetchSummonerProfileByPUUIDUsecase {
  Future<Either<bool, SummonerProfileModel>> call({
    required String puuid,
    required String region,
  });
}
