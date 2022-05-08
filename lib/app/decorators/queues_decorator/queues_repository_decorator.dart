import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/layers/data/dtos/queue/queue_wrapper_dto.dart';
import 'package:legends_panel/app/layers/domain/repositories/queue/get_queues_repository.dart';

class QueuesRepositoryDecorator implements GetQueuesRepository {

  final GetQueuesRepository _getQueuesRepository;

  QueuesRepositoryDecorator(this._getQueuesRepository);

  @override
  Future<Either<Exception, QueueWrapperDto>> call() async {
    return await _getQueuesRepository();
  }

}