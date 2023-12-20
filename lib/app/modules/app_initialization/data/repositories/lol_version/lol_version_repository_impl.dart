import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/core/http_configuration/api_paths_endpoints.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_version/lol_version_dto.dart';

class GetLolVersionRepositoryImpl {
  late HttpServices httpServices;

  GetLolVersionRepositoryImpl({
    required this.httpServices,
  });

  @override
  Future<Either<Failure, LolVersionDto>> call() async {
    try{
      final response = await httpServices.get(
        url: API.riotDragonUrl,
        path: '/api/versions.json', origin: 'GETLOLVERSIONREPOSITORY',
      );
      return response.fold((l) {
        return Left(
          Failure(message: "Erro de versao"),
        );
      }, (r) {
        return Right(
          LolVersionDto.fromJson(r.data),
        );
      });
    }catch(e){
      return Left(
        Failure(message: "Erro de versao"),
      );
    }
  }
}
