import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/layers/domain/entities/lol_version/lol_version_entity.dart';
import 'package:legends_panel/app/layers/domain/repositories/lol_version/get_lol_version_repository.dart';

import 'get_lol_version_usecase.dart';

class GetLolVersionUseCaseImp implements GetLolVersionUseCase {

  final GetLolVersionRepository _getLolVersionRepository;

  GetLolVersionUseCaseImp(this._getLolVersionRepository);

  @override
  Future<Either<Exception, LolVersionEntity>> call() async {
    return await _getLolVersionRepository();
  }

}