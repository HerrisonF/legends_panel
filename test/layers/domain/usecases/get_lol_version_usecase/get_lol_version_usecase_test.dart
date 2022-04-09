import 'package:flutter_test/flutter_test.dart';
import 'package:legends_panel/app/core/data/services/dio_http_service_imp.dart';
import 'package:legends_panel/app/layers/data/datasources/get_lol_version_datasource.dart';
import 'package:legends_panel/app/layers/data/datasources/remote/get_lol_version_remote_datasource_imp.dart';
import 'package:legends_panel/app/layers/data/repositories/get_lol_version_repository_imp.dart';
import 'package:legends_panel/app/layers/domain/entities/lol_version_entity.dart';
import 'package:legends_panel/app/layers/domain/usecases/get_lol_version/get_lol_version_usecase.dart';
import 'package:legends_panel/app/layers/domain/usecases/get_lol_version/get_lol_version_usecase_imp.dart';

main() {

  test('Should return versions', () async {
    GetLolVersionDataSource dataSource = GetLolVersionRemoteDataSourceImp(DioHttpServiceImp());
    GetLolVersionUseCase useCase =
    GetLolVersionUseCaseImp(GetLolVersionRepositoryImp(dataSource));

    var result = await useCase();
    late LolVersionEntity resultExpected;

    result.fold((l) => null, (r) => resultExpected = r);
    expect(
      resultExpected.versions,
      isNotEmpty,
    );
  });
}
