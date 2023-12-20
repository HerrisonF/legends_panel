import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/core/http_configuration/api_paths_endpoints.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/queue/queue_wrapper_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/repositories/queue/queues_repository.dart';

class QueuesRepositoryImpl implements QueuesRepository {
  late HttpServices httpServices;

  QueuesRepositoryImpl({required this.httpServices});

  @override
  Future<Either<Failure, QueueWrapperDto>> call() async {
    try {
      final response = await httpServices.get(
          url: API.riotStaticDataUrl,
          path: '/docs/lol/queues.json',
          origin: "QUEUESREPOSITORY");

      return response.fold(
        (l) {
          return Left(
            Failure(message: "ERRO"),
          );
        },
        (r) {
          QueueWrapperDto wrap = QueueWrapperDto.fromJson(r.data);
          return Right(wrap);
        },
      );
    } catch (e) {
      return Left(
        Failure(message: 'Falha no response no datasource de queue'),
      );
    }
  }
}
