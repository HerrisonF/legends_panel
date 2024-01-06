import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';

abstract class FetchUserMatchesIdsUsecase {
  Future<Either<Failure, List<String>>> call({
    required String region,
    required String puuid,
    required int start,
    required int count,
  });
}
