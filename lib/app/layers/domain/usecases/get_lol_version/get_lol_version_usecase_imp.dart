import 'package:legends_panel/app/domain/entities/lol_version_entity.dart';
import 'package:legends_panel/app/domain/usecases/get_lol_version/get_lol_version_usecase.dart';

class GetLolVersionUseCaseImp implements GetLolVersionUseCase {
  @override
  LolVersionEntity call() {
    print('versao');
    return LolVersionEntity(versions: ['123']);
  }

}