import 'package:legends_panel/app/domain/entities/lol_version_entity.dart';

abstract class SaveLolVersionUseCase {
  Future<bool> call(LolVersionEntity lolVersionEntity);
}