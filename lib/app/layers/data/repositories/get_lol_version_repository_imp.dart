import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/layers/data/datasources/get_lol_version_datasource.dart';
import 'package:legends_panel/app/layers/domain/entities/lol_version_entity.dart';
import 'package:legends_panel/app/layers/domain/repositories/get_lol_version_repository.dart';

class GetLolVersionRepositoryImp implements GetLolVersionRepository {

  final GetLolVersionDataSource _getLolVersionDataSource;

  GetLolVersionRepositoryImp(this._getLolVersionDataSource);

  @override
  Future<Either<Exception, LolVersionEntity>> call() async {
    return await _getLolVersionDataSource();
  }

}