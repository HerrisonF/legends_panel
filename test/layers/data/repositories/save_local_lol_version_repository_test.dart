import 'package:flutter_test/flutter_test.dart';
import 'package:legends_panel/app/layers/data/datasources/local/save_local_lol_version_datasource_imp.dart';
import 'package:legends_panel/app/layers/data/datasources/save_lol_version_datasource.dart';
import 'package:legends_panel/app/layers/data/dtos/lol_version_dto.dart';
import 'package:legends_panel/app/layers/data/repositories/save_lol_version_repository_imp.dart';
import 'package:legends_panel/app/layers/domain/repositories/save_lol_version_repository.dart';

main(){

  test('Should return true when try to save', () async {
    SaveLolVersionDataSource dataSource = SaveLocalLolVersionDataSourceImp();
    SaveLolVersionRepository repository = SaveLolVersionRepositoryImp(dataSource);
    var result = await repository(LolVersionDto(versions: ['1', '2', '3']));
    expect(result.isRight(), true);
  });
}