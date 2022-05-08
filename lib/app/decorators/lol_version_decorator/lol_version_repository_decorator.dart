import 'package:dartz/dartz.dart';
import 'package:legends_panel/app/layers/data/dtos/lol_version/lol_version_dto.dart';
import 'package:legends_panel/app/layers/domain/repositories/lol_version/get_lol_version_repository.dart';

class LolVersionRepositoryDecorator implements GetLolVersionRepository {

  final GetLolVersionRepository _getLolVersionRepository;

  LolVersionRepositoryDecorator(this._getLolVersionRepository);

  @override
  Future<Either<Exception, LolVersionDto>> call() async {
    return await _getLolVersionRepository();
  }

}