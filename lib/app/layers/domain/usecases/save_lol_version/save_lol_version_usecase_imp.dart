import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/layers/data/dtos/lol_version_dto.dart';
import 'package:legends_panel/app/layers/domain/entities/lol_version_entity.dart';
import 'package:legends_panel/app/layers/domain/repositories/save_lol_version_repository.dart';
import 'package:legends_panel/app/layers/domain/usecases/save_lol_version/save_lol_version_usecase.dart';

class SaveLolVersionUseCaseImp implements SaveLolVersionUseCase {
  final SaveLolVersionRepository _saveLolVersionRepository;

  SaveLolVersionUseCaseImp(this._saveLolVersionRepository);

  @override
  Future<Either<Exception, bool>> call(
    LolVersionEntity lolVersionEntity,
  ) async {
    return await _saveLolVersionRepository(
      LolVersionDto(
        versions: lolVersionEntity.versions,
      ),
    );
  }
}
