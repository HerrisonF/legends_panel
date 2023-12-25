import 'package:dartz/dartz.dart';

import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/modules/current_game/data/repositories/current_game_respository.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/summoner_identification_model.dart';

import 'fetch_puuid_and_summonerID_from_riot_usecase.dart';

class FetchPUUIDAndSummonerIDFromRiotUsecaseImpl
    extends FetchPUUIDAndSummonerIDFromRiotUsecase {
  late CurrentGameRepository currentGameRepository;

  FetchPUUIDAndSummonerIDFromRiotUsecaseImpl({
    required this.currentGameRepository,
  });

  @override
  Future<Either<Failure, SummonerIdentificationModel>> call({
    required String summonerName,
    required String tagLine,
  }) async {
    final result = await currentGameRepository.getSummonerIdentification(
      summonerName: summonerName.replaceAll(" ", ''),
      tagLine: tagLine.replaceAll(" ", ''),
    );

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
