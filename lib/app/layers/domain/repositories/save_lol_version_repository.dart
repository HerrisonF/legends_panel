import 'package:legends_panel/app/domain/entities/lol_version_entity.dart';

abstract class SaveLolVersionRepository {
  Future<bool> call(LolVersionEntity lolVersionEntity);
}