import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/layers/data/dtos/lol_version/lol_version_dto.dart';

abstract class GetLolVersionUseCase {
  Future<Either<Exception, LolVersionDto>> call();
}