import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/summoner_identification_model.dart';

abstract class FetchPUUIDAndSummonerIDFromRiotUsecase {
  Future<Either<Failure, SummonerIdentificationModel>> call({
    required String summonerName,
    required String tagLine,
  });
}
