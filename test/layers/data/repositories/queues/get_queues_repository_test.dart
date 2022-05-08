import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:legends_panel/app/core/data/services/dio_http_service_imp.dart';
import 'package:legends_panel/app/layers/data/datasources/contracts/queue_datasources/get_queues_datasource.dart';
import 'package:legends_panel/app/layers/data/datasources/remote_imp/queues/get_queues_remote_datasource_imp.dart';
import 'package:legends_panel/app/layers/data/dtos/queue/queue_dto.dart';
import 'package:legends_panel/app/layers/data/dtos/queue/queue_wrapper_dto.dart';
import 'package:legends_panel/app/decorators/queues_decorator/queues_cache_repository_decorator.dart';
import 'package:legends_panel/app/layers/data/repositories/queue_repositories/get_queue_repository_imp.dart';
import 'package:legends_panel/app/layers/domain/repositories/queue/get_queues_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  GetQueuesDataSource dataSource =
      GetQueuesRemoteDataSourceImp(DioHttpServiceImp());
  GetQueuesRepository repository = GetQueuesRepositoryImp(dataSource);
  QueuesCacheRepositoryDecorator decorator =
      QueuesCacheRepositoryDecorator(repository);

  test('Should return queues', () async {
    var result = await decorator();
    late QueueWrapperDto resultExpect;

    result.fold((error) => null, (success) => resultExpect = success);

    expect(resultExpect.hasQueues(), true);
  });

  test('Should return queues without internet', () async {
    late QueueWrapperDto resultExpect;
    try {
      SharedPreferences.setMockInitialValues({});
      var prefs = await SharedPreferences.getInstance();
      QueueWrapperDto queueWrapperDto = QueueWrapperDto(queues: [
        QueueDto(
          queueId: 325,
          map: 'Summoner\'s Rift',
          description: 'All Random games',
          notes: '',
        ),
        QueueDto(
          queueId: 325,
          map: 'Summoner\'s Rift',
          description: 'All Random games',
          notes: '',
        ),
      ]);
      String jsonQueue = jsonEncode(queueWrapperDto.toJson());
      prefs.setString("queue", jsonQueue);
      var jsonQueueString = prefs.getString("queue");
      if(jsonQueueString != null){
        dynamic queues = jsonDecode(jsonQueueString);
        resultExpect = QueueWrapperDto.fromLocalJson(queues);
      }
    } catch (e) {
      print(e);
    }
    expect(resultExpect.hasQueues(), true);
  });
}
