import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/layers/domain/entities/lol_version_entity.dart';

abstract class SaveLolVersionUseCase {
  Future<Either<Exception, bool>> call(LolVersionEntity lolVersionEntity);
}