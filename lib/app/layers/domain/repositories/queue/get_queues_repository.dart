import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/layers/data/dtos/queue/queue_wrapper_dto.dart';

abstract class GetQueuesRepository {
  Future<Either<Exception, QueueWrapperDto>> call();
}