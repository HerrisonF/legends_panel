import 'package:legends_panel/app/domain/entities/lol_version_entity.dart';
import 'package:legends_panel/app/domain/repositories/save_lol_version_repository.dart';
import 'package:legends_panel/app/domain/usecases/save_lol_version/save_lol_version_usecase.dart';

class SaveLolVersionUseCaseImp implements SaveLolVersionUseCase {

  final SaveLolVersionRepository _saveLolVersionRepository;

  SaveLolVersionUseCaseImp(this._saveLolVersionRepository);

  @override
  Future<bool> call(LolVersionEntity lolVersionEntity) async {
    return await _saveLolVersionRepository(lolVersionEntity);
  }

}