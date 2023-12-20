import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/queue/queue_wrapper_dto.dart';

abstract class QueuesRepository {
  Future<Either<Failure, QueueWrapperDto>> call();
}