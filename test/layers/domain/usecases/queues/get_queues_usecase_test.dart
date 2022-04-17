import 'package:flutter_test/flutter_test.dart';
import 'package:legends_panel/app/core/data/services/dio_http_service_imp.dart';
import 'package:legends_panel/app/layers/data/datasources/contracts/queue_datasources/get_queues_datasource.dart';
import 'package:legends_panel/app/layers/data/datasources/remote_imp/queues/get_queues_remote_datasource_imp.dart';
import 'package:legends_panel/app/layers/data/dtos/queue/queue_wrapper_dto.dart';
import 'package:legends_panel/app/layers/data/repositories/queue_repositories/get_queue_repository_imp.dart';
import 'package:legends_panel/app/layers/domain/usecases/queue/get_queues_usecase.dart';
import 'package:legends_panel/app/layers/domain/usecases/queue/get_queues_usecase_imp.dart';

main() {
  test('Should queues not be empty', () async {
    GetQueuesDataSource dataSource =
        GetQueuesRemoteDataSourceImp(DioHttpServiceImp());
    GetQueuesUseCase useCase =
        GetQueuesUseCaseImp(GetQueuesRepositoryImp(dataSource));

    var result = await useCase();
    late QueueWrapperDto resultExpected;

    result.fold((l) => null, (r) => resultExpected = r);

    expect(resultExpected.hasQueues(), true);
  });
}
