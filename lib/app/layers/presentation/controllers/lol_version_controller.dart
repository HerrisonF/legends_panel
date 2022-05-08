import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/layers/domain/entities/lol_version/lol_version_entity.dart';

import '../../domain/usecases/lol_version/get_lol_version/get_lol_version_usecase.dart';

class LolVersionController {
  final GetLolVersionUseCase _getLolVersionUseCase;

  late LolVersionEntity cachedLolVersion;

  LolVersionController(this._getLolVersionUseCase);

  Future<bool> initialize() async {
    return await _getRemoteLolVersion();
  }

  Future<bool> _getRemoteLolVersion() async {
    Either<Exception, LolVersionEntity> result = await _getLolVersionUseCase();
    return result.fold(
      (error) => false,
      (success) {
        cachedLolVersion = success;
        print(cachedLolVersion);
        return true;
      },
    );
  }
}
