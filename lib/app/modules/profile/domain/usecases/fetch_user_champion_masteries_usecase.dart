import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/champion_mastery.dart';

abstract class FetchUserChampionMasteriesUsecase {
  Future<Either<Failure, List<ChampionMastery>>> call({
    required String region,
    required String puuid,
  });
}
