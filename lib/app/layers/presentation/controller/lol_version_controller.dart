import 'package:legends_panel/app/layers/domain/entities/lol_version_entity.dart';
import 'package:legends_panel/app/layers/domain/usecases/get_lol_version/get_lol_version_usecase.dart';
import 'package:legends_panel/app/layers/domain/usecases/save_lol_version/save_lol_version_usecase.dart';

class LolVersionController {
  final GetLolVersionUseCase _getLolVersionUseCase;
  final SaveLolVersionUseCase _saveLolVersionUseCase;

  late LolVersionEntity cachedLolVersion;

  LolVersionController(
    this._saveLolVersionUseCase,
    this._getLolVersionUseCase,
  );

  start() async {
    await _getRemoteLolVersion();
  }

  _getRemoteLolVersion() async {
    var result = await _getLolVersionUseCase();
    result.fold(
      (error) => print('Error to get LolVersion'),
      (success) => cachedLolVersion = success,
    );
  }



  // saveLolVersion(LolVersionEntity lolVersionEntity) {
  //   /// APLICAR O FOLD
  //   var resultFlag = _saveLolVersionUseCase(lolVersionEntity);
  // }
}
