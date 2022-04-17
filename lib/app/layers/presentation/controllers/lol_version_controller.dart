import 'package:legends_panel/app/layers/domain/entities/lol_version/lol_version_entity.dart';

import '../../domain/usecases/lol_version/get_lol_version/get_lol_version_usecase.dart';

class LolVersionController {
  final GetLolVersionUseCase _getLolVersionUseCase;

  late LolVersionEntity cachedLolVersion;

  LolVersionController(this._getLolVersionUseCase);

  initialize() async {
    await _getRemoteLolVersion();
  }

  _getRemoteLolVersion() async {
    var result = await _getLolVersionUseCase();
    result.fold(
      (error) => null,
      (success) => cachedLolVersion = success,
    );
  }
}
