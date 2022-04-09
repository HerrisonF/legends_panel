import 'package:flutter_test/flutter_test.dart';
import 'package:legends_panel/app/layers/data/datasources/get_lol_version_datasource.dart';
import 'package:legends_panel/app/layers/data/datasources/local/get_lol_version_local_datasource_imp.dart';
import 'package:legends_panel/app/layers/data/repositories/get_lol_version_repository_imp.dart';
import 'package:legends_panel/app/layers/domain/entities/lol_version_entity.dart';
import 'package:legends_panel/app/layers/domain/repositories/get_lol_version_repository.dart';

main() {
  GetLolVersionDataSource dataSource = GetLolVersionLocalDataSourceImp();
  GetLolVersionRepository repository = GetLolVersionRepositoryImp(dataSource);

  test('Should return versions', () async {
    var result = await repository();
    late LolVersionEntity resultExpect;
    result.fold((l) => null, (r) => resultExpect = r);
    expect(resultExpect.versions, isNotEmpty);
  });
}
