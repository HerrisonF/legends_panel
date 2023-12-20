import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/modules/app_initialization/data/dtos/queue/queue_wrapper_dto.dart';
import 'package:legends_panel/app/modules/app_initialization/data/repositories/queue/queues_repository.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/usecases/queue/get_queues_usecase.dart';

class GetQueuesUseCaseImp implements GetQueuesUseCase {
  late QueuesRepository queuesRepository;

  GetQueuesUseCaseImp({
    required this.queuesRepository,
  });

  @override
  Future<Either<Failure, QueueWrapperDto>> call() async {
    return await queuesRepository();
  }
}
