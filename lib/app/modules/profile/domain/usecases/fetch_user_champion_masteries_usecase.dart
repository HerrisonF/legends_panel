import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/modules/profile/domain/models/champion_mastery_model.dart';

abstract class FetchUserChampionMasteriesUsecase {
  Future<Either<Failure, List<ChampionMasteryModel>>> call({
    required String region,
    required String puuid,
  });
}
