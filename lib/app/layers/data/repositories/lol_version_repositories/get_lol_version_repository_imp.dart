import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/layers/data/dtos/lol_version/lol_version_dto.dart';
import 'package:legends_panel/app/layers/domain/repositories/lol_version/get_lol_version_repository.dart';

import '../../datasources/contracts/lol_version_datasources/get_lol_version_datasource.dart';

class GetLolVersionRepositoryImp implements GetLolVersionRepository {

  final GetLolVersionDataSource _getLolVersionDataSource;

  GetLolVersionRepositoryImp(this._getLolVersionDataSource);

  @override
  Future<Either<Exception, LolVersionDto>> call() async {
    return await _getLolVersionDataSource();
  }

}