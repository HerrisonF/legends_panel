import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_version/lol_version_dto.dart';

abstract class GetLolVersionUseCase {
  Future<Either<Exception, LolVersionDto>> call();
}