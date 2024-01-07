import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/modules/profile/domain/models/match_detail_model.dart';

abstract class FetchUserMatchesUsecase {
  Future<Either<Failure, MatchDetailModel>> call({
    required String matchId,
    required String region,
  });
}
