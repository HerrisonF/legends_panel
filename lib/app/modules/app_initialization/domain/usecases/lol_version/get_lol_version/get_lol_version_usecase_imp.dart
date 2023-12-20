import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_version/lol_version_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/repositories/lol_version/lol_version_repository_impl.dart';

import 'get_lol_version_usecase.dart';

class GetLolVersionUseCaseImp implements GetLolVersionUseCase {
  late GetLolVersionRepositoryImpl getLolVersionRepository;

  GetLolVersionUseCaseImp({
    required this.getLolVersionRepository,
  });

  @override
  Future<Either<Exception, LolVersionDto>> call() async {
    return await getLolVersionRepository();
  }
}
