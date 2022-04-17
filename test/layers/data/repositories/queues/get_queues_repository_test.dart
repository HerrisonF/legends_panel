import 'package:flutter_test/flutter_test.dart';
import 'package:legends_panel/app/core/data/services/dio_http_service_imp.dart';
import 'package:legends_panel/app/layers/data/datasources/contracts/queue_datasources/get_queues_datasource.dart';
import 'package:legends_panel/app/layers/data/datasources/remote_imp/queues/get_queues_remote_datasource_imp.dart';
import 'package:legends_panel/app/layers/data/dtos/queue/queue_wrapper_dto.dart';
import 'package:legends_panel/app/layers/data/repositories/queue_repositories/get_queue_repository_imp.dart';
import 'package:legends_panel/app/layers/domain/repositories/queue/get_queues_repository.dart';

main(){

  GetQueuesDataSource dataSource = GetQueuesRemoteDataSourceImp(DioHttpServiceImp());
  GetQueuesRepository repository = GetQueuesRepositoryImp(dataSource);

  test('Should return queues', () async {
    var result = await repository();
    late QueueWrapperDto resultExpect;

    result.fold((l) => null, (r) => resultExpect = r);

    expect(resultExpect.hasQueues(), true);
  });

}