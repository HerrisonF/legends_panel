import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/layers/data/dtos/queue/queue_wrapper_dto.dart';

abstract class GetQueuesDataSource {

  Future<Either<Exception, QueueWrapperDto>> call();

}