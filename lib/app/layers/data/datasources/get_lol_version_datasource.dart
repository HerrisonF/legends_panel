import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/layers/domain/entities/lol_version_entity.dart';

abstract class GetLolVersionDataSource {

  Future<Either<Exception, LolVersionEntity>> call();
}