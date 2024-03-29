import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/utils/apis_utils.dart';
import 'package:legends_panel/app/layers/data/dtos/lol_version/lol_version_dto.dart';
import 'package:legends_panel/app/core/domain/services/http_services.dart';

import '../../contracts/lol_version_datasources/get_lol_version_datasource.dart';

class GetLolVersionRemoteDataSourceImp implements GetLolVersionDataSource {
  final HttpService _httpService;

  GetLolVersionRemoteDataSourceImp(this._httpService);

  @override
  Future<Either<Exception, LolVersionDto>> call() async {
    try {
      var result = await _httpService.get(
        path: API.PATH_REQUEST_LOL_VERSION,
        baseUrl: API.riotDragonUrl,
      );
      return Right(LolVersionDto.fromJson(result.data));
    } catch (e) {
      return Left(Exception('Falha no request do datasource lol version'));
    }
  }
}
