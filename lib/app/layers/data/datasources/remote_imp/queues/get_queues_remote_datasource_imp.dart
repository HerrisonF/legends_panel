import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/domain/services/http_services.dart';
import 'package:legends_panel/app/core/utils/apis_utils.dart';
import 'package:legends_panel/app/layers/data/datasources/contracts/queue_datasources/get_queues_datasource.dart';
import 'package:legends_panel/app/layers/data/dtos/queue/queue_wrapper_dto.dart';

class GetQueuesRemoteDataSourceImp implements GetQueuesDataSource {
  final HttpService _httpService;

  GetQueuesRemoteDataSourceImp(this._httpService);

  @override
  Future<Either<Exception, QueueWrapperDto>> call() async {
    try {
      var result = await _httpService.get(
        path: API.PATH_REQUEST_QUEUES,
        baseUrl: API.riotStaticDataUrl,
      );
      QueueWrapperDto wrap = QueueWrapperDto.fromJson(result.data);
      return Right(wrap);
    } catch (e) {
      return Left(Exception('Falha no response no datasource de queue'));
    }
  }
}
