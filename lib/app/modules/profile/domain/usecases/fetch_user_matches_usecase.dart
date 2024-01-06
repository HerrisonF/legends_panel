import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/match_detail.dart';

abstract class FetchUserMatchesUsecase {
  Future<Either<Failure, MatchDetail>> call({
    required String matchId,
    required String region,
  });
}
