import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/active_game/active_game_info_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/summoner_identification_model.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/summoner_profile_model.dart';

abstract class CurrentGameRepository {
  Future<Either<Failure, SummonerIdentificationModel>>
      fetchSummonerIdentification({
    required String summonerName,
    required String tagLine,
  });

  Future<Either<Failure, SummonerProfileModel>> fetchSummonerProfile({
    required String puuid,
    required String region,
  });

  Future<Either<Failure, ActiveGameInfoModel>> fetchActiveGame({
    required String summonerId,
    required String region,
  });
}
