import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/match_detail.dart';
import 'package:legends_panel/app/modules/profile/data/repositories/profile_repository.dart';

import 'fetch_user_matches_usecase.dart';

class FetchUserMatchesUseCaseImpl extends FetchUserMatchesUsecase {
  late ProfileRepository profileRepository;

  FetchUserMatchesUseCaseImpl({
    required this.profileRepository,
  });

  @override
  Future<Either<Failure, MatchDetail>> call({
    required String matchId,
    required String region,
  }) async {
    final result = await profileRepository.getMatchById(
      matchId: matchId,
      keyRegion: region,
    );

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
