import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/champion_mastery.dart';
import 'package:legends_panel/app/modules/profile/data/repositories/profile_repository.dart';
import 'package:legends_panel/app/modules/profile/domain/usecases/fetch_user_champion_masteries_usecase.dart';

class FetchUserChampionMasteriesUseCaseImpl
    extends FetchUserChampionMasteriesUsecase {
  late ProfileRepository profileRepository;

  FetchUserChampionMasteriesUseCaseImpl({
    required this.profileRepository,
  });

  @override
  Future<Either<Failure, List<ChampionMastery>>> call({
    required String region,
    required String puuid,
  }) async {
    return await profileRepository.getChampionMastery(
      region: region,
      encryptedPUUID: puuid,
    );
  }
}
