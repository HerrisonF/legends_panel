import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/lol_constants/queue_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/queue_model.dart';

abstract class SplashRepositoryLocal {
  Future<Either<Failure, QueueModel>> fetchQueuesLocal();
  Future<Either<Failure, bool>> saveQueues({required QueueDto dto});
}