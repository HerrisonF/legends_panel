import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_version/lol_version_entity.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/usecases/lol_version/get_lol_version/get_lol_version_usecase.dart';

class LolVersionController {
  late GetLolVersionUseCase getLolVersionUseCase;
  late LolVersionEntity lolVersionEntity;

  LolVersionController({
    required this.getLolVersionUseCase,
  });

  Future<bool> initialize() async {
    return await _getRemoteLolVersion();
  }

  Future<bool> _getRemoteLolVersion() async {
    Either<Exception, LolVersionEntity> result = await getLolVersionUseCase();
    return result.fold(
      (error) => false,
      (success) {
        lolVersionEntity = success;
        return true;
      },
    );
  }
}
