import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/modules/profile/data/repositories/profile_repository.dart';
import 'package:legends_panel/app/modules/profile/domain/usecases/fetch_user_matches_ids_usecase.dart';

class FetchUserMatchesIdsUseCaseImpl extends FetchUserMatchesIdsUsecase {
  late ProfileRepository profileRepository;

  FetchUserMatchesIdsUseCaseImpl({
    required this.profileRepository,
  });

  @override
  Future<Either<Failure, List<String>>> call({
    required String region,
    required String puuid,
    required int start,
    required int count,
  }) async {
    final result = await profileRepository.getMatchListIds(
      puuid: puuid,
      start: start,
      count: count,
      keyRegion: region,
    );

    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
