import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/utils/apis.utils.dart';
import 'package:legends_panel/app/layers/data/datasources/get_lol_version_datasource.dart';
import 'package:legends_panel/app/layers/data/dtos/lol_version_dto.dart';
import 'package:legends_panel/app/core/domain/services/http_services.dart';
import 'package:legends_panel/app/layers/domain/entities/lol_version_entity.dart';

class GetLolVersionRemoteDataSourceImp implements GetLolVersionDataSource {

  final HttpService _httpService;

  GetLolVersionRemoteDataSourceImp(this._httpService);

  @override
  Future<Either<Exception, LolVersionEntity>> call() async {
    try{
      var result = await _httpService.get(API.REQUEST_LOL_VERSION);
      return Right(LolVersionDto.fromMap(result.data));
    }catch(e){
      return Left(Exception('Falha no datasource'));
    }
  }

}