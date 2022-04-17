import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/layers/data/datasources/contracts/queue_datasources/get_queues_datasource.dart';
import 'package:legends_panel/app/layers/data/dtos/queue/queue_wrapper_dto.dart';
import 'package:legends_panel/app/layers/domain/repositories/queue/get_queues_repository.dart';

class GetQueuesRepositoryImp implements GetQueuesRepository {

  final GetQueuesDataSource getQueuesDataSource;

  GetQueuesRepositoryImp(this.getQueuesDataSource);

  @override
  Future<Either<Exception, QueueWrapperDto>> call() async {
    return await getQueuesDataSource();
  }

}