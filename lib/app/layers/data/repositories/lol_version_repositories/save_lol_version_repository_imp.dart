import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/layers/data/dtos/lol_version/lol_version_dto.dart';
import 'package:legends_panel/app/layers/domain/repositories/lol_version/save_lol_version_repository.dart';

import '../../datasources/contracts/lol_version_datasources/save_lol_version_datasource.dart';

class SaveLolVersionRepositoryImp implements SaveLolVersionRepository {

  final SaveLolVersionDataSource _saveLolVersionDataSource;

  SaveLolVersionRepositoryImp(this._saveLolVersionDataSource);


  @override
  Future<Either<Exception, bool>> call(LolVersionDto lolVersionDto) async {
    return await _saveLolVersionDataSource(lolVersionDto);
  }

}